![図1](https://user-images.githubusercontent.com/114337358/219954099-4fb00380-c782-446b-ada5-273ca26eb07b.png)

# <p align=center>FP_NSGAII</p>

**Communication**

<a style="text-decoration: none" href="https://twitter.com/hogelungfish_" target="_blank">
    <img src="https://img.shields.io/badge/twitter-%40hogelungfish_-1da1f2.svg" alt="Twitter">
</a>
<p>

**Language**
<p>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/matlab/matlab-original.svg" width="60"/>
<p>


__Multi-objective optimization analysis by Non-dominated Sorting Genetic Algorithm (NSGA-II) [^1] with Floating Point representation [^2][^4] (MATLAB R2007b - ).__

    
## Directory
<pre>
└─NSGA_2_ver3
    ├─Bench_mark
    │  └─進化計算パラメータ
    │      └─html
    ├─cores
    │  └─functions
    │      └─NSGA_2_functions
    └─save
        └─fig
</pre>

<!---
## Publications

If you use this work in an academic context, please cite the following publication(s):

* Reducing the Power Consumption of a Shape Memory Alloy Wire Actuator Drive by Numerical Analysis and Experiment, IEEE/ASME Transactions on Mechatronics, Vol. 23, No. 4 (2018).  
https://doi.org/10.1109/TMECH.2018.2836352

````
@ARTICLE{8358981,
  author={Yamano, Akio and Shintani, Atsuhiko and Ito, Tomohiro and Nakagawa, Chihiro},
  journal={IEEE/ASME Transactions on Mechatronics}, 
  title={Reducing the Power Consumption of a Shape Memory Alloy Wire Actuator Drive by Numerical Analysis and Experiment}, 
  year={2018},
  volume={23},
  number={4},
  pages={1854-1865},
  doi={10.1109/TMECH.2018.2836352}
}
````
-->    
    
## Usage


__[Step 1] Start GUI form__

Open the “GUI.fig” from MATLAB.

![image](https://github.com/KRproject-tech/FreeSurface_Vortex_Sheet_Model/assets/114337358/1ec9b2fd-6ca4-4a68-bffa-2ccf86901921)


__[Step 2] Pre-setting__

Edit the code for evaluation functions in "./cores/functions/NSGA_2_functions/evaluation_func.m".

````
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
````

Next, push the "Parameters" button and edit parameters, or edit the code for parameters in "./save/param_setting.m".

````
%% parameter for NSGA-2

%----------------------- 解析パラメータ ------------------------------------
GENERATION = 200; %% GENERATION[-]
TOURNAMENT_RATE = 0.5; %% TOURNAMENT_RATE[-]
CROSSOVER_RATE = 1.0; %% CROSSOVER_RATE[-]
MUTATION_RATE = 0.4; %% 突然変異個体選択率[-]
MUTATION_RATE_1 = 0.8; %% 突然変異率[-]

%----------------------- 個体パラメータ ------------------------------------
MAX_POP_NUM = 500; %% the number of Populations[-]
POP_LGT = 3; %% Length of variable[-]
% Initial value of populations [-]
pop_weight = 0.1*ones(1,POP_LGT); 
% Mutation change width
pop_mutation_width = 10*pop_weight;
````

__[Step 3] Start optimization__

Push the “exe” button or execute the code in "./cores/exe.m", and wait until the finish of the analysis.

__[Step 4] Restart optimization (if solutions do not converge at [Step 3])__

Execute the code in "./cores/exe_func_restart.m".

__[Step 5] Plot results__

Push the “plot” button.
    
__[Step 6] View plotted results__

Results (figures and movie) plotted by [Step 4] are in "./save" directory.



## Optimal results

Optimal solutions are in `h_pop_vec{end}(pop_rank{1},:)`.

Pareto-front is plotted by `plot3(f_vec(pop_rank{1},1),f_vec(pop_rank{1},2),f_vec(pop_rank{1},3),'ro')`

## Gallery


__MOP3__ bench problem [^3]

$$
\min_{x \in \mathbb{R}^2} f_1, f_2, f_3, 
$$

where,

$$ 
\left.
\begin{eqnarray}
&& f_1(x_1,x_2) = 0.5(x_1^2 + x_2^2) + \sin(x_1^2 + x_2^2) \\
&& f_2(x_1,x_2) = \frac{1}{8}(3 x_1^2 - 2 x_2^2 + 4)^2 + \frac{1}{27}(x_1^2 - x_2^2 + 1)^2 + 15 \\
&& f_3(x_1,x_2) = \frac{1}{x_1^2 + x_2^2 + 1} - 1.1 \exp( -x_1^2 - x_2^2 )
\end{eqnarray}
\right).
$$

![untitled](https://user-images.githubusercontent.com/114337358/192941614-b21db790-023d-4ea5-b123-1c01fb182c7b.png)

__ZDT3__ bench problem [^5]

$$
\min_{x \in \mathbb{R}^N} f_1, f_2, 
$$

where, $x_i := 2^{-1} \left(\frac{2}{\pi} \tan^{-1}{ x^*_i} + 1\right), i \in \\{1, \ldots, N \\}, N=30$ and,

$$ 
\left.
\begin{eqnarray}
&& f_1(x_i) = x_1 \\
&& f_2(x_i) = g(x_i) h( f_1(x_i), g(x_i)) \\
&& g(x_i) := 1 + \frac{9}{N-1} \sum_{k=2}^N x_k \\
&& h(f_1, g) := 1 - \sqrt{ \frac{f_1}{g} } - \frac{f_1}{g} \sin{ 10 \pi f_1 } \\
\end{eqnarray}
\right).
$$

The red solid line includes the analytical solution of the Pareto front for the ZDT3 problem,

$$ 
\left.
\begin{eqnarray}
&& x_i = 0,  i \in \\{2, \ldots, N \\} \\
&& x_1 \in [0, 1] \\
\end{eqnarray}
\right).
$$

Namely, 

$$ 
\left.
\begin{eqnarray}
&& g(x_i) = 1 \\
&& f_2(x_i) = g(x_i) \cdot h( f_1(x_i), g(x_i)) = 1 \cdot h( f_1(x_i), 1) = 1 - \sqrt{ f_1 } - f_1 \sin{ 10 \pi f_1 } \\
\end{eqnarray}
\right).
$$

![GXatie2bwAQvkk0](https://github.com/user-attachments/assets/5fb7714f-f632-41bd-a15e-70a70f8a1bc9)



__DTLZ7__ bench problem [^6]

$$
\min_{x \in \mathbb{R}^N} f_1, f_2, f_3, 
$$

where, $x_i := 2^{-1} \left(\frac{2}{\pi} \tan^{-1}{ x^*_i} + 1\right), i \in \\{1, \ldots, N \\}, N=20$ and,

$$ 
\left.
\begin{eqnarray}
&& f_1(x_i) = x_1 \\
&& f_2(x_i) = x_2 \\
&& f_3(x_i) = (1 + g(x_i)) h( f_1(x_i), f_2(x_i), g(x_i)) \\
&& g(x_i) := 1 + \frac{9}{N-1} \sum_{k=2}^N x_k \\
&& h(f_1, g) := 1 - \sqrt{ \frac{f_1}{g} } - \frac{f_1}{g} \sin{ 10 \pi f_1 } \\
\end{eqnarray}
\right).
$$

### References
[^1]: K. Deb, A. Pratap, S. Agarwal, T. Meyarivan, A fast and elitist multiobjective genetic algorithm: NSGA-II, IEEE Transactions on Evolutionary Computation 6 (2) (2002) 182–197. doi:10.1109/4235.996017.

[^2]: C. Su, A genetic algorithm approach employing floating point representation for economic dispatch of electric power, in: The International Congress on Modelling and Simulation 1997, Vol. 204, 1997, pp. 1444–1449.

[^3]: Veldhuizen, D.A.V. and Lamont, G.B., Multiobjective evolutionary algorithm test suites, Proceedings of the 1999 ACM symposium on Applied computing, February 1999.

[^4]: Reducing the Power Consumption of a Shape Memory Alloy Wire Actuator Drive by Numerical Analysis and Experiment, IEEE/ASME Transactions on Mechatronics, Vol. 23, No. 4 (2018).  
https://doi.org/10.1109/TMECH.2018.2836352

[^5]: Zitzler, E., Thiele, L., Laumanns, M., Fonseca, C., and Fonseca, da V., Performance assessment of multiobjective optimizers: an analysis and review, IEEE Transactions on Evolutionary Computation, Vol. 7, No. 2, pp. 117–132 (2003).

[^6]: K. Deb et al, Scalable Test Problems for Evolutionary Multi-Objective Optimization, TIK-Technical Report No. 112, 2001.
