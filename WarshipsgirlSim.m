%function WarshipsgirlSim
%主模拟器

%%
getdata;
fleet(7)=ship(1);
fleet=fleet(1:6);%建立空舰队
while (1)
    con = input('选择菜单\n 1:编辑队伍\n 2:舰队查看\n 3:出征模拟\n 4:退出模拟器\n','s');
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