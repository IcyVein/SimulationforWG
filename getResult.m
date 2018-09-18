function [result, progress] = getResult(fleet, fleetFinal)
%%  getResult 评价战斗结果
 %  [result, progress] = getResult(fleet, fleetFinal)
 %
 %  fleet = 敌方舰队原型
 %  fleetFinal = 敌方舰队结果
 %  result: 战果表如下
 %       1：敌方全灭
 %       2：敌方旗舰被击沉
 %       3：其他
 %       如果使用了n个损管，则评价+n×1000
 %  progress：记录对敌方旗舰造成的伤害
 
%%  主函数
sinkNum = 0;
for i = 1:length(fleetFinal)
    if fleetFinal(i).hp == 0
        sinkNum = sinkNum+1;
    end
end
if sinkNum == length(fleetFinal)
    result = 1;
    progress = fleetFinal(1).maxHP;
elseif sinkNum < length(fleetFinal) && fleetFinal(1).hp == 0
    result = 2;
    progress = fleetFinal(1).maxHP;
else
    result = 3;
    progress = fleetFinal(1).maxHP-fleetFinal(1).hp;
end

