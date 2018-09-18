function  [myAirPower, opAirPower]=calAirPower(myFleetAns, opFleetAns)
 %% calAirPower �����ƿ�Ȩ
 %  [myAirPower, opAirPower]=calAirPower(myFleetAns, opFleetAns)
 
 %  myFleetAns = �ҷ�����
 %  opFleetAns = �з�����
 
 %  ȱ���жϺ�ĸ���!!
 
 %% ������
 myAirPower = 0;
 opAirPower = 0;
for i = 1:length(myFleetAns)
    for j=1 : length(myFleetAns(i).hangar)
        if  myFleetAns(i).aircraft(j).type == 3 && 4*myFleetAns(i).hp>=myFleetAns(i).maxHP
            %%�ж��Ƿ�Ϊս����  �Ҳ����ڴ���״̬  ȱ���жϺ�ĸ���
            myAirPower = myAirPower + log(1+ 2 * SinPlAirNum(myFleetAns(i),j) ) * myFleetAns(i).aircraft(j).value;
        end
    end
end

for i = 1:length(opFleetAns)
    for j=1 : length(opFleetAns(i).hangar)
        if  opFleetAns(i).aircraft(j).type == 3 && 4*opFleetAns(i).hp>=opFleetAns(i).maxHP
            %%�ж��Ƿ�Ϊս����  �Ҳ����ڴ���״̬  ȱ���жϺ�ĸ���
            opAirPower =opAirPower + log(1+ 2 * SinPlAirNum(opFleetAns(i),j) ) * opFleetAns(i).aircraft(j).value;
        end
    end 
end