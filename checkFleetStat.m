function res = checkFleetStat (fleet)
%%  checkFleetStat ���Ŀ�꽢�ӵ�״̬���Ƿ񻹴���δ��������Ŀ�꣩
 %  ans = checkFleetStat (fleet)
 %  fleet = �з�����
 %  ans   = ����Ŀ��true��û��false

%%  ������
res = false;
for i = 1:length(fleet)
    if fleet(i).hp > 0
        res = true;
        break;
    end
end

