%% parameter for NSGA-2

%----------------------- ��̓p�����[�^ ------------------------------------
GENERATION = 200; %% ���㐔[-]
TOURNAMENT_RATE = 0.5; %% �I��[-]
CROSSOVER_RATE = 1.0; %% ������[-]
MUTATION_RATE = 0.1; %% �ˑR�ψٌ̑I��[-]
MUTATION_RATE_1 = 0.8; %% �ˑR�ψٗ�[-]

%----------------------- �̃p�����[�^ ------------------------------------
MAX_POP_NUM = 500; %% �̐�[-]
POP_LGT = 3; %% �̒���[-]
% �����̂̏d��[-]
pop_weight = 0.1*ones(1,POP_LGT); 
% �ˑR�ψق̕�
pop_mutation_width = 10*pop_weight;
