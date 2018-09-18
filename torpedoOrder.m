function attackerList = torpedoOrder (fleet)
%%  torpedoOrder 通过我方舰队列表获取能够发射鱼雷的舰娘列表，返回舰娘在舰队中的位置
 %   attackerList = torpedoOrder (fleet)
 %
 %  fleet = 我方舰队
 %  attackerList = 攻击者在舰队中的位置
 
%%  主函数
attackerNum = 1;
attackerList = [];
for i = 1:length(fleet)
    if fleet(i).torpedo > 0  % 有鱼雷值即参与鱼雷战，攻击机建议不使用鱼雷值参数。（大破检查在鱼雷战协调函数里）
        attackerList(attackerNum) = i;
        attackerNum = attackerNum+1;
    end
end

end