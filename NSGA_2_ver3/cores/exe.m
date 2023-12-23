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

%% マルチスレッド設定
maxNumCompThreads(4);%core i7 3970X: 6/12





%% 個体生成（GA with Floating Point Representation）
% 乱数生成
rand('state',1000);% シード設定: 再現性のため固定値を使用する．
% 範囲[-1 1]の一様乱数
POP_NUM = MAX_POP_NUM; % 状況に応じて個体数は増減する．
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

    %%//----------------------- R_t = P_t U Q_t作成 (個数: 2N) -------------
    %%------------------------- 初期評価値 f_i(x_j) ------------------------
    if ig==1
        f_vec = evaluation_func(pop_vec);
        f_vec_NUM = size(f_vec, 2); % 評価関数f_i(x)の成分の数
    else
        f_vec = pop_f_vec(:,end-f_vec_NUM+1:end);
        pop_vec = pop_f_vec(:,1:end-f_vec_NUM);

        POP_NUM = min(length(pop_vec(:,1)), MAX_POP_NUM); % 状況に応じて個体数は増減する
        popnum(ig) = POP_NUM;
    end

    %%------------------------- 非優越ソート (フロント毎に分類: F_i) --------
    % pop_rank: 各ランク毎に所属する個体番号を格納
    pop_rank = non_dom_sort(pop_vec, f_vec);
    
    %%------------------------- 混雑距離計算 -------------------------------
    % rank_d_I: 各ランクの個体における混雑距離
    rank_d_I = crow_dst(pop_rank, f_vec);    

    %%------------------------- 親母集団P_t+1作成 (個数: N) ----------------
    % 母集団P_t+1の残りの部分について，混雑度ソートで優先された個体で埋める．
    pt1 = generate_Pt(pop_rank, rank_d_I, POP_NUM);   
    p_pop_vec = pop_vec(pt1,:);
    
    
	%%//----------------------- 子母集団Q_t+1作成 (個数: N) ----------------
    %%------------------------- 親母集団P_t+1より進化計算: (個数: N) --------
    
    %%[1] 混雑度トーナメント選択
    % qt: [個体番号：ランク：混雑距離]の配列
    qt =  tournament(pt1, pop_rank, rank_d_I, TOURNAMENT_RATE);
    
    new_pop_vec = pop_vec(qt(:,1),:);
    %%[2] 交叉
    % new_pop_vec: 親集団Pt+1の個体に対して交叉処理を行ったもの
    new_pop_vec = crossover(new_pop_vec, CROSSOVER_RATE);
    
    %%[3] 突然変異 
    new_pop_vec = mutation(new_pop_vec, pop_mutation_width, MUTATION_RATE, MUTATION_RATE_1);
    
    
    %%//----------------------- 母集団P_t+1と子集団Q_t+1を統合 --------------    
    
    %%[1] 更新個体だけ適合度を更新する(高速化)
    new_f_vec = evaluation_func(new_pop_vec);
    
    %%[2] 母集団P_t+1と子集団Q_t+1を統合
    new_pop_f_vec = [new_pop_vec new_f_vec];
    p_pop_f_vec = [p_pop_vec f_vec(pt1,:)];
    pop_f_vec = union(p_pop_f_vec, new_pop_f_vec, 'rows');

    %%//----------------------- 個体データ保存 -----------------------------
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



%% 優秀個体のplot
hold(h_ax1, 'on')
% plot3(h_ax1, f_vec(pop_rank{1},1),f_vec(pop_rank{1},2),ones(1,length(pop_rank{1})),'ro')
plot3(h_ax1, f_vec(qt(:,1),1),f_vec(qt(:,1),2),f_vec(qt(:,1),3),'ro')
xlim(h_ax1, [0 1])
ylim(h_ax1, [-1 0])
zlim(h_ax1, [-0.1 0.05 ])

set([h_ax1 h_ax2], 'FontName', 'Times New Roman')

%% 解のsave
new_GENERATION = GENERATION;% 追加計算用世代数
save .\save\pop_data  h_pop_vec h_elite_pop_vec pop_rank h_f_vec new_GENERATION h_pop_rank   

%% Finish

disp( [ 'Computing time: ', num2str( compute_time, '%0.2f'), ' [s]'])
warndlg( 'Finish!!')


