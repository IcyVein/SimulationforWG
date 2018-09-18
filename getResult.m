function [result, progress] = getResult(fleet, fleetFinal)
%%  getResult ����ս�����
 %  [result, progress] = getResult(fleet, fleetFinal)
 %
 %  fleet = �з�����ԭ��
 %  fleetFinal = �з����ӽ��
 %  result: ս��������
 %       1���з�ȫ��
 %       2���з��콢������
 %       3������
 %       ���ʹ����n����ܣ�������+n��1000
 %  progress����¼�Եз��콢��ɵ��˺�
 
%%  ������
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

