function hitRate = getHitRate(attacker, target, environment, stat)
%%  getHitRate 获取命中率，命中公式、补正表采用CNM组东方快车研究结果。
 %  hitRate = getHitRate(attacker, target, environment, stat)
 %
 %  attacker = 攻击方
 %  target = 目标
 %  environment = 航向、阵型
 %  stat        = 当前状态（我方攻击/敌方攻击）
 
%%  主函数
global fixList;% 导入命中补正表
global messenger;
y = 0.014783*(attacker.accuracy-100)+0.08098*(200/50)-0.03086*target.evasion+1.424907;
fixValue = 0;
% 阵型补正
if stat == 1 % 我方攻击
    if strcmp(environment.opForm.name, 'Trapezoid') % 对方梯形
        fixValue = fixValue + fixList('opTrapezoid');
    elseif strcmp(environment.opForm.name, 'DoubleVertical') % 对方复纵
        fixValue = fixValue + fixList('opDoubleVertical');
    end
    if strcmp(environment.myForm.name, 'Trapezoid') % 我方梯形
        fixValue = fixValue + fixList('myTrapezoid');
    end
end
if stat == 2 % 敌方攻击
    if strcmp(environment.myForm.name, 'Trapezoid') % 对方梯形
        fixValue = fixValue + fixList('opTrapezoid');
    end
    if strcmp(environment.opForm.name, 'Trapezoid') % 我方梯形
        fixValue = fixValue + fixList('myTrapezoid');
    end
end
if stat == 1
% 技能补正
    checkSkill = isKey(fixList, char(environment.myBuff));
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

% 舰娘补正
if stat == 1
    checkShip = isKey(fixList, cellstr(attacker.name));% 必须将名字包装在cell中
    if checkShip
        fixValue = fixValue + fixList(char(cellstr(attacker.name)));
    end
end

hitRate = 1./(1+exp(-(y+fixValue*0.014783))); % 补正的单位为等效命中

% if stat == 1 %我方直接加0.2的命中
% hitRate = hitRate+0.2;
% end

% 祖传补正
hitRate = min(hitRate, 0.95);
hitRate = max(hitRate, 0.05);
messenger = [messenger, '命中率', num2str(roundn(hitRate*100, -2)), '% '];
