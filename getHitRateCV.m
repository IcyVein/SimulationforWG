function hitRate = getHitRateCV(attacker, target, environment, stat)
%%  getHitRateCV ��ȡ�����ʣ�����nga����ĩ�����׻����������Ʋ⹫ʽ,�����˲��ֻ������ܵ����в����о����ۡ�
 %  hitRate = getHitRate(attacker, target, environment, stat)
 %
 %  attacker = ������
 %  target = Ŀ��
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
%%  ������
global fixList;% �������в�����
global messenger;
y = 0.014783*(attacker.accuracy-60)+0.08098*(100/50)-0.03086*target.AA*rand(1)+1.424907;
% y = 0.014783*(attacker.accuracy-60)+0.08098*(50/50)-0.03086*target.AA/2+1.424907;
fixValue = 0;
% ���Ͳ���
if stat == 1 % �ҷ�����
    if strcmp(environment.opForm.name, 'Trapezoid') % �Է�����
        fixValue = fixValue + fixList('opTrapezoid');
    elseif strcmp(environment.opForm.name, 'DoubleVertical') % �Է�����
        fixValue = fixValue + fixList('opDoubleVertical');
    end
end
if stat == 2 % �з�����
    if strcmp(environment.myForm.name, 'Trapezoid') % �Է�����
        fixValue = fixValue + fixList('opTrapezoid');
    end
end
if stat == 1
% ���ܲ���
    checkSkill = isKey(fixList, environment.myBuff);
    for i = 1:length(checkSkill)
        if checkSkill(i)
            fixValue = fixValue + fixList(char(environment.myBuff(i)));
        end
    end
end
% ϵͳ����
if environment.reconnaissance && stat == 1 % ���гɹ����ҷ�+����
    fixValue = fixValue + fixList('track');
elseif environment.reconnaissance && stat == 2 % ���гɹ����ҷ�+����
    fixValue = fixValue - fixList('track');
end
if strcmp(attacker.type, 'DD')
    fixValue = fixValue + fixList('DD');
end
if strfind('CLCACvL', target.type) % ���ʹ���������ĸ��Cvl�������CV����
    fixValue = fixValue + fixList('mediumShip');
end

hitRate = 1./(1+exp(-(y+fixValue*0.014783))); % �����ĵ�λΪ��Ч����

% �洫����
hitRate = min(hitRate, 0.95);
hitRate = max(hitRate, 0.05);
messenger = [messenger, '������', num2str(roundn(hitRate*100, -2)), '% '];
