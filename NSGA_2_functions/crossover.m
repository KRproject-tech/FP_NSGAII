function new_pop_vec = crossover(pop_vec, CROSSOVER_RATE)
%% ����

POP_LGT = size(pop_vec,2); %% �̒���[-]



% �����_���ɕ��ёւ�
POP_NUM = length(pop_vec(:,1));
ind_rand_pop = randperm(POP_NUM);
pop_vec = pop_vec(ind_rand_pop, :);

% �����m���Ɋ�Â��đI��
CROSSOVER_RATE_POP_NUM_per_2 = uint32(CROSSOVER_RATE*POP_NUM/2);
hold_pop = pop_vec(2*CROSSOVER_RATE_POP_NUM_per_2+1:end,:); % �ˑR�ψق��Ȃ���
pop_vec = pop_vec(1:2*CROSSOVER_RATE_POP_NUM_per_2,:); % �ˑR�ψق����
New_POP_NUM = length(pop_vec(:,1));

% GA with floating point �ł̌���
lmd = rand(New_POP_NUM/2,1)*ones(1,POP_LGT);
pop_vec(1:2:end-1,:) = lmd.*pop_vec(1:2:end-1,:) + (1 - lmd).*pop_vec(2:2:end,:);
pop_vec(2:2:end,:) = (1 - lmd).*pop_vec(1:2:end-1,:) + lmd.*pop_vec(2:2:end,:);

new_pop_vec = [pop_vec;
               hold_pop];