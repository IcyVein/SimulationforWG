function coef = getShipInjury(attacker)
%%  getShipInjury  计算船损系数
 %
 %  coef = getShipInjury(attacker)
 %
 %  attcker     = 当前舰娘
 %  coef        = 船损系数
 
%% 主函数
global messenger;
    if attacker.hp/attacker.maxHP>=0.5
     coef = 1;
    elseif attacker.hp/attacker.maxHP>=0.25
     coef = 0.6;
    else
     coef = 0.3;
    end
    if contains(messenger, '决胜之兵') && contains(messenger, '暴击')
        coef = 1;
    end
end