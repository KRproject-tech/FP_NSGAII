clc
clear all
close all hidden

%% path
add_pathes;

%% delete
delete( '*.asv')
delete( '*.log')

%% parameter for NSGA-2
param_setting;

%% �}���`�X���b�h�ݒ�
maxNumCompThreads(4);%core i7 3970X: 6/12





%% �̐����iGA with Floating Point Representation�j
% ��������
rand('state',1000);% �V�[�h�ݒ�: �Č����̂��ߌŒ�l���g�p����D
% �͈�[-1 1]�̈�l����
POP_NUM = MAX_POP_NUM; % �󋵂ɉ����Č̐��͑�������D
pop_vec = (ones(2*POP_NUM,1)*pop_weight).*(2*rand(2*POP_NUM,POP_LGT) - 1);

h_fig1 = figure(1);
h_fig2 = figure(2);
h_ax1 = axes('Parent', h_fig1, 'FontSize', 15);
h_ax2 = axes('Parent', h_fig2, 'FontSize', 15);

h_pop_vec = {};
h_elite_pop_vec = {};%% elite
h_f_vec = {};
h_pop_rank = {};

tic;

for ig=1:GENERATION    

    %%//----------------------- R_t = P_t U Q_t�쐬 (��: 2N) -------------
    %%------------------------- �����]���l f_i(x_j) ------------------------
    if ig==1
        f_vec = evaluation_func(pop_vec);
        f_vec_NUM = size(f_vec, 2); % �]���֐�f_i(x)�̐����̐�
    else
        f_vec = pop_f_vec(:,end-f_vec_NUM+1:end);
        pop_vec = pop_f_vec(:,1:end-f_vec_NUM);

        POP_NUM = min(length(pop_vec(:,1)), MAX_POP_NUM); % �󋵂ɉ����Č̐��͑�������
        popnum(ig) = POP_NUM;
    end

    %%------------------------- ��D�z�\�[�g (�t�����g���ɕ���: F_i) --------
    % pop_rank: �e�����N���ɏ�������̔ԍ����i�[
    pop_rank = non_dom_sort(pop_vec, f_vec);
    
    %%------------------------- ���G�����v�Z -------------------------------
    % rank_d_I: �e�����N�̌̂ɂ����鍬�G����
    rank_d_I = crow_dst(pop_rank, f_vec);    

    %%------------------------- �e��W�cP_t+1�쐬 (��: N) ----------------
    % ��W�cP_t+1�̎c��̕����ɂ��āC���G�x�\�[�g�ŗD�悳�ꂽ�̂Ŗ��߂�D
    pt1 = generate_Pt(pop_rank, rank_d_I, POP_NUM);   
    p_pop_vec = pop_vec(pt1,:);
    
    
	%%//----------------------- �q��W�cQ_t+1�쐬 (��: N) ----------------
    %%------------------------- �e��W�cP_t+1���i���v�Z: (��: N) --------
    
    %%[1] ���G�x�g�[�i�����g�I��
    % qt: [�̔ԍ��F�����N�F���G����]�̔z��
    qt =  tournament(pt1, pop_rank, rank_d_I, TOURNAMENT_RATE);
    
    new_pop_vec = pop_vec(qt(:,1),:);
    %%[2] ����
    % new_pop_vec: �e�W�cPt+1�̌̂ɑ΂��Č����������s��������
    new_pop_vec = crossover(new_pop_vec, CROSSOVER_RATE);
    
    %%[3] �ˑR�ψ� 
    new_pop_vec = mutation(new_pop_vec, pop_mutation_width, MUTATION_RATE, MUTATION_RATE_1);
    
    
    %%//----------------------- ��W�cP_t+1�Ǝq�W�cQ_t+1�𓝍� --------------    
    
    %%[1] �X�V�̂����K���x���X�V����(������)
    new_f_vec = evaluation_func(new_pop_vec);
    
    %%[2] ��W�cP_t+1�Ǝq�W�cQ_t+1�𓝍�
    new_pop_f_vec = [new_pop_vec new_f_vec];
    p_pop_f_vec = [p_pop_vec f_vec(pt1,:)];
    pop_f_vec = union(p_pop_f_vec, new_pop_f_vec, 'rows');

    %%//----------------------- �̃f�[�^�ۑ� -----------------------------
    h_pop_vec(ig) = {pop_vec};
    h_elite_pop_vec(ig) = {p_pop_vec};%% elite
    h_f_vec(ig) = {f_vec}; 
    h_pop_rank(ig) = {pop_rank};
    
    %% plot
%     plot3(h_ax1, f_vec(qt(:,1),1),f_vec(qt(:,1),2),qt(:,2),'o')
    plot3(h_ax1, f_vec(qt(:,1),1),f_vec(qt(:,1),2),f_vec(qt(:,1),3),'o')
    xlabel(h_ax1, '{\itf}_1', 'FontName', 'Times New Roman')
    ylabel(h_ax1, '{\itf}_2', 'FontName', 'Times New Roman')
    zlabel(h_ax1, '{\itf}_3', 'FontName', 'Times New Roman')
%     zlabel(h_ax1, 'rank value', 'FontName', 'Times New Roman')
    grid(h_ax1, 'on')
    
    %% plot
    plot3(h_ax2, f_vec(pop_rank{1},1),f_vec(pop_rank{1},2),rank_d_I{1},'o')
    xlabel(h_ax2, '{\itf}_1', 'FontName', 'Times New Roman')
    ylabel(h_ax2, '{\itf}_2', 'FontName', 'Times New Roman')
    zlabel(h_ax2, 'Crowing distance', 'FontName', 'Times New Roman')
    grid(h_ax2, 'on')
    zlim([0 0.1])
    drawnow

    disp(['Generation is ',num2str(ig)])

    
end

compute_time = toc;



%% �D�G�̂�plot
hold(h_ax1, 'on')
% plot3(h_ax1, f_vec(pop_rank{1},1),f_vec(pop_rank{1},2),ones(1,length(pop_rank{1})),'ro')
plot3(h_ax1, f_vec(qt(:,1),1),f_vec(qt(:,1),2),f_vec(qt(:,1),3),'ro')
xlim(h_ax1, [0 1])
ylim(h_ax1, [-1 0])
zlim(h_ax1, [-0.1 0.05 ])

set([h_ax1 h_ax2], 'FontName', 'Times New Roman')

%% ����save
new_GENERATION = GENERATION;% �ǉ��v�Z�p���㐔
save .\save\pop_data  h_pop_vec h_elite_pop_vec pop_rank h_f_vec new_GENERATION h_pop_rank   

%% Finish

disp( [ 'Computing time: ', num2str( compute_time, '%0.2f'), ' [s]'])
warndlg( 'Finish!!')


