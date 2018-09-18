function newfleet = SetFleet (fleet,ship)
%%  SetFleet  设定舰队   
 %
 %  newfleet    =   SetFleet (fleet,ship)
 %  fleet       =   原舰队
 %  ship        =   船坞
 %

 %% 主程序
    flag=0;
    newfleet=fleet;
    while(flag == 0)
        com = input('请输入舰船名称  或者输入N取消\n','s');
        
        if com == 'N' %判断是否取消编队
            newfleet = fleet;
            disp('舰队编辑已被取消');
            break;
        end
            
        for i = 1:length(ship) %搜寻船只名字
           if strcmpi( cell2mat( ship(i).name ) , com )
               flag = 1;
               num = GetPositon;%获取编队位置
               if num == 'null'%判断是否取消编队
                   disp('舰队编辑已被取消');
                   break
               else
                   newfleet(num)=ship(i);
               break;
               end
           end
        end
    end
end
