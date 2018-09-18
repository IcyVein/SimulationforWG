function airPower = getAirPower(myFleetAns, opFleetAns)
%%  getAirPower 获得制空权
 %  airPower = getAirPower(myFleetAns, opFleetAns)
 %
 %  myFleetAns = 我方舰队
 %  opFleetAns = 敌方舰队
 %  airPower   = 制空权：0->3 = 空劣->空确
 
%%  主函数
global fpLog;
[myAirPower, opAirPower] = calAirPower(myFleetAns, opFleetAns);

if opAirPower == 0 % 空确
    airPower = 0.1;
    fprintf(fpLog, '占据制空权\n');
    return;
end

if myAirPower/opAirPower > 3       % 空确
    airPower = 0.1;
    fprintf(fpLog, '占据制空权\n');
elseif myAirPower/opAirPower > 1.5 % 空优
    airPower = 0.05;
    fprintf(fpLog, '制空权优势\n');
elseif myAirPower/opAirPower > 1/3 % 空均
    airPower = 0;
    fprintf(fpLog, '制空权均势\n');
else                               % 空劣
    airPower = -0.1;
    fprintf(fpLog, '失去制空权\n');
end