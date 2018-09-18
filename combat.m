function [myFleetAns, opFleetAns] = combat(myFleet, opFleet, environment)
%%  combat 单次战斗
 %  [myFleetAns, opFleetAns] = combat(myFleet, opFleet, environment)
 %
 %  myFleet = 我方舰队
 %  opFleet = 敌方舰队
 %  environment = 航向、阵型
 %  myFleetAns = 我方舰队结束状态
 %  opFleetAns = 敌方舰队结束状态
 
%%  主函数

global fpLog;
    %% 获取环境
    environment = EnvironmentCal(myFleet,opFleet, environment);
    fprintf(fpLog, '航向： %s，', environment.hx);
    if environment.reconnaissance == 1
        fprintf(fpLog, '索敌成功。\n');
    else
        fprintf(fpLog, '索敌失败。\n');
    end
    %   给定航向系数
    if strcmpi(environment.hx, 'T优')
        environment.myCourse.coef = 1.15;
        environment.opCourse.coef = 0.65;
    elseif strcmpi(environment.hx, '同航')
        environment.myCourse.coef = 1;
        environment.opCourse.coef = 1;
    elseif strcmpi(environment.hx, '反航')
        environment.myCourse.coef = 0.8;
        environment.opCourse.coef = 0.8;
    else
        environment.myCourse.coef = 0.65;
        environment.opCourse.coef = 1.15;
    end
    %给定阵型
    % environment.myForm.name = 'DoubleVertical';
    environment.myForm.name = 'Trapezoid';
    environment.myForm.coef = 1;
    environment.myForm.coefTorpedo = 1;
    environment.myForm.coefNight = 1;
    environment.opForm.name = 'SingleVertical';
    environment.opForm.coef = 1;
    environment.opForm.coefTorpedo = 1;
    environment.opForm.coefNight = 1;
    % 每次战斗需重置的BUFF阶段TODO
    if contains(environment.myForm.name, 'Trapezoid')
        myFleet = setShipValue(myFleet, 'crit', 0.2);
        myFleet = setShipValue(myFleet, 'opCrit', 0.05);
    end
    %% 航空战初始化 Airinitial 
    % 迎击顺序初始化
    for i = 1 : length(myFleet)
        myFleet(i).AANo = 1;
    end
    for i = 1 : length(opFleet)
        opFleet(i).AANo = 1;
    end
    
    %% 刷新状态
    myFleetAns = myFleet;
    opFleetAns = opFleet;

    %% 航空战 airBattle
    % 计算双方制空值
    environment.airPower = getAirPower(myFleetAns, opFleetAns);
    % 计算制空载损（TODO）
%     [myFleetAns, opFleetAns] = airFightLoss(myFleetAns, opFleetAns, environment.airPower);
    % 我方轰炸
    stat = 1;
    myOrder = AircraftOrder(myFleetAns); % 获取我方攻击舰迎击顺序
    for i = 1:length(myOrder)
        attacker = myFleetAns(myOrder(i));
        targetList = getTargetList(opFleet); % 可以选择到已被击沉的目标，所以必须以敌方舰队原型为目标，此处可以考虑改为：先获取所有能够攻击的飞机，根据其数量获取可重复目标表，再以飞机作为攻击者循环
        targetNo = chooseTargeti(targetList, length(attacker.hangar), myFleet, opFleet,"airday"); % 获取轰炸目标
         
        for targetIndex = 1:length(targetNo)
            target = opFleetAns(targetNo(targetIndex));
            [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex);
            myFleetAns(myOrder(i)) = attacker;
            opFleetAns(targetNo(targetIndex)) = target;
        end
    end
    stat = 2;
    opOrder = AircraftOrder(opFleetAns); % 获取我方攻击舰迎击顺序
    for i = 1:length(opOrder)
        attacker = opFleetAns(opOrder(i));
        targetList = getTargetList(myFleetAns);
        targetNo = chooseTargeti(targetList, length(attacker.hangar), opFleet, myFleet,"airday"); % 获取轰炸目标
        for targetIndex = 1:length(targetNo)
            target = myFleetAns(targetNo(targetIndex));
            [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex);
            opFleetAns(opOrder(i)) = attacker;
            myFleetAns(targetNo(targetIndex)) = target;
        end
    end   
    %% 首轮炮击
    %   获取炮序
    myOrder = FireOrder_Phase1(myFleetAns);
    opOrder = FireOrder_Phase1(opFleetAns);

    for i = 1:max(length(myOrder), length(opOrder))
        % 我方回合
        if (~checkFleetStat(opFleet)) % 已击沉全部敌舰
            fprintf(fpLog, '敌方舰队全灭，战斗结束.\n');
            return;
        end
        stat = 1;
        attacker = myFleetAns(myOrder(i));
        if identity(attacker.skill, "决胜之兵")
            types = ["BB", "BC", "BbV"];
            targetList = getTargetList(opFleetAns, types);
        else
            targetList = getTargetList(opFleetAns);
        end
        targetNo = chooseTarget(targetList, 1, myFleet, opFleet,"day1");

        for targetIndex = 1:length(targetNo)
            target = opFleetAns(targetNo(targetIndex));
            [attacker, target] = shell1(attacker, target, environment, stat,opFleet);
            myFleetAns(myOrder(i)) = attacker;
            opFleetAns(targetNo) = target;
        end
        % 敌方回合
        stat = 2;
        attacker = opFleetAns(opOrder(i));
        targetList = getTargetList(myFleetAns);
        %targetNo = chooseTarget(targetList, 1);        
        targetNo = chooseTarget(targetList, 1, opFleet, myFleet,"day");
        target = myFleetAns(targetNo);
        [attacker, target] = shell1(attacker, target, environment, stat,myFleet);
        opFleetAns(opOrder(i)) = attacker;
        myFleetAns(targetNo) = target;
    end

    %% 次轮炮击
    myOrder = FireOrder_Phase2(myFleetAns);
    opOrder = FireOrder_Phase2(opFleetAns);

    for i = 1:max(length(myOrder), length(opOrder))
        % 我方回合        
        if (~checkFleetStat(opFleet)) % 已击沉全部敌舰
            fprintf(fpLog, '敌方舰队全灭，战斗结束.\n');
            return;
        end
        stat = 1;
        attacker = myFleetAns(myOrder(i));
        if identity(attacker.skill, "决胜之兵")
            types = ["BB", "BC", "BbV"];
            targetList = getTargetList(opFleetAns, types);
        else
            targetList = getTargetList(opFleetAns);
        end
        targetNo = chooseTarget(targetList, 1, myFleet, opFleet,"day");
        %targetNo = chooseTarget(targetList, 1);
        for targetIndex = 1:length(targetNo)
            target = opFleetAns(targetNo(targetIndex));
            [attacker, target] = shell2(attacker, target, environment, stat,opFleet);
            myFleetAns(myOrder(i)) = attacker;
            opFleetAns(targetNo) = target;
        end
        % 敌方回合
        attacker = opFleetAns(opOrder(i));
        targetList = getTargetList(myFleetAns);
        %targetNo = chooseTarget(targetList, 1);
        targetNo = chooseTarget(targetList, 1, opFleet, myFleet,"day");
        target = myFleetAns(targetNo);
        stat = 2;
        [attacker, target] = shell2(attacker, target, environment, stat, myFleet);
        opFleetAns(opOrder(i)) = attacker;
        myFleetAns(targetNo) = target;
    end
    
    %% 鱼雷战torpedo
    % 我方回合
    stat = 1;
    myOrder = torpedoOrder(myFleetAns);
    targetList = getTargetList(opFleetAns);
    if (isempty(targetList))
        fprintf(fpLog, '敌方舰队全灭，战斗结束.\n');
        return;
    end
    targetNo = chooseTargeti(targetList, length(myOrder), myFleet, opFleet,"day"); % 能够出现重复目标
    
    for targetIndex = 1:length(targetNo)
        attacker = myFleetAns(myOrder(targetIndex));
        target = opFleetAns(targetNo(targetIndex));
        [attacker, target] = torpedo(attacker, target, environment, stat);
        myFleetAns(myOrder(targetIndex)) = attacker;
        opFleetAns(targetNo(targetIndex)) = target;
    end
    % 敌方回合
    stat = 2;
    opOrder = torpedoOrder(opFleetAns);
    targetList = getTargetList(myFleetAns);
    targetNo = chooseTargeti(targetList, length(opOrder), opFleet, myFleet,"day"); % 能够出现重复目标

    for targetIndex = 1:length(targetNo)
        attacker = opFleetAns(opOrder(targetIndex));
        target = myFleetAns(targetNo(targetIndex));
        [attacker, target] = torpedo(attacker, target, environment, stat);
        opFleetAns(opOrder(targetIndex)) = attacker;
        myFleetAns(targetNo(targetIndex)) = target;
    end

    %% 夜战
    myOrder = FireOrder_Night(myFleetAns);
    opOrder = FireOrder_Night(opFleetAns);

    for i = 1:max(length(myOrder), length(opOrder))
        % 我方回合
        stat = 1;
        attacker = myFleetAns(myOrder(i));
        targetList = getTargetList(opFleetAns);
        if (isempty(targetList))
            fprintf(fpLog, '敌方舰队全灭，战斗结束.\n');
            return;
        end
        targetNo = chooseTarget(targetList, 1, myFleet, opFleet,"night");
        for targetIndex = 1:length(targetNo)
            target = opFleetAns(targetNo(targetIndex));
            [attacker, target] = night(attacker, target, environment, stat);
            myFleetAns(myOrder(i)) = attacker;
            opFleetAns(targetNo) = target;
        end
        % 敌方回合
        attacker = opFleetAns(opOrder(i));
        targetList = getTargetList(myFleetAns);
        targetNo = chooseTarget(targetList, 1, opFleet, myFleet,"night");
        target = myFleetAns(targetNo);
        stat = 2;
        [attacker, target] = night(attacker, target, environment, stat);
        opFleetAns(opOrder(i)) = attacker;
        myFleetAns(targetNo) = target;
    end
end


