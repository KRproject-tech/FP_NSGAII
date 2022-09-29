function rank_d_I = crow_dst(pop_rank, f_vec)
%% 混雑度ソート

f_vec_NUM = size(f_vec, 2); % 評価関数f_i(x)の成分の数

%% 混雑距離計算

% 各ランクごとに計算
for ir = 1:length(pop_rank)
    
    pop_num_r = pop_rank{ir}; % ランクirでの個体番号
    lgt_pop_num = length(pop_num_r);

    [sort_f_vec sort_pop_I_ind] = sort(f_vec(pop_num_r,:),1,'descend'); % 評価関数の成分別に悪い順にソート
    
    d_I = zeros(lgt_pop_num, f_vec_NUM);
    % 境界個体(目的mの最大値と最小値の個体)に対して最大距離を与える．
    d_I([1 lgt_pop_num], :) = 1/eps; 
    % それ以外の個体の混雑度計算
    d_I(2:lgt_pop_num-1, :) = (sort_f_vec(1:end-2,:) - sort_f_vec(3:end,:))./repmat(max(sort_f_vec,[],1) - min(sort_f_vec,[],1), [lgt_pop_num-2 1]);
    
    ind_d_I = sort_pop_I_ind + ones(lgt_pop_num,1)*(lgt_pop_num*(0:f_vec_NUM-1)); % 評価関数の成分別に悪い順にソートしたときの行列のインデックス．

    d_I(ind_d_I) = d_I; % ソート前に並び替え
    d_I = sum(d_I, 2);
    rank_d_I(ir) = {d_I'};% 各ランクにおける混雑距離
end


