function pt = generate_Pt(pop_rank, rank_d_I, P_t_NUM)
%% �V���ȕ�W�c���쐬

hpt = [];
ir=1;
pt_flag = 1;

while pt_flag
    
    pt = hpt;
    hpt = [hpt pop_rank{ir}];
    pt_flag = (length(hpt) < P_t_NUM);
    
    ir = ir+1;
end

%% ��W�c�𖄂߂�
% �c��̕����ɂ͍��G�x�\�[�g�ŗD�悳�ꂽ�̂���

% ���G�x�\�[�g (�������傫�����ɑI��)
[dummy pop_rank_ind] = sort(rank_d_I{ir-1}, 'descend');
h_pop_rank = pop_rank{ir-1}(pop_rank_ind);

pt = [pt h_pop_rank(1:P_t_NUM-length(pt))];