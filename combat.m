function [myFleetAns, opFleetAns] = combat(myFleet, opFleet, environment)
%%  combat ����ս��
 %  [myFleetAns, opFleetAns] = combat(myFleet, opFleet, environment)
 %
 %  myFleet = �ҷ�����
 %  opFleet = �з�����
 %  environment = ��������
 %  myFleetAns = �ҷ����ӽ���״̬
 %  opFleetAns = �з����ӽ���״̬
 
%%  ������

global fpLog;
    %% ��ȡ����
    environment = EnvironmentCal(myFleet,opFleet, environment);
    fprintf(fpLog, '���� %s��', environment.hx);
    if environment.reconnaissance == 1
        fprintf(fpLog, '���гɹ���\n');
    else
        fprintf(fpLog, '����ʧ�ܡ�\n');
    end
    %   ��������ϵ��
    if strcmpi(environment.hx, 'T��')
        environment.myCourse.coef = 1.15;
        environment.opCourse.coef = 0.65;
    elseif strcmpi(environment.hx, 'ͬ��')
        environment.myCourse.coef = 1;
        environment.opCourse.coef = 1;
    elseif strcmpi(environment.hx, '����')
        environment.myCourse.coef = 0.8;
        environment.opCourse.coef = 0.8;
    else
        environment.myCourse.coef = 0.65;
        environment.opCourse.coef = 1.15;
    end
    %��������
    % environment.myForm.name = 'DoubleVertical';
    environment.myForm.name = 'Trapezoid';
    environment.myForm.coef = 1;
    environment.myForm.coefTorpedo = 1;
    environment.myForm.coefNight = 1;
    environment.opForm.name = 'SingleVertical';
    environment.opForm.coef = 1;
    environment.opForm.coefTorpedo = 1;
    environment.opForm.coefNight = 1;
    % ÿ��ս�������õ�BUFF�׶�TODO
    if contains(environment.myForm.name, 'Trapezoid')
        myFleet = setShipValue(myFleet, 'crit', 0.2);
        myFleet = setShipValue(myFleet, 'opCrit', 0.05);
    end
    %% ����ս��ʼ�� Airinitial 
    % ӭ��˳���ʼ��
    for i = 1 : length(myFleet)
        myFleet(i).AANo = 1;
    end
    for i = 1 : length(opFleet)
        opFleet(i).AANo = 1;
    end
    
    %% ˢ��״̬
    myFleetAns = myFleet;
    opFleetAns = opFleet;

    %% ����ս airBattle
    % ����˫���ƿ�ֵ
    environment.airPower = getAirPower(myFleetAns, opFleetAns);
    % �����ƿ�����TODO��
%     [myFleetAns, opFleetAns] = airFightLoss(myFleetAns, opFleetAns, environment.airPower);
    % �ҷ���ը
    stat = 1;
    myOrder = AircraftOrder(myFleetAns); % ��ȡ�ҷ�������ӭ��˳��
    for i = 1:length(myOrder)
        attacker = myFleetAns(myOrder(i));
        targetList = getTargetList(opFleet); % ����ѡ���ѱ�������Ŀ�꣬���Ա����Եз�����ԭ��ΪĿ�꣬�˴����Կ��Ǹ�Ϊ���Ȼ�ȡ�����ܹ������ķɻ���������������ȡ���ظ�Ŀ������Էɻ���Ϊ������ѭ��
        targetNo = chooseTargeti(targetList, length(attacker.hangar), myFleet, opFleet,"airday"); % ��ȡ��ըĿ��
         
        for targetIndex = 1:length(targetNo)
            target = opFleetAns(targetNo(targetIndex));
            [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex);
            myFleetAns(myOrder(i)) = attacker;
            opFleetAns(targetNo(targetIndex)) = target;
        end
    end
    stat = 2;
    opOrder = AircraftOrder(opFleetAns); % ��ȡ�ҷ�������ӭ��˳��
    for i = 1:length(opOrder)
        attacker = opFleetAns(opOrder(i));
        targetList = getTargetList(myFleetAns);
        targetNo = chooseTargeti(targetList, length(attacker.hangar), opFleet, myFleet,"airday"); % ��ȡ��ըĿ��
        for targetIndex = 1:length(targetNo)
            target = myFleetAns(targetNo(targetIndex));
            [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex);
            opFleetAns(opOrder(i)) = attacker;
            myFleetAns(targetNo(targetIndex)) = target;
        end
    end   
    %% �����ڻ�
    %   ��ȡ����
    myOrder = FireOrder_Phase1(myFleetAns);
    opOrder = FireOrder_Phase1(opFleetAns);

    for i = 1:max(length(myOrder), length(opOrder))
        % �ҷ��غ�
        if (~checkFleetStat(opFleet)) % �ѻ���ȫ���н�
            fprintf(fpLog, '�з�����ȫ��ս������.\n');
            return;
        end
        stat = 1;
        attacker = myFleetAns(myOrder(i));
        if identity(attacker.skill, "��ʤ֮��")
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
        % �з��غ�
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

    %% �����ڻ�
    myOrder = FireOrder_Phase2(myFleetAns);
    opOrder = FireOrder_Phase2(opFleetAns);

    for i = 1:max(length(myOrder), length(opOrder))
        % �ҷ��غ�        
        if (~checkFleetStat(opFleet)) % �ѻ���ȫ���н�
            fprintf(fpLog, '�з�����ȫ��ս������.\n');
            return;
        end
        stat = 1;
        attacker = myFleetAns(myOrder(i));
        if identity(attacker.skill, "��ʤ֮��")
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
        % �з��غ�
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
    
    %% ����սtorpedo
    % �ҷ��غ�
    stat = 1;
    myOrder = torpedoOrder(myFleetAns);
    targetList = getTargetList(opFleetAns);
    if (isempty(targetList))
        fprintf(fpLog, '�з�����ȫ��ս������.\n');
        return;
    end
    targetNo = chooseTargeti(targetList, length(myOrder), myFleet, opFleet,"day"); % �ܹ������ظ�Ŀ��
    
    for targetIndex = 1:length(targetNo)
        attacker = myFleetAns(myOrder(targetIndex));
        target = opFleetAns(targetNo(targetIndex));
        [attacker, target] = torpedo(attacker, target, environment, stat);
        myFleetAns(myOrder(targetIndex)) = attacker;
        opFleetAns(targetNo(targetIndex)) = target;
    end
    % �з��غ�
    stat = 2;
    opOrder = torpedoOrder(opFleetAns);
    targetList = getTargetList(myFleetAns);
    targetNo = chooseTargeti(targetList, length(opOrder), opFleet, myFleet,"day"); % �ܹ������ظ�Ŀ��

    for targetIndex = 1:length(targetNo)
        attacker = opFleetAns(opOrder(targetIndex));
        target = myFleetAns(targetNo(targetIndex));
        [attacker, target] = torpedo(attacker, target, environment, stat);
        opFleetAns(opOrder(targetIndex)) = attacker;
        myFleetAns(targetNo(targetIndex)) = target;
    end

    %% ҹս
    myOrder = FireOrder_Night(myFleetAns);
    opOrder = FireOrder_Night(opFleetAns);

    for i = 1:max(length(myOrder), length(opOrder))
        % �ҷ��غ�
        stat = 1;
        attacker = myFleetAns(myOrder(i));
        targetList = getTargetList(opFleetAns);
        if (isempty(targetList))
            fprintf(fpLog, '�з�����ȫ��ս������.\n');
            return;
        end
        targetNo = chooseTarget(targetList, 1, myFleet, opFleet,"night");
        for targetIndex = 1:length(targetNo)
            target = opFleetAns(targetNo(targetIndex));
            [attacker, target] = night(attacker, target, environment, stat);
            myFleetAns(myOrder(i)) = attacker;
            opFleetAns(targetNo) = target;
        end
        % �з��غ�
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


