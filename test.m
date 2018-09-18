clear;
getAttributes;
equip = getEquipData('fleetEquipList.xlsx');
ship = getShipData('fleetShipList.xlsx');
ship = loadFleetEquip(ship, equip);
%enemy = getEnemyData('东方快车E6改.xlsx');
enemy = getEnemyData('女武神E8深海数据.xlsx');

maxSimTime = 300;

global fpLog;% 日志文件
fpLog = fopen('log.txt', 'w+');
fprintf(fpLog, '模拟开始\n');
global messenger; % 输出字符串
messenger = [];
global fixList; % 命中补正表
verOrientExpress;
myFleet = ship(16:21);
% myFleet(1) = ship(15);
opFleet = enemy(1:6);

% 永久类BUFF阶段，包括对空补正
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
%% 开始战斗模拟
for n = 1:maxSimTime
    if mod(n, 100) == 0
        disp(['已模拟次数：', num2str(n)])
    end
    fprintf(fpLog, '第%d次战斗\n', n);
%     environment = [];
    [myAns, opAns] = combat(myFleet, opFleet, environment);
    [result(n), progress(n)] = getResult(opFleet, opAns);
    
    fprintf(fpLog, '我方舰队：\n');
    saveFleetStat(fpLog, myAns);
    fprintf(fpLog, '敌方舰队：\n');
    saveFleetStat(fpLog, opAns);
    %% 结果分析
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
disp(['命中率：', num2str(hitRate')])
disp(['暴击率：', num2str(critRate')])
disp(['闪避率：', num2str(missRate')])
disp(['Hp损失：', num2str(hpLossAvg')])
% disp(['油耗：', num2str(oilLossAvg')])
% disp(['钢耗：', num2str(steelLossAvg')])
disp(['全灭敌舰：', num2str(resultRate(1)*100), '%'])
disp(['斩杀旗舰：', num2str(resultRate(2)*100), '%'])
disp(['失败：', num2str(resultRate(3)*100), '%'])

fclose('all');
