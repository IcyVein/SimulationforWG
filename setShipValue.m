function ships = setShipValue(ships, title, val, title2, val2)
%%  将ships中每个舰船的title值增加val，或是仅满足title2值为val2的增加（要求为字符串对比）
%    如果输入4个参数，则val为百分比，title2为1是+，-1是-
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