function new_pop_vec = mutation(pop_vec, pop_mutation_width, MUTATION_RATE, MUTATION_RATE_1)
%% 突然変異

POP_LGT = size(pop_vec,2); %% 個体長さ[-]



% ランダムに並び替え
POP_NUM = length(pop_vec(:,1));
ind_rand_pop = randperm(POP_NUM);
pop_vec = pop_vec(ind_rand_pop, :);

% 交叉確率に基づいて選択
MUTATION_RATE_POP_NUM = uint32(MUTATION_RATE*POP_NUM);
hold_pop = pop_vec(MUTATION_RATE_POP_NUM+1:end,:); % 突然変異しない個体
pop_vec = pop_vec(1:MUTATION_RATE_POP_NUM,:); % 突然変異する個体
New_POP_NUM = length(pop_vec(:,1));

% GA with floating point での突然変異 [1]: 全ての成分を変化
% pop_vec = pop_vec + (ones(New_POP_NUM,1)*pop_mutation_width).*(2*rand(New_POP_NUM, POP_LGT) - 1);

% GA with floating point での突然変異 [2]: ランダムに変化する成分を選択
change_pop_value = (ones(New_POP_NUM,1)*pop_mutation_width).*(2*rand(New_POP_NUM, POP_LGT) - 1);% 変化値
change_pop_ind = rand(New_POP_NUM, POP_LGT);% 変化させる変数番号
[r c] = find(change_pop_ind < MUTATION_RATE_1);
change_pop_ind = accumarray([r, c], 1, [New_POP_NUM POP_LGT]);% ランダムに選択された変化させる番号は1の配列
pop_vec = pop_vec + change_pop_ind.*change_pop_value;

new_pop_vec = [pop_vec;
               hold_pop];