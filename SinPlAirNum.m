function num = SinPlAirNum(ship,k)
%%    SinPlAirNum 计算单格飞机放飞数
 %      single place aircraft number Funtion
 
 %      ship : 舰船
 %      k    : 第k格
 %      返回最大放飞数
 
%% 主函数
k = floor(k);
if k>=5 || k<=0 
    num = 0;
    return
end
firepower = ship.firepower; %航母火力值
aircraftnum = ship.aircraft(k).count;%航母该格剩余飞机数
num1 = floor(3+firepower/5); %理论最大放飞数
num2 = aircraftnum; %实际最大放飞数
num = min(num1,num2);%单个飞机放飞数
if num <=0  %保证不为负（安全性
    num=0;
end
