function id = identityType(ship,type)
%%    ��ʶ��ֻ����
 %
 %      id = identityType(ship,type)
 %
 %      ship ����ֻ
 %      type ����ֻ���ࣨ��������ʽ��
 
%% ������
id =0;
 for i = 1:length(type)
     if strcmp( ship.type , type(i) )
         id =1;
         return
     end
 end