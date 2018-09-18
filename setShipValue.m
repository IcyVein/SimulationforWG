function ships = setShipValue(ships, title, val, title2, val2)
%%  ��ships��ÿ��������titleֵ����val�����ǽ�����title2ֵΪval2�����ӣ�Ҫ��Ϊ�ַ����Աȣ�
%    �������4����������valΪ�ٷֱȣ�title2Ϊ1��+��-1��-
%  ships = setShipValue(ships, title, val, title2, val2)

 if nargin==3
     for n = 1:length(ships)
         ships(n).(title) = ships(n).(title)+val;
     end
     return;
 end
 if nargin==4
     for n = 1:length(ships)
         ships(n).(title) = ships(n).(title)*(1+val*title2);
     end
     return;
 end
 if nargin==5
     for n = 1:length(ships)
         if contains(ships(n).(title2), val2)
            ships(n).(title) = ships(n).(title)+val;
         end
     end
     return;
 end