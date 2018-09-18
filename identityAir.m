function id = identityAir(ship)
%%  检测是否还有剩余可放飞飞机
 %
 %  id = identityAir(ship)
 %      ship：舰船
 
%% 主程序
id = 0 ;
for i = 1 : length(ship.hangar)
    if ship.aircraft(i).count > ship.aircraft(i).loss%判断是否有剩余飞机
        if ship.aircraft(i).type == 1 || ship.aircraft(i).type == 2 %判断是否为轰炸机（1）或鱼雷机（2）
            id = 1;
            return
        end
    end
end