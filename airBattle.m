function [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex)
%%  airBattle % 航空战单次攻击。使用攻击方舰娘给定序数的飞机攻击目标（TODO）
 %  [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex)
 %
 %  attcker     = 攻击者
 %  target      = 靶舰
 %  environment = 环境参数
 %  stat        = 当前状态（我方攻击/敌方攻击）
 %  targetIndex = 指定攻击机

%%  主函数
global fpLog;
global messenger;
    if attacker.aircraft(targetIndex).type ~= 1 && attacker.aircraft(targetIndex).type ~= 2 % 不是轰炸(代号1) and 攻击机（2）
        return;
    elseif attacker.aircraft(targetIndex).count <= 0 % 已无舰载机
        messenger = [messenger, num2str(targetIndex), '号机库已无舰载机，跳过'];
        fprintf(fpLog, '航空战： %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    % 航空战中已被击沉的航母飞机是否能造成伤害？目前假设可以造成伤害，计大破系数(TODO)
%     if attacker.hp <= 0 % 攻击方已被击沉
%         messenger = [messenger, '已沉没，跳过'];
%         fprintf(fpLog, '航空战： %s %s.\n', attacker.name, messenger);
%         messenger = [];
%         return;
%     end
    attacker.attackNum = attacker.attackNum+1;% 数据记录
    %count = min(floor(attacker.firepower/5)+3, attacker.aircraft(targetIndex).count); % 放飞数
    count = SinPlAirNum(attacker,targetIndex);
    %%这里可以直接调用SinPlAirNum函数 count = SinPlAirNum(attacker,targetIndex)
    
    % 计算防空击坠，已被击沉的目标无后续对空击坠
    if target.hp > 0
        loss = floor(rand(1) * target.AA * 0.618^(target.AANo-1) / 10); % AANO记录该舰第几次迎击飞机，初始为1
        loss = min(loss, count);
        target.AANo = target.AANo + 1;
        attacker.aircraft(targetIndex).loss = attacker.aircraft(targetIndex).loss + loss; % 记录本次战斗该格子的总损失（加入制空击坠后会用到）
    else
        loss = 0;
    end
    % 判定命中(航空战命中公式？？？假定为炮击战命中+制空权命中。TODO)
    if stat == 1
        hitRate = getHitRateCV(attacker, target, environment, stat)+environment.airPower;
        % 祖传补正
        hitRate = min(hitRate, 0.95);
        hitRate = max(hitRate, 0.05);
    else
        hitRate = getHitRate(attacker, target, environment, stat)-environment.airPower;
        % 祖传补正
        hitRate = min(hitRate, 0.95);
        hitRate = max(hitRate, 0.05);
    end
    if rand() > hitRate
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '航空战： %s 的 %d号机 攻击 %s %s，被击坠 %d 架(%d -> %d)\n', ...
            attacker.name, targetIndex, target.name, messenger, ...
            loss, attacker.aircraft(targetIndex).count, ...
            attacker.aircraft(targetIndex).count - loss);
        messenger = [];
        target.missNum = target.missNum+1;% 数据记录
        attacker.aircraft(targetIndex).count = attacker.aircraft(targetIndex).count - loss; % 记录本次战斗后该格子的剩余飞机数
        return;
    end
    % 计算伤害
    damage = AirBattleBomb_CV(attacker, target, environment, stat, targetIndex);
    %修正伤害
    damage = fixDamage(damage, attacker, target, stat);
    targetHp0 = target.hp ;
    target.hp = target.hp - damage;
    if target.hp < 0
        target.hp = 0;
    end
    % 输出战斗日志
    attacker.hitNum = attacker.hitNum+1;% 数据记录
    if strfind(messenger, '暴击')
        attacker.critNum = attacker.critNum+1;% 数据记录
    end
    fprintf(fpLog, '航空战： %s 的 %d号机 攻击 %s %s造成 %d 点伤害(%d -> %d)，被击坠 %d 架(%d -> %d)\n', ...
            attacker.name, targetIndex, target.name, messenger, damage, targetHp0, target.hp, ...
            attacker.aircraft(targetIndex).loss, attacker.aircraft(targetIndex).count, ...
            attacker.aircraft(targetIndex).count - attacker.aircraft(targetIndex).loss);
    messenger = [];
    attacker.aircraft(targetIndex).count = attacker.aircraft(targetIndex).count - loss; % 记录本次战斗后该格子的剩余飞机数
end



