function damage = nightPhasesFire_DD(attacker,target,environment, stat)
%%  nightPhasesFire_DD  计算夜战阶段纯雷击的伤害
 %
 %  damage = nightPhasesFire_DD(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.torpedo)+10;
    if stat == 1 % 我方攻击
        finalAttackPower = baseAttackPower*environment.myForm.coefNight...
                          *getShipInjury(attacker)*(rand()*0.6+2.4);
    else
        finalAttackPower = baseAttackPower*environment.opForm.coefNight...
                          *getShipInjury(attacker)*(rand()*0.6+2.4);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '暴击 '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + (attacker.penetrate+0.4)*finalAttackPower) );
    damage = ceil(damage);
end
