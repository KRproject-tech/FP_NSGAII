function pt = generate_Pt(pop_rank, rank_d_I, P_t_NUM)
%% 新たな母集団を作成

hpt = [];
ir=1;
pt_flag = 1;

while pt_flag
    
    pt = hpt;
    hpt = [hpt pop_rank{ir}];
    pt_flag = (length(hpt) < P_t_NUM);
    
    ir = ir+1;
end

%% 母集団を埋める
% 残りの部分には混雑度ソートで優先された個体を代入

% 混雑度ソート (距離が大きい順に選ぶ)
[dummy pop_rank_ind] = sort(rank_d_I{ir-1}, 'descend');
h_pop_rank = pop_rank{ir-1}(pop_rank_ind);

pt = [pt h_pop_rank(1:P_t_NUM-length(pt))];