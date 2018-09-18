function damage = DayPhasesFire_CV(attacker,target,environment, stat, opFleet)
%%  DayPhasesFire_CV  计算首轮炮击战阶段航母的伤害
 %
 %  damage = DayPhasesFire_CV(attacker,target,environment, stat)
 %
 %  attcker     = 攻击者
 %  target      = 靶舰
 %  environment = 环境参数
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
%% 缺省情况
    if nargin==1
        error('missing target and environment');
    end
    if nargin==2
        error('missing environment');
    end
%% 主函数
global messenger;
    baseAttackPower = baseCVDay1(attacker,target,environment, stat, opFleet);
     if stat == 1 % 我方攻击
            aircraftCoef = 1+environment.airPower;
        else 
            aircraftCoef = 1-environment.airPower;
     end
     if 0
         aircraftPenetrate = 1.2;
     else
         aircraftPenetrate = 1;
     end
     
    if stat == 1 % 我方攻击
        finalAttackPower = baseAttackPower*aircraftCoef*skillcoef(attacker)...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    else
        finalAttackPower = baseAttackPower*aircraftCoef*skillcoef(attacker)...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '暴击 '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + aircraftPenetrate*finalAttackPower) );
    damage = ceil(damage);
end

