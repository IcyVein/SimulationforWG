%function WarshipsgirlSim
%��ģ����

%%
getdata;
fleet(7)=ship(1);
fleet=fleet(1:6);%�����ս���
while (1)
    con = input('ѡ��˵�\n 1:�༭����\n 2:���Ӳ鿴\n 3:����ģ��\n 4:�˳�ģ����\n','s');
    switch con 
        case '1'
            fleet = SetFleet(fleet,ship);
        case '2'
            ShowFleet(fleet);
        case '3'
        case '4'
            break
    end
end
%end