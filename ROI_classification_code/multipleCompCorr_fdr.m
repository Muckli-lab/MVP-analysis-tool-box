

load groupResults_Perm

data(1) = group_pPerm_Apc.V1V2V3fov;
data(2) = group_pPerm_Apc.V1V2V3peri;
data(3) = group_pPerm_Apc.V1V2V3farperi;
data(4) = group_pPerm_Apc.V1fov;
data(5) = group_pPerm_Apc.V1peri;
data(6) = group_pPerm_Apc.V1farperi;
data(7) = group_pPerm_Apc.V2fov;
data(8) = group_pPerm_Apc.V2peri;
data(9) = group_pPerm_Apc.V2farperi;
data(10) = group_pPerm_Apc.V3fov;
data(11) = group_pPerm_Apc.V3peri;
data(12) = group_pPerm_Apc.V3farperi;

for i = 1:length(data)
    if data(i) == 0
        data(i) = 0.001; % correct how the lowest possible p in our analysis is represented
    end
end

[h, crit_p, adj_ci_cvrg, adj_p] = fdr_bh(data); % see explanations in the function itself 
save('groupResults_by_eccentricity_FDR_corrected','h','crit_p','adj_ci_cvrg','adj_p');