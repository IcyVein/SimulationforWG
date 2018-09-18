function [myFleet, opFleet, environment] = buff(myFleet, opFleet, equip, environment)
%%  永久类BUFF阶段，包括对空补正
 %  [myFleet, opFleet, environment] = buff(myFleet, opFleet, equip, environment)
 %
 %  myFleet = 我方舰队
 %  opFleet = 敌方舰队
 %  environment = 航向、阵型、BUFF（目前主要是命中补正类）
 %  myFleetAns = 我方舰队结束状态
 %  opFleetAns = 敌方舰队结束状态
 
%%  对空补正
% 我方舰队
sumAAMod = 0;
maxAAMod = 0;
for shipIndex = 1:length(myFleet)
    for equipIndex = 1:4
        if myFleet(shipIndex).equip(equipIndex) % 有装备
            if equip(myFleet(shipIndex).equip(equipIndex)).AAMod % 有对空补正
                sumAAMod = sumAAMod + equip(myFleet(shipIndex).equip(equipIndex)).AA;
                maxAAMod = max(maxAAMod, equip(myFleet(shipIndex).equip(equipIndex)).AAMod);
            end
        end
    end
end
sumAAMod = sumAAMod * maxAAMod;
for shipIndex = 1:length(myFleet)
    myFleet(shipIndex).AA = myFleet(shipIndex).AA + sumAAMod;
end

% 敌方舰队
sumAAMod = 0;
maxAAMod = 0;
for shipIndex = 1:length(opFleet)
    for equipIndex = 1:4
        if opFleet(shipIndex).equip(equipIndex) % 有装备
            if equip(opFleet(shipIndex).equip(equipIndex)).AAMod % 有对空补正
                sumAAMod = sumAAMod + equip(opFleet(shipIndex).equip(equipIndex)).AA;
                maxAAMod = max(maxAAMod, equip(opFleet(shipIndex).equip(equipIndex)).AAMod);
            end
        end
    end
end
sumAAMod = sumAAMod * maxAAMod;
for shipIndex = 1:length(opFleet)
    opFleet(shipIndex).AA = opFleet(shipIndex).AA + sumAAMod;
end

%% 皇家海军的荣耀
if contains(myFleet(1).skill, '皇家海军的荣耀')
    myFleet = setShipValue(myFleet, 'crit', 0.1);
    myFleet = setShipValue(myFleet, 'opCrit', 0.1);
    myFleet = setShipValue(myFleet, 'crit', 0.1, 'nation', 'E');
end
%% 皇家巡游
if contains(myFleet(1).skill, '皇家巡游')
    myFleet = setShipValue(myFleet, 'speed', 4);
end

%% 北方的孤独女王
if contains(myFleet(1).skill, '北方的孤独女王')
    environment.myBuff = [environment.myBuff, "skillTirpitz"];
    opFleet = setShipValue(opFleet, 'accuracy', -8);
end

%% 奇袭
if contains(myFleet(1).skill, '奇袭')
    opFleet = setShipValue(opFleet, 'AA', 0.30, -1);
end








