function ShowFleet (fleet)
%% ShowFleet (fleet) ��ʾ���Ӵ�ֻ


%%
    num = length(fleet);

    for i = 1 : num
        if ~isempty(fleet(i).name)
            disp([fleet(i).name, '����', fleet(i).firepower]);
        end
    end
end
