function newfleet = SetFleet (fleet,ship)
%%  SetFleet  �趨����   
 %
 %  newfleet    =   SetFleet (fleet,ship)
 %  fleet       =   ԭ����
 %  ship        =   ����
 %

 %% ������
    flag=0;
    newfleet=fleet;
    while(flag == 0)
        com = input('�����뽢������  ��������Nȡ��\n','s');
        
        if com == 'N' %�ж��Ƿ�ȡ�����
            newfleet = fleet;
            disp('���ӱ༭�ѱ�ȡ��');
            break;
        end
            
        for i = 1:length(ship) %��Ѱ��ֻ����
           if strcmpi( cell2mat( ship(i).name ) , com )
               flag = 1;
               num = GetPositon;%��ȡ���λ��
               if num == 'null'%�ж��Ƿ�ȡ�����
                   disp('���ӱ༭�ѱ�ȡ��');
                   break
               else
                   newfleet(num)=ship(i);
               break;
               end
           end
        end
    end
end
