function hitRate = getHitRateCV(attacker, target, environment, stat)
%%  getHitRateCV 获取命中率，根据nga“终末的鱼雷机”攻略帖推测公式,保留了部分基于闪避的命中补正研究结论。
 %  hitRate = getHitRate(attacker, target, environment, stat)
 %
 %  attacker = 攻击方
 %  target = 目标
 %  environment = 航向、阵型
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
%%  主函数
global fixList;% 导入命中补正表
global messenger;
y = 0.014783*(attacker.accuracy-60)+0.08098*(100/50)-0.03086*target.AA*rand(1)+1.424907;
% y = 0.014783*(attacker.accuracy-60)+0.08098*(50/50)-0.03086*target.AA/2+1.424907;
fixValue = 0;
% 阵型补正
if stat == 1 % 我方攻击
    if strcmp(environment.opForm.name, 'Trapezoid') % 对方梯形
        fixValue = fixValue + fixList('opTrapezoid');
    elseif strcmp(environment.opForm.name, 'DoubleVertical') % 对方复纵
        fixValue = fixValue + fixList('opDoubleVertical');
    end
end
if stat == 2 % 敌方攻击
    if strcmp(environment.myForm.name, 'Trapezoid') % 对方梯形
        fixValue = fixValue + fixList('opTrapezoid');
    end
end
if stat == 1
% 技能补正
    checkSkill = isKey(fixList, environment.myBuff);
    for i = 1:length(checkSkill)
        if checkSkill(i)
            fixValue = fixValue + fixList(char(environment.myBuff(i)));
        end
    end
end
% 系统补正
if environment.reconnaissance && stat == 1 % 索敌成功，我方+命中
    fixValue = fixValue + fixList('track');
elseif environment.reconnaissance && stat == 2 % 索敌成功，我方+闪避
    fixValue = fixValue - fixList('track');
end
if strcmp(attacker.type, 'DD')
    fixValue = fixValue + fixList('DD');
end
if strfind('CLCACvL', target.type) % 中型船修正，轻母用Cvl，方便和CV区分
    fixValue = fixValue + fixList('mediumShip');
end

hitRate = 1./(1+exp(-(y+fixValue*0.014783))); % 补正的单位为等效命中

% 祖传补正
hitRate = min(hitRate, 0.95);
hitRate = max(hitRate, 0.05);
messenger = [messenger, '命中率', num2str(roundn(hitRate*100, -2)), '% '];
