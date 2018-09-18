function [myFleet, opFleet, environment] = buff(myFleet, opFleet, equip, environment)
%%  ������BUFF�׶Σ������Կղ���
 %  [myFleet, opFleet, environment] = buff(myFleet, opFleet, equip, environment)
 %
 %  myFleet = �ҷ�����
 %  opFleet = �з�����
 %  environment = �������͡�BUFF��Ŀǰ��Ҫ�����в����ࣩ
 %  myFleetAns = �ҷ����ӽ���״̬
 %  opFleetAns = �з����ӽ���״̬
 
%%  �Կղ���
% �ҷ�����
sumAAMod = 0;
maxAAMod = 0;
for shipIndex = 1:length(myFleet)
    for equipIndex = 1:4
        if myFleet(shipIndex).equip(equipIndex) % ��װ��
            if equip(myFleet(shipIndex).equip(equipIndex)).AAMod % �жԿղ���
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

% �з�����
sumAAMod = 0;
maxAAMod = 0;
for shipIndex = 1:length(opFleet)
    for equipIndex = 1:4
        if opFleet(shipIndex).equip(equipIndex) % ��װ��
            if equip(opFleet(shipIndex).equip(equipIndex)).AAMod % �жԿղ���
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

%% �ʼҺ�������ҫ
if contains(myFleet(1).skill, '�ʼҺ�������ҫ')
    myFleet = setShipValue(myFleet, 'crit', 0.1);
    myFleet = setShipValue(myFleet, 'opCrit', 0.1);
    myFleet = setShipValue(myFleet, 'crit', 0.1, 'nation', 'E');
end
%% �ʼ�Ѳ��
if contains(myFleet(1).skill, '�ʼ�Ѳ��')
    myFleet = setShipValue(myFleet, 'speed', 4);
end

%% �����Ĺ¶�Ů��
if contains(myFleet(1).skill, '�����Ĺ¶�Ů��')
    environment.myBuff = [environment.myBuff, "skillTirpitz"];
    opFleet = setShipValue(opFleet, 'accuracy', -8);
end

%% ��Ϯ
if contains(myFleet(1).skill, '��Ϯ')
    opFleet = setShipValue(opFleet, 'AA', 0.30, -1);
end








