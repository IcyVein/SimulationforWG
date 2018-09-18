function myOrder = AircraftOrder(myFleetAns)
%%  AircraftOrder % 获取我方攻击舰迎击顺序（等待更新type类）
 %  myOrder = AircraftOrder(myFleetAns)
 %
 %  myFleetAns            = 我方舰队
 %  aircraft(i).num       = 当前迎击序数飞机的放飞数量
 %  aircraft(i).value     = 当前迎击序数飞机的轰炸/鱼雷值
 %  aircraft(i).type      = 当前迎击序数飞机的类型
 %  aircraft(i).penetrate = 当前迎击序数飞机的额外穿甲系数
 
%%  主函数
%myOrder = 2;
%return
%% 现不启用 等待type
myOrder = [];
for i = 1 : length(myFleetAns)
    if identityType(myFleetAns(i),["CV","AV","CVL"]) == 1 %% 判断是否为航母类
        if identityAir(myFleetAns(i)) == 1 %%判断是否有剩余可放飞飞机
            myOrder = [myOrder i];
        end
    end
end
        