function ShowFleet (fleet)
%% ShowFleet (fleet) 显示舰队船只


%%
    num = length(fleet);

    for i = 1 : num
        if ~isempty(fleet(i).name)
            disp([fleet(i).name, '火力', fleet(i).firepower]);
        end
    end
end
