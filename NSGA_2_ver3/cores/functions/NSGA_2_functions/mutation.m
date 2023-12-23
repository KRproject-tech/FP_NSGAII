function new_pop_vec = mutation(pop_vec, pop_mutation_width, MUTATION_RATE, MUTATION_RATE_1)
%% �ˑR�ψ�

POP_LGT = size(pop_vec,2); %% �̒���[-]



% �����_���ɕ��ёւ�
POP_NUM = length(pop_vec(:,1));
ind_rand_pop = randperm(POP_NUM);
pop_vec = pop_vec(ind_rand_pop, :);

% �����m���Ɋ�Â��đI��
MUTATION_RATE_POP_NUM = uint32(MUTATION_RATE*POP_NUM);
hold_pop = pop_vec(MUTATION_RATE_POP_NUM+1:end,:); % �ˑR�ψق��Ȃ���
pop_vec = pop_vec(1:MUTATION_RATE_POP_NUM,:); % �ˑR�ψق����
New_POP_NUM = length(pop_vec(:,1));

% GA with floating point �ł̓ˑR�ψ� [1]: �S�Ă̐�����ω�
% pop_vec = pop_vec + (ones(New_POP_NUM,1)*pop_mutation_width).*(2*rand(New_POP_NUM, POP_LGT) - 1);

% GA with floating point �ł̓ˑR�ψ� [2]: �����_���ɕω����鐬����I��
change_pop_value = (ones(New_POP_NUM,1)*pop_mutation_width).*(2*rand(New_POP_NUM, POP_LGT) - 1);% �ω��l
change_pop_ind = rand(New_POP_NUM, POP_LGT);% �ω�������ϐ��ԍ�
[r c] = find(change_pop_ind < MUTATION_RATE_1);
change_pop_ind = accumarray([r, c], 1, [New_POP_NUM POP_LGT]);% �����_���ɑI�����ꂽ�ω�������ԍ���1�̔z��
pop_vec = pop_vec + change_pop_ind.*change_pop_value;

new_pop_vec = [pop_vec;
               hold_pop];