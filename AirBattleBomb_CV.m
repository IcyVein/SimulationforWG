function damage = AirBattleBomb_CV(attacker, target, environment, stat, targetIndex)
%%  AirBattleBomb_CV % 航空战单次攻击。使用攻击方舰娘给定序数的飞机攻击目标（TODO）
 %  damage = AirBattleBomb_CV(attacker, target, environment, stat, targetIndex)
 %
 %  attcker     = 攻击者

%%  主函数
global messenger;
    count = attacker.aircraft(targetIndex).count - attacker.aircraft(targetIndex).loss; % 本次参与攻击飞机数
    % 计算伤害
    baseAttackPower = 2 * log(count+1)*attacker.aircraft(targetIndex).value+25;
    if attacker.aircraft(targetIndex).type == 1 % 是轰炸机
        if stat == 1 % 我方攻击
            aircraftCoef = 1+environment.airPower;
        else 
            aircraftCoef = 1-environment.airPower;
        end
        aircraftPenetrate = attacker.penetrate + 0.4;
    else % 是攻击机
        aircraftCoef = rand(1)/2+0.5;
        aircraftPenetrate = 2;
    end
    finalAttackPower = baseAttackPower * aircraftCoef * getShipInjury(attacker)*(rand()*0.33+0.89);
    if rand < attacker.crit + target.opCrit + attacker.luck/7.5/100 % 7.5运/1%开幕暴击
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '暴击 '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + aircraftPenetrate*finalAttackPower) );
    damage = ceil(damage);
end