clear;
getAttributes;
equip = getEquipData('fleetEquipList.xlsx');
ship = getShipData('fleetShipList.xlsx');
ship = loadFleetEquip(ship, equip);
%enemy = getEnemyData('�����쳵E6��.xlsx');
enemy = getEnemyData('Ů����E8�����.xlsx');

maxSimTime = 300;

global fpLog;% ��־�ļ�
fpLog = fopen('log.txt', 'w+');
fprintf(fpLog, 'ģ�⿪ʼ\n');
global messenger; % ����ַ���
messenger = [];
global fixList; % ���в�����
verOrientExpress;
myFleet = ship(16:21);
% myFleet(1) = ship(15);
opFleet = enemy(1:6);

% ������BUFF�׶Σ������Կղ���
environment.myBuff = [];
[myFleet, opFleet, environment] = buff(myFleet, opFleet, equip, environment);

hitNum = zeros(6, 1);
critNum = zeros(6, 1);
missNum = zeros(6, 1);
attackNum = zeros(6, 1);
hpLoss = zeros(6, 1);
oilLoss = zeros(6, 1);
steelLoss = zeros(6, 1);
result = zeros(maxSimTime, 1);
progress = zeros(maxSimTime, 1);
tic;
%% ��ʼս��ģ��
for n = 1:maxSimTime
    if mod(n, 100) == 0
        disp(['��ģ�������', num2str(n)])
    end
    fprintf(fpLog, '��%d��ս��\n', n);
%     environment = [];
    [myAns, opAns] = combat(myFleet, opFleet, environment);
    [result(n), progress(n)] = getResult(opFleet, opAns);
    
    fprintf(fpLog, '�ҷ����ӣ�\n');
    saveFleetStat(fpLog, myAns);
    fprintf(fpLog, '�з����ӣ�\n');
    saveFleetStat(fpLog, opAns);
    %% �������
    for col = 1:6
        hitNum(col) = hitNum(col) + myAns(col).hitNum;
        critNum(col) = critNum(col) + myAns(col).critNum;
        missNum(col) = missNum(col) + myAns(col).missNum;
        attackNum(col) = attackNum(col) + myAns(col).attackNum;
        hpLoss(col) = hpLoss(col) + myFleet(col).maxHP - myAns(col).hp;
%         oilLoss(col) = myFleet(col).repairOil*hpLoss(col);
%         steelLoss(col) = myFleet(col).repairSteel*hpLoss(col);
    end
    
end
toc

hitRate = hitNum./attackNum;
critRate = critNum./hitNum;
missRate = missNum./attackNum;
hpLossAvg = hpLoss/maxSimTime;
oilLossAvg = oilLoss/maxSimTime;
steelLossAvg = steelLoss/maxSimTime;
resultRate = histc(result, [1, 2, 3])/maxSimTime;
disp(['�����ʣ�', num2str(hitRate')])
disp(['�����ʣ�', num2str(critRate')])
disp(['�����ʣ�', num2str(missRate')])
disp(['Hp��ʧ��', num2str(hpLossAvg')])
% disp(['�ͺģ�', num2str(oilLossAvg')])
% disp(['�ֺģ�', num2str(steelLossAvg')])
disp(['ȫ��н���', num2str(resultRate(1)*100), '%'])
disp(['նɱ�콢��', num2str(resultRate(2)*100), '%'])
disp(['ʧ�ܣ�', num2str(resultRate(3)*100), '%'])

fclose('all');
