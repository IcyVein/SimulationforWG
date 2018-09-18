function targetList = getTargetList (fleet, types)
%%  getTargetList 通过敌方舰队列表获取靶舰列表，返回靶舰在舰队中的位置
 %                  目前只挑选出未被击沉的目标，以后可以增加路基，技能判断等
 %  targetList = getTargetList (fleet)
 %
 %  fleet = 敌方舰队
 %  targetList = 靶舰在舰队中的位置
 
%%  主函数
global messenger;
targetNum = 1;
targetList = [];
if nargin==1 % 无优先目标表
    for i = 1:length(fleet)
        if fleet(i).hp > 0 % 未被击沉
            targetList(targetNum) = i;
            targetNum = targetNum+1;
        end
    end
end
if nargin==2 % 有优先目标表
    if isempty(types)
        targetList = getTargetList(fleet);
        return;
    end
    for i = 1:length(fleet)
        if fleet(i).hp > 0 && identity(fleet(i).type, types(1))% 未被击沉
            targetList(targetNum) = i;
            messenger = [messenger, ' 决胜之兵: ', char(types(1))];
            break;
        end
    end
    types(1) = [];
    if isempty(targetList) % 没有搜索到符合types第一行的目标
        targetList = getTargetList(fleet, types);
    end
end


end