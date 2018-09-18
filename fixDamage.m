function finalDamage = fixDamage(damage, attacker, target, stat)
%%  fixDamage 未击穿修正和玩家保护，擦弹已被取消
 %  finalDamage = fixDamage(damage, attacker, target, stat)
 %  attacker = 攻击方
 %  target = 目标舰娘
 %  damage = 预计伤害
 %  finalDamage = 实际伤害
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
%%  主函数
global messenger;
    % 未击穿修正
    if damage < 0
        if rand <0.5
            finalDamage = ceil( min(attacker.firepower+5, target.hp/10) );
            messenger = [messenger, '未击穿修正 '];
        else
            finalDamage = 0;
            messenger = [messenger, '未击穿Miss '];
        end
    else
        finalDamage = damage;
    end
    
    % 玩家保护
    if stat == 2 % 敌方为攻击方时
        if target.hp == target.maxHP && damage/target.maxHP > 0.75 % 满血保护
            finalDamage = ceil( (rand()*0.25+0.5) * target.maxHP );
            messenger = [messenger, '满血保护 '];
        elseif target.hp/target.maxHP > 0.25 && (target.hp - damage) < target.maxHP/4 % 中破保护
            finalDamage = ceil( target.hp-target.maxHP/4 );
            messenger = [messenger, '中破保护 '];
        elseif target.hp/target.maxHP <= 0.25 && target.hp > 1% 大破保护
            finalDamage = 1;
            messenger = [messenger, '大破保护 '];
        elseif target.hp/target.maxHP <= 0.25 && target.hp == 1% 击沉保护
            finalDamage = 0;
            messenger = [messenger, '击沉保护 '];
        end
    end
end
    


