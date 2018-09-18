function damage = DayPhasesFire_BB(attacker,target,environment, stat)
%%  DayPhasesFire_BB  计算炮击战阶段战列舰的伤害
 %
 %  damage = DayPhasesFire_BB(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.firepower)+5;
    critDamgMod = 1;
    critMod = 0;
    finalDamageMod = 1;
    if contains(attacker.skill, '胸甲骑兵') && contains(environment.hx, '反航')
        finalDamageMod = 1.35;
    elseif contains(attacker.skill, '胸甲骑兵') && contains(environment.hx, 'T劣')
        finalDamageMod = 1.7;
    end
        
    if contains(messenger, '决胜之兵')
        critMod = 0.2;
    end
    if rand < attacker.crit + critMod + target.opCrit
        critDamgMod = 1.5;
        messenger = [messenger, '暴击 '];
    end
    if stat == 1 % 我方攻击
        finalAttackPower = baseAttackPower*environment.myCourse.coef*environment.myForm.coef...
                          *getShipInjury(attacker)*(rand()*0.33+0.89)*critDamgMod;
    else
        finalAttackPower = baseAttackPower*environment.opCourse.coef*environment.opForm.coef...
                          *getShipInjury(attacker)*(rand()*0.33+0.89)*critDamgMod;
    end

    damage = finalAttackPower * (1- target.armor / (target.armor/2 + attacker.penetrate*finalAttackPower) );
    damage = damage * finalDamageMod;
    damage = ceil(damage);
end