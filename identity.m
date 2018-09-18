function id = identity(name,type)
%%    辨识两组字符串是否一致
 %
 %    id = identityType(ship,type)
 %
 %      name ：任意字符串
 %      type ：待检索字符串
 
%% 主程序
id =0;
 for i = 1:length(type)
     if contains( name , type(i) ) % 这里的type是'长超长'，必须使用contains才能正常工作！
         id =1;
         return
     end
 end