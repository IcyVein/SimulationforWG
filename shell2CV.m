function [attacker, target] = shell2CV(attacker, target, environment, stat, opFleet)
%%  次轮炮击战cv攻击函数
 %  [attacker, target] = DayPhaseCV(attacker, target, environment, stat)
 
 %  attacker = 攻击方
 %  target = 目标
 %  environment = 航向、阵型
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
 %% 主函数
global fpLog;
global messenger;    
    if attacker.hp/attacker.maxHP < 0.5 % 攻击方已中破
        messenger = [messenger, '已中破，跳过'];
        fprintf(fpLog, '次轮炮击： %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    % 判定命中 %%命中公式需要全部修改
    if rand() > getHitRateCV(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '次轮炮击： %s 攻击 %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% 数据记录
        return;
    end
    % 计算伤害
    damage = DayPhasesFire_CV(attacker, target, environment, stat, opFleet);
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
    fprintf(fpLog, '次轮炮击： %s 攻击 %s %s造成 %d 点伤害(%d -> %d).\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
