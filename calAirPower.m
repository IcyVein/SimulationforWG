function  [myAirPower, opAirPower]=calAirPower(myFleetAns, opFleetAns)
 %% calAirPower 计算制空权
 %  [myAirPower, opAirPower]=calAirPower(myFleetAns, opFleetAns)
 
 %  myFleetAns = 我方舰队
 %  opFleetAns = 敌方舰队
 
 %  缺少判断航母语句!!
 
 %% 主函数
 myAirPower = 0;
 opAirPower = 0;
for i = 1:length(myFleetAns)
    for j=1 : length(myFleetAns(i).hangar)
        if  myFleetAns(i).aircraft(j).type == 3 && 4*myFleetAns(i).hp>=myFleetAns(i).maxHP
            %%判断是否为战斗机  且不处于大破状态  缺少判断航母语句
            myAirPower = myAirPower + log(1+ 2 * SinPlAirNum(myFleetAns(i),j) ) * myFleetAns(i).aircraft(j).value;
        end
    end
end

for i = 1:length(opFleetAns)
    for j=1 : length(opFleetAns(i).hangar)
        if  opFleetAns(i).aircraft(j).type == 3 && 4*opFleetAns(i).hp>=opFleetAns(i).maxHP
            %%判断是否为战斗机  且不处于大破状态  缺少判断航母语句
            opAirPower =opAirPower + log(1+ 2 * SinPlAirNum(opFleetAns(i),j) ) * opFleetAns(i).aircraft(j).value;
        end
    end 
end