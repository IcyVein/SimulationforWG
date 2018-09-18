function baseAttackPower = baseCVDay1(attacker,target,environment, stat, opFleet)
%% 航母首轮炮击战基础伤害计算
 %
 % baseAttackPower = baseCVDay1(attacker,target,environment, stat, opFleet)
 %
 %  attcker     = 攻击者
 %  target      = 靶舰
 %  environment = 环境参数
 %  stat        = 当前状态（我方攻击/敌方攻击）
 %  opFleet     = 敌方舰队
 %
 %  现在未考虑装备补正对空
 %% 主函数
baseAttackPower=attacker.firepower;
for i= 1 :length(attacker.hangar)
    if attacker.aircraft(i).count > 0 %%第i格还有剩余飞机
        if attacker.aircraft(i).type == 1%%第i格为轰炸机
            baseAttackPower = baseAttackPower + 2 * attacker.aircraft(i).value;
        elseif attacker.aircraft(i).type == 2%%第i格为鱼雷机
            baseAttackPower = baseAttackPower + 1 * attacker.aircraft(i).value;
        else %%如果为战斗机或者侦察机
            baseAttackPower = baseAttackPower;
        end
    end
end
baseAttackPower = baseAttackPower * calAA(target,opFleet)+35;
 