%% parameter for NSGA-2

%----------------------- 解析パラメータ ------------------------------------
GENERATION = 200; %% 世代数[-]
TOURNAMENT_RATE = 0.5; %% 選択率[-]
CROSSOVER_RATE = 1.0; %% 交叉率[-]
MUTATION_RATE = 0.1; %% 突然変異個体選択率[-]
MUTATION_RATE_1 = 0.8; %% 突然変異率[-]

%----------------------- 個体パラメータ ------------------------------------
MAX_POP_NUM = 500; %% 個体数[-]
POP_LGT = 3; %% 個体長さ[-]
% 初期個体の重み[-]
pop_weight = 0.1*ones(1,POP_LGT); 
% 突然変異の幅
pop_mutation_width = 10*pop_weight;
