function pop_rank = non_dom_sort(pop_vec, f_vec)
%% 非優越ソートプログラム (f_vecの行が個体番号，列が評価関数ベクトル値)

f_vec_NUM = size(f_vec, 2); % 評価関数f_i(x)の成分の数
POP_NUM = size(f_vec, 1); %% 個体数[-]


%% 個体i,jの比較の準備
% 個体i
F_vec_1 = permute(f_vec, [3 1 2]);
F_vec_1 = repmat(F_vec_1, [POP_NUM 1 1]);
% 個体j
F_vec_2 = permute(f_vec, [1 3 2]);
F_vec_2 = repmat(F_vec_2, [1 POP_NUM 1]);


%% 非優越比較 ( f_k(x_i) - f_k(x_j) )
ir = 1;
pop_front=1;
pop_index = 1:POP_NUM;% 個体番号配列

while pop_front
    
    F_vec = F_vec_1 - F_vec_2;
    non_dominant_pop = uint8((sign(F_vec)+1)/2); % 非優越関係：1なら個体iに対して優越する解が存在している．
    non_dominant_pop = sum(non_dominant_pop,3);
    non_dominant_pop = non_dominant_pop - diag(diag(non_dominant_pop));% 対角成分0化
    non_dominant_pop(non_dominant_pop < f_vec_NUM) = 0;% 全ての評価関数f_kでより優秀な解が存在しているかどうか．
    non_dominant_num = sum(non_dominant_pop, 1)/f_vec_NUM; % 個体iに対する優越解の数 (個体iより優秀な個体の数)
    
    non_dominant_num_i(ir) = {non_dominant_num};
    
    % 非劣個体番号の探索
    pop_front_ind = find(non_dominant_num == 0);
    pop_front = pop_index(pop_front_ind);% 非劣個体番号
    pop_rank(ir) = {pop_front};


    %% ランクに格納した個体を除く
    pop_index(pop_front_ind) = [];
    F_vec_1(:,pop_front_ind,:) = [];
    F_vec_2(:,pop_front_ind,:) = [];
    F_vec_1(pop_front_ind,:,:) = [];
    F_vec_2(pop_front_ind,:,:) = [];
    
    
    ir = ir+1;
    
end
pop_rank = pop_rank(1:end-1);



