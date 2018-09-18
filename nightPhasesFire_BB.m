function damage = nightPhasesFire_BB(attacker,target,environment, stat)
%%  nightPhasesFire_BB  计算夜战阶段战列舰的伤害
 %
 %  damage = nightPhasesFire_BB(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.firepower)+10;
    finalDamageMod = 1;
    if contains(attacker.skill, '胸甲骑兵') && contains(environment.hx, '反航')
        finalDamageMod = 1.35;
    elseif contains(attacker.skill, '胸甲骑兵') && contains(environment.hx, 'T劣')
        finalDamageMod = 1.7;
    end
    if stat == 1 % 我方攻击
        finalAttackPower = baseAttackPower*environment.myForm.coefNight...
                          *getShipInjury(attacker)*(rand()*0.6+1.2);
    else
        finalAttackPower = baseAttackPower*environment.opForm.coefNight...
                          *getShipInjury(attacker)*(rand()*0.6+1.2);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '暴击 '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + attacker.penetrate*finalAttackPower) );
    damage = damage * finalDamageMod;
    damage = ceil(damage);
end
