function qt_out =  tournament(pt, pop_rank, rank_d_I, TOURNAMENT_RATE)
%% 混雑度トーナメント

P_t_NUM = length(pt);



% [個体番号：ランク：混雑距離]の配列を作成
% [ランク番号]
pop_rank_mat = [];
for ir=1:length(pop_rank)

    pop_rank_mat = [pop_rank_mat ir*ones(1,length(pop_rank{ir}))];
end
pop_rank_mat = pop_rank_mat(1:P_t_NUM);
% [混雑距離]
rank_d_I_mat = cell2mat(rank_d_I);
rank_d_I_mat = rank_d_I_mat(1:P_t_NUM);

pop_mat = [pt' pop_rank_mat' rank_d_I_mat'];



% 奇数個ならランダムに個体を一つコピー
if mod(P_t_NUM,2) == 1
    
    rand_ind = uint8((P_t_NUM-1)*rand(1))+1;
    pop_mat = [pop_mat;
               pop_mat(rand_ind,:)];
    
end
NEW_P_t_NUM = length(pop_mat(:,1));


% ランダムに並び替え
ind_rand_pop = randperm(NEW_P_t_NUM);
pop_mat = pop_mat(ind_rand_pop,:);


% 選択率に従って個体を選択 (偶数個)
TOURNAMENT_RATE_NEW_P_t_NUM_per_2 = uint32(TOURNAMENT_RATE*NEW_P_t_NUM/2);
hold_pop_mat = pop_mat(2*TOURNAMENT_RATE_NEW_P_t_NUM_per_2+1:end,:); % 選択操作しない個体
pop_mat = pop_mat(1:2*TOURNAMENT_RATE_NEW_P_t_NUM_per_2,:); % 選択操作する個体
NEW_P_t_NUM_1 = size(pop_mat,1);


% 二組同士の比較
% [1]ランクで評価
ind_pop_1 = find(pop_mat(1:2:end-1,2) - pop_mat(2:2:end,2) < 0);
ind_pop_2 = find(pop_mat(1:2:end-1,2) - pop_mat(2:2:end,2) > 0);
new_pop_mat = zeros(floor(NEW_P_t_NUM_1/2),3);
new_pop_mat(ind_pop_1, :) = pop_mat(2*ind_pop_1 - 1, :); % 個体番号代入
new_pop_mat(ind_pop_2, :) = pop_mat(2*ind_pop_2, :); % 個体番号代入
% [2]同ランクなら混在距離で評価
eq_rank = (pop_mat(1:2:end-1,2) == pop_mat(2:2:end,2));
ind_pop_1 = find( eq_rank & pop_mat(1:2:end-1,3) - pop_mat(2:2:end,3) > 0);
ind_pop_2 = find( eq_rank & pop_mat(1:2:end-1,3) - pop_mat(2:2:end,3) < 0);
new_pop_mat(ind_pop_1, :) = pop_mat(2*ind_pop_1 - 1, :); % 個体番号代入
new_pop_mat(ind_pop_2, :) = pop_mat(2*ind_pop_2, :); % 個体番号代入

% 複製
new_pop_mat(new_pop_mat(:,1)==0,:) = [];
new_pop_mat = [new_pop_mat; 
               new_pop_mat;
               hold_pop_mat];

qt_out = new_pop_mat;

