function f_vec = evaluation_func(pop_vec)
%% 評価関数 (pop_vecの行が個体番号，列が個体パラメータ)

x_vec = pop_vec;

%% SCH問題：パレート解 -> x in [0,2]
% f_vec = [x_vec(:,1).^2 ...
%          (x_vec(:,1) - 2).^2 ]; 

%% FON問題：パレート解 -> x1 = x2 = x3 in [-1/√3,1/√3] 
% f_k = @(k, x_vec)( 1 - exp( -sum( (x_vec + (-1).^k/sqrt(3)).^2 , 2) ) );
% f_vec = [f_k(1, x_vec) ...
%          f_k(2, x_vec)];
     
%% テスト問題2
a = 49;b = 4; c = 0.5;
f_1 = @(x_vec)( 0.5*(x_vec(:,1).^2 + x_vec(:,2).^2) + sin(x_vec(:,1).^2 + x_vec(:,2).^2) );
f_2 = @(x_vec)( -exp( -a*(cos( b*(x_vec(:,1) + x_vec(:,2)) ) - ((x_vec(:,1) - x_vec(:,2))) ).^2 - c*(x_vec(:,1) + x_vec(:,2) + 1).^2  ));
f_3 = @(x_vec)( 1./(x_vec(:,1).^2 + x_vec(:,2).^2 + 1) - 1.1*exp(-(x_vec(:,1).^2 + x_vec(:,2).^2)) );

f_vec = [f_1(x_vec) ...
         f_2(x_vec) ...
         f_3(x_vec)];

%% MOP3
% f_1 = @(x_vec)( 0.5*(x_vec(:,1).^2 + x_vec(:,2).^2) + sin(x_vec(:,1).^2 + x_vec(:,2).^2) );
% f_2 = @(x_vec)( ( 3*x_vec(:,1) - 2*x_vec(:,2) + 4 ).^2/8 + ( x_vec(:,1) - x_vec(:,2) + 1 ).^2/27 + 15 );
% f_3 = @(x_vec)( 1./(x_vec(:,1).^2 + x_vec(:,2).^2 + 1) - 1.1*exp(-(x_vec(:,1).^2 + x_vec(:,2).^2)) );
% 
% f_vec = [f_1(x_vec) ...
%          f_2(x_vec) ...
%          f_3(x_vec)];

%% テスト問題 (最適解：部分球面)
% g_func = @(x3)( sin(x3) + 1 );
% f_1 = @(x_vec)( (1 + g_func(x_vec(:,3))).*( abs(cos(x_vec(:,1)).*cos(x_vec(:,2)) ) + 1e-3) );
% f_2 = @(x_vec)( (1 + g_func(x_vec(:,3))).*( abs(cos(x_vec(:,1)).*sin(x_vec(:,2)) ) + 1e-3) );
% f_3 = @(x_vec)( (1 + g_func(x_vec(:,3))).*(abs(sin(x_vec(:,1)) ) + 1e-3) );
% 
% f_vec = [f_1(x_vec) ...
%          f_2(x_vec) ...
%          f_3(x_vec)];
