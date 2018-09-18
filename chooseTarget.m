function fireTarget = chooseTarget (targetList, num, myFleetAns, opFleetAns,state)
%%  chooseTarget 获取数个靶舰位置函数，靶舰不可重复，测试完毕
 %  fireTarget = chooseTarget (targetList, num)
 %
 %  targetList = 靶舰位置列表（数组）
 %  num        = 靶舰数量
 %  fireTarget = 目标在敌方舰队中的位置（数组）
 
%%  主函数
myTrautskill_all = ["威瑟堡行动","纳尔维克警戒"];
myTrautprocent_all = [-0.3, 0.3];

opTrautskill_all = ["迷之嘲讽","希望的曙光","盛开的迎风花","苏里高复仇者"];
opTrautprocent_all = [0.22, 0.3 , 0.3, -0.3];

opTrautskill_night = ["强行侦查"];
opTrautprocent_night = 0.4;

num = min(length(targetList), num);% 目标数量不可超过靶舰数量
fireTarget = zeros( 1, num );
trautRate = ones(1, length( opFleetAns ) );
for i  = 1 : length(trautRate) %修正嘲讽系数
    for j = 1: length( myTrautskill_all )
        if identity( myFleetAns(i).skill, myTrautskill_all( j ) )
            trautRate(i) = trautRate( i ) + myTrautprocent_all( j );
        end
    end
    for j = 1: length( opTrautskill_all )
        if identity( opFleetAns( i ).skill, opTrautskill_all( j ) )
            trautRate( i ) = trautRate( i ) + opTrautprocent_all( j );
        end
    end
    if identity( state , "night" )%修正夜战嘲讽系数
        for j = 1: length( opTrautskill_night )
            if identity( opFleetAns( i ).skill, opTrautskill_night( j ) )
                trautRate( i ) = trautRate( i ) + opTrautprocent_night( j );
            end
        end
    end
end
% 未考虑双方舰队长度不等
for k = 1 : num
    sum = 0;
    for i = 1:length( targetList )
       sum = sum + trautRate( i );
    end

    index = sum * rand(1);
    flag = 0;
    for i =1 : length( targetList ) + 1
        if i== length( targetList ) + 1
            fireTarget(k) = targetList( end );
            break
        end
        flag = flag + trautRate( i );
        if index <= flag
            fireTarget(k) = targetList( i );
            break
        end
    end
    trautRate( i ) = 0;
end
% for i = 1:num
%     index = ceil(rand(1)*length(targetList));% 随机选取一个目标
%     fireTarget(i) = targetList(index);
%     targetList(index) = [];
% end


% num = length(targetlist);
% target = num*rand(1);
% target = floor(target);
% firetarget = target+1;
% % firetarget =targetlist(target+1);
end