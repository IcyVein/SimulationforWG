function [attacker, target] = shell2(attacker, target, environment, stat, opFleet)
%%  shell2 次轮炮击中的单次炮击
 %  [attacker, target] = shell2(attacker, target, environment, stat)
 %
 %  attacker = 攻击方
 %  target = 目标
 %  environment = 航向、阵型
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
%%  主函数
global fpLog;
global messenger;
    if identity(attacker.range,['长','超长']) ~= 1
        %messenger = [messenger, '射程不足，不参与'];
        fprintf(fpLog, '次轮炮击： %s射程不足，不参与次轮炮击.\n', attacker.name);
        return;
    end
    if attacker.hp <= 0 % 攻击方已被击沉
        messenger = [messenger, '已沉没，跳过'];
        fprintf(fpLog, '次轮炮击： %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    attacker.attackNum = attacker.attackNum+1;% 数据记录
    %% 判定是否为航空炮击    
    if identityType(attacker,["CV","AV","CVL"]) == 1
        [attacker, target] = shell2CV(attacker, target, environment, stat, opFleet);
        return
    end
    %% 正常炮击     
    if rand() > getHitRate(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '次轮炮击： %s 攻击 %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% 数据记录
        return;
    end
    damage = DayPhasesFire_BB(attacker, target, environment, stat);
    damage = fixDamage(damage, attacker, target, stat);
    targetHp0 = target.hp ;
    target.hp = target.hp - damage;
    if target.hp < 0
        target.hp = 0;
    end
    attacker.hitNum = attacker.hitNum+1;% 数据记录
    if strfind(messenger, '暴击')
        attacker.critNum = attacker.critNum+1;% 数据记录
    end
    fprintf(fpLog, '次轮炮击： %s 攻击 %s %s造成 %d 点伤害(%d -> %d)\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
end