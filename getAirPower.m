function airPower = getAirPower(myFleetAns, opFleetAns)
%%  getAirPower ����ƿ�Ȩ
 %  airPower = getAirPower(myFleetAns, opFleetAns)
 %
 %  myFleetAns = �ҷ�����
 %  opFleetAns = �з�����
 %  airPower   = �ƿ�Ȩ��0->3 = ����->��ȷ
 
%%  ������
global fpLog;
[myAirPower, opAirPower] = calAirPower(myFleetAns, opFleetAns);

if opAirPower == 0 % ��ȷ
    airPower = 0.1;
    fprintf(fpLog, 'ռ���ƿ�Ȩ\n');
    return;
end

if myAirPower/opAirPower > 3       % ��ȷ
    airPower = 0.1;
    fprintf(fpLog, 'ռ���ƿ�Ȩ\n');
elseif myAirPower/opAirPower > 1.5 % ����
    airPower = 0.05;
    fprintf(fpLog, '�ƿ�Ȩ����\n');
elseif myAirPower/opAirPower > 1/3 % �վ�
    airPower = 0;
    fprintf(fpLog, '�ƿ�Ȩ����\n');
else                               % ����
    airPower = -0.1;
    fprintf(fpLog, 'ʧȥ�ƿ�Ȩ\n');
end