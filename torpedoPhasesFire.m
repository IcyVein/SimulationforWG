function damage = torpedoPhasesFire(attacker,target,environment, stat)
%%  torpedoPhasesFire  计算鱼雷战阶段的伤害
 %
 %  damage = torpedoPhasesFire(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.torpedo)+5;
    if stat == 1 % 我方攻击
        finalAttackPower = baseAttackPower*environment.myCourse.coef*environment.myForm.coefTorpedo...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    else
        finalAttackPower = baseAttackPower*environment.opCourse.coef*environment.opForm.coefTorpedo...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '暴击 '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + 1.0*finalAttackPower) );
    damage = ceil(damage);
end