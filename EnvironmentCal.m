function environmentdata = EnvironmentCal(fleet1,fleet2, environment) 
%%  environmentCal 计算航向等环境参数
 %
 %  未考虑全水下船只的索敌
 %  fleet1 = 我方舰队
 %  fleet2 = 敌方舰队
 %  返回是否索敌，航向
 
%% 主函数
fightstate = ['T优';'同航';'反航';'T劣']; % 为啥这里我的matlab不能使用双引号？我用的R2014a
environmentdata = environment; % 保留已有的buff信息
num(1).sum = length(fleet1);
num(1).main = 0;    %主力舰
num(1).sup  = 0;    %护卫舰

num(2).sum = length(fleet2);
num(2).main = 0;
num(2).sup  = 0;

main1 = zeros(1,length(fleet1));
sup1 = zeros(1,length(fleet1));
speed1 = zeros(1,length(fleet1));
reconnaissance1 = zeros(1,length(fleet1));

main2 = zeros(1,length(fleet2));
sup2 = zeros(1,length(fleet2));
speed2 = zeros(1,length(fleet2));
reconnaissance2 = zeros(1,length(fleet2));

for i = 1 : num(1).sum
    speed1(i) = fleet1(i).speed;
    reconnaissance1(i) = fleet1(i).reconnaissance;
    
    if  strcmpi( fleet1(i).type2, 'main')
        num(1).main = num(1).main + 1;
        main1(i) = 1;
    end
    if  strcmpi( fleet1(i).type2, 'sup')
        num(1).sup = num(1).sup + 1;
        sup1(i) = 1;
    end
end

for i = 1 : num(2).sum
    speed2(i) = fleet2(i).speed;
    reconnaissance2(i) = fleet2(i).reconnaissance;
    
    if  strcmpi( fleet2(i).type2, 'main')
        num(2).main = num(2).main + 1;
        main2(i) = 1;
    end
    if  strcmpi( fleet2(i).type2, 'sup')
        num(2).sup = num(2).sup + 1;
        sup2(i) = 1;
    end
end
%% 索敌计算
recDiff = reconnaissance1*ones(num(1).sum,1) - reconnaissance2*ones(num(2).sum,1);
if  20*rand(1)-10+recDiff >=0
    environmentdata.reconnaissance=1;
else 
    environmentdata.reconnaissance=0;
end

%% 航速计算
if  environmentdata.reconnaissance == 1
    speedmod = [20 35 25 5];
else
    speedmod = [10 30 30 15];
end
fleetSp1 = min( speed1*sup1'/num(1).sup,speed1*main1'/num(1).main);
fleetSp2 = min( speed2*sup2'/num(2).sup,speed2*main2'/num(2).main);
fleetDiffsp = fleetSp1 - fleetSp2;
FlagshipDiffsp = fleet1(1).speed-fleet2(1).speed;

%% 限制不能为负？好像没有用
% if fleetDiffsp <= speedmod(4) && fleetDiffsp >= -speedmod(2)
%     speedmod(2) = speedmod(2) + fleetDiffsp;
%     speedmod(4) = speedmod(4) - fleetDiffsp;
% elseif fleetDiffsp > speedmod(4)
%     speedmod(2) = speedmod(2) + speedmod(4);
%     speedmod(4) = 0;
% elseif fleetDiffsp < -speedmod(2)
%     speedmod(2) = 0;
%     speedmod(4) = speedmod(4) + speedmod(2);
% end
% 
% if FlagshipDiffsp <= speedmod(3)
%     speedmod(3) = speedmod(3) - FlagshipDiffsp;
% else
%     speedmod(3) = 0;
% end
% 
% if min(FlagshipDiffsp,fleetDiffsp) <= speedmod(1)
%     speedmod(1) = speedmod(1) - min(FlagshipDiffsp,fleetDiffsp);
% else 
%     speedmod(1) = 0;
% end
%% 好像是允许为负
    speedmod(2) = speedmod(2) + fleetDiffsp;
    speedmod(4) = speedmod(4) - fleetDiffsp;
    speedmod(3) = speedmod(3) - FlagshipDiffsp;
    speedmod(1) = speedmod(1) + min(FlagshipDiffsp,fleetDiffsp);
flag = zeros(1,4);  
sum = 0;
 for i = 1 : 4
     if speedmod(i) >= 0
         flag(i) = 1;
         sum = sum + speedmod(i);        
     end
 end
speedmod = speedmod .* flag;
random = rand(1) * sum;

for i = 1 : 4
    if i == 4
        environmentdata.hx = fightstate(4, :);
        break;
    end
    if flag(i) ~= 0
    speedmod(i+1) = speedmod(i+1) + speedmod(i);
        if random <= speedmod(i)
            environmentdata.hx = fightstate(i, :);
            break
        end
    end
end
% environmentdata
% keyboard
end