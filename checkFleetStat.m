function res = checkFleetStat (fleet)
%%  checkFleetStat 检查目标舰队的状态（是否还存在未被击沉的目标）
 %  ans = checkFleetStat (fleet)
 %  fleet = 敌方舰队
 %  ans   = 还有目标true，没有false

%%  主函数
res = false;
for i = 1:length(fleet)
    if fleet(i).hp > 0
        res = true;
        break;
    end
end

