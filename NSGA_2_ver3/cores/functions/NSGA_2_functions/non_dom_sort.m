function pop_rank = non_dom_sort(pop_vec, f_vec)
%% ��D�z�\�[�g�v���O���� (f_vec�̍s���̔ԍ��C�񂪕]���֐��x�N�g���l)

f_vec_NUM = size(f_vec, 2); % �]���֐�f_i(x)�̐����̐�
POP_NUM = size(f_vec, 1); %% �̐�[-]


%% ��i,j�̔�r�̏���
% ��i
F_vec_1 = permute(f_vec, [3 1 2]);
F_vec_1 = repmat(F_vec_1, [POP_NUM 1 1]);
% ��j
F_vec_2 = permute(f_vec, [1 3 2]);
F_vec_2 = repmat(F_vec_2, [1 POP_NUM 1]);


%% ��D�z��r ( f_k(x_i) - f_k(x_j) )
ir = 1;
pop_front=1;
pop_index = 1:POP_NUM;% �̔ԍ��z��

while pop_front
    
    F_vec = F_vec_1 - F_vec_2;
    non_dominant_pop = uint8((sign(F_vec)+1)/2); % ��D�z�֌W�F1�Ȃ��i�ɑ΂��ėD�z����������݂��Ă���D
    non_dominant_pop = sum(non_dominant_pop,3);
    non_dominant_pop = non_dominant_pop - diag(diag(non_dominant_pop));% �Ίp����0��
    non_dominant_pop(non_dominant_pop < f_vec_NUM) = 0;% �S�Ă̕]���֐�f_k�ł��D�G�ȉ������݂��Ă��邩�ǂ����D
    non_dominant_num = sum(non_dominant_pop, 1)/f_vec_NUM; % ��i�ɑ΂���D�z���̐� (��i���D�G�Ȍ̂̐�)
    
    non_dominant_num_i(ir) = {non_dominant_num};
    
    % ���̔ԍ��̒T��
    pop_front_ind = find(non_dominant_num == 0);
    pop_front = pop_index(pop_front_ind);% ���̔ԍ�
    pop_rank(ir) = {pop_front};


    %% �����N�Ɋi�[�����̂�����
    pop_index(pop_front_ind) = [];
    F_vec_1(:,pop_front_ind,:) = [];
    F_vec_2(:,pop_front_ind,:) = [];
    F_vec_1(pop_front_ind,:,:) = [];
    F_vec_2(pop_front_ind,:,:) = [];
    
    
    ir = ir+1;
    
end
pop_rank = pop_rank(1:end-1);



