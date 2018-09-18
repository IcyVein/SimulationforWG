function id = identityType(ship,type)
%%    辨识船只种类
 %
 %      id = identityType(ship,type)
 %
 %      ship ：船只
 %      type ：船只种类（可向量形式）
 
%% 主程序
id =0;
 for i = 1:length(type)
     if strcmp( ship.type , type(i) )
         id =1;
         return
     end
 end