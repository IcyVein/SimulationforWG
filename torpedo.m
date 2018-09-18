function [attacker, target] = torpedo(attacker, target, environment, stat)
%%  night 鱼雷战中的单次雷击
 %  [attacker, target] = torpedo(attacker, target, environment, stat)
 %
 %  attacker = 攻击方
 %  target = 目标
 %  environment = 航向、阵型
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
%%  主函数
global fpLog;
global messenger;
    if attacker.hp/attacker.maxHP < 0.25 % 攻击方已大破
        messenger = [messenger, '已大破，跳过'];
        fprintf(fpLog, '鱼雷战雷击： %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    attacker.attackNum = attacker.attackNum+1;% 数据记录
    if rand() > getHitRate(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '鱼雷战雷击： %s 攻击 %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% 数据记录
        return;
    end
    damage = torpedoPhasesFire(attacker, target, environment, stat);
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
    fprintf(fpLog, '鱼雷战雷击： %s 攻击 %s %s造成 %d 点伤害(%d -> %d).\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
end