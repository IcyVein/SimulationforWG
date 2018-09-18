function targetList = getTargetList (fleet, types)
%%  getTargetList ͨ���з������б��ȡ�н��б����ذн��ڽ����е�λ��
 %                  Ŀǰֻ��ѡ��δ��������Ŀ�꣬�Ժ��������·���������жϵ�
 %  targetList = getTargetList (fleet)
 %
 %  fleet = �з�����
 %  targetList = �н��ڽ����е�λ��
 
%%  ������
global messenger;
targetNum = 1;
targetList = [];
if nargin==1 % ������Ŀ���
    for i = 1:length(fleet)
        if fleet(i).hp > 0 % δ������
            targetList(targetNum) = i;
            targetNum = targetNum+1;
        end
    end
end
if nargin==2 % ������Ŀ���
    if isempty(types)
        targetList = getTargetList(fleet);
        return;
    end
    for i = 1:length(fleet)
        if fleet(i).hp > 0 && identity(fleet(i).type, types(1))% δ������
            targetList(targetNum) = i;
            messenger = [messenger, ' ��ʤ֮��: ', char(types(1))];
            break;
        end
    end
    types(1) = [];
    if isempty(targetList) % û������������types��һ�е�Ŀ��
        targetList = getTargetList(fleet, types);
    end
end


end