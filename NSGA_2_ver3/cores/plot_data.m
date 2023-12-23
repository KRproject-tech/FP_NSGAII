clc
clear all
close all hidden

%% add paths
add_pathes;

%% delete
delete( '*.asv')




%% load   
load ./save/pop_data.mat


%% Pareto front extraction


jj_vec = [];
h_f_elite_vec = [];
for jj = 1:length( h_f_vec)       

    f_vec = h_f_vec{jj};  
    pop_rank = h_pop_rank{jj};
    
    idx_pop_rank1 = pop_rank{1};
    f_elite_vec = f_vec(idx_pop_rank1,:);

    jj_vec = [ jj_vec; jj*ones(size( f_elite_vec(:,1)))];
    h_f_elite_vec = [ h_f_elite_vec; f_elite_vec];

end




%% Pareto front plot

i_ax = 1;

h_fig(1) = figure(1);
set( h_fig(1))
h_ax(i_ax) = axes( 'Parent', h_fig(1));


plot3( h_ax(i_ax), f_elite_vec(:,1), f_elite_vec(:,2), f_elite_vec(:,3), 'o')
xlabel( h_ax(i_ax), '{\itf}_1', 'FontName', 'Times New Roman', 'FontSize', 20)
ylabel( h_ax(i_ax), '{\itf}_2', 'FontName', 'Times New Roman', 'FontSize', 20)
zlabel( h_ax(i_ax), '{\itf}_3', 'FontName', 'Times New Roman', 'FontSize', 20)
grid( h_ax(i_ax), 'on')
xlim( h_ax(i_ax), [0 1])
ylim( h_ax(i_ax), [-1 0])
zlim( h_ax(i_ax), [-0.1 0.05 ])

i_ax = i_ax + 1;


%% convergence plot

h_fig(2) = figure(2);
set( h_fig(2))
h_ax(i_ax) = axes( 'Parent', h_fig(2));

scatter3( jj_vec, h_f_elite_vec(:,1), h_f_elite_vec(:,2), 10*jj_vec/length( h_f_vec) + 25, jj_vec, 'filled', 'Marker', 'o', 'Parent', h_ax(i_ax))
box( h_ax(i_ax), 'on')
ylabel( h_ax(i_ax), '{\itf}_1', 'FontName', 'Times New Roman', 'FontSize', 20)
zlabel( h_ax(i_ax), '{\itf}_2', 'FontName', 'Times New Roman', 'FontSize', 20)
ylim( h_ax(i_ax), [ 0 1])
zlim( h_ax(i_ax), [ -1 0])
view( h_ax(i_ax), [ 1 0 0])
colormap autumn


h_col = colorbar;
ylabel( h_col, 'step', 'FontName', 'Times New Roman', 'FontSize', 20)

set( [ h_ax h_col], 'FontName', 'Times New Roman')
       

i_ax = i_ax + 1;




%% save

fig_name = { 'Pareto_front', 'Pareto_convergence'};

for ii = 1:length( fig_name)
    
    saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.fig']) 
    
    set( h_fig(ii), 'PaperPositionMode', 'auto')
    fig_pos = get( h_fig(ii), 'PaperPosition');
    set( h_fig(ii), 'Papersize', [fig_pos(3) fig_pos(4)]);
    
    saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.pdf']) 
end

%% Finish
warndlg( 'Finish!!')


