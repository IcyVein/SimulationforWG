function myOrder = AircraftOrder(myFleetAns)
%%  AircraftOrder % ��ȡ�ҷ�������ӭ��˳�򣨵ȴ�����type�ࣩ
 %  myOrder = AircraftOrder(myFleetAns)
 %
 %  myFleetAns            = �ҷ�����
 %  aircraft(i).num       = ��ǰӭ�������ɻ��ķŷ�����
 %  aircraft(i).value     = ��ǰӭ�������ɻ��ĺ�ը/����ֵ
 %  aircraft(i).type      = ��ǰӭ�������ɻ�������
 %  aircraft(i).penetrate = ��ǰӭ�������ɻ��Ķ��⴩��ϵ��
 
%%  ������
%myOrder = 2;
%return
%% �ֲ����� �ȴ�type
myOrder = [];
for i = 1 : length(myFleetAns)
    if identityType(myFleetAns(i),["CV","AV","CVL"]) == 1 %% �ж��Ƿ�Ϊ��ĸ��
        if identityAir(myFleetAns(i)) == 1 %%�ж��Ƿ���ʣ��ɷŷɷɻ�
            myOrder = [myOrder i];
        end
    end
end
        