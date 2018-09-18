function saveFleetStat (fp, fleet)
%% saveFleetStat (fp, fleet) 将舰队信息存入文件


%%
    num = length(fleet);

    for i = 1 : num
        fprintf(fp, '%s：%d / %d\n', fleet(i).name, fleet(i).hp, fleet(i).maxHP);
    end
end