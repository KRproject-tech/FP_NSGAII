function rank_d_I = crow_dst(pop_rank, f_vec)
%% ���G�x�\�[�g

f_vec_NUM = size(f_vec, 2); % �]���֐�f_i(x)�̐����̐�

%% ���G�����v�Z

% �e�����N���ƂɌv�Z
for ir = 1:length(pop_rank)
    
    pop_num_r = pop_rank{ir}; % �����Nir�ł̌̔ԍ�
    lgt_pop_num = length(pop_num_r);

    [sort_f_vec sort_pop_I_ind] = sort(f_vec(pop_num_r,:),1,'descend'); % �]���֐��̐����ʂɈ������Ƀ\�[�g
    
    d_I = zeros(lgt_pop_num, f_vec_NUM);
    % ���E��(�ړIm�̍ő�l�ƍŏ��l�̌�)�ɑ΂��čő勗����^����D
    d_I([1 lgt_pop_num], :) = 1/eps; 
    % ����ȊO�̌̂̍��G�x�v�Z
    d_I(2:lgt_pop_num-1, :) = (sort_f_vec(1:end-2,:) - sort_f_vec(3:end,:))./repmat(max(sort_f_vec,[],1) - min(sort_f_vec,[],1), [lgt_pop_num-2 1]);
    
    ind_d_I = sort_pop_I_ind + ones(lgt_pop_num,1)*(lgt_pop_num*(0:f_vec_NUM-1)); % �]���֐��̐����ʂɈ������Ƀ\�[�g�����Ƃ��̍s��̃C���f�b�N�X�D

    d_I(ind_d_I) = d_I; % �\�[�g�O�ɕ��ёւ�
    d_I = sum(d_I, 2);
    rank_d_I(ir) = {d_I'};% �e�����N�ɂ����鍬�G����
end


