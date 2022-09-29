# FP_NSGAII
Multi-objective optimization analysis by NSGA-II with Floating Point representation (MATLAB R2007b - ).

## Usage

__[Step 1] Set the evaluation function__ 

Edit the code for evaluation functions in "./NSGA_2_functions/evaluation_func.m".

__[Step 2] Set the parameters for optimization__ 

Edit the code for parameters in "./save/param_NSGA.m".

__[Step 3] Start optimization__

Execute the code in "exe.m".

__[Step 4] Restart optimization__

Execute the code in "exe_func_restart.m".


## Image

![untitled](https://user-images.githubusercontent.com/114337358/192941614-b21db790-023d-4ea5-b123-1c01fb182c7b.png)

__MOP3__ bench problem

$$ 
\begin{eqnarray}
&& f_1(x_1,x_2,x_3) = 0.5(x_1^2 + x_2^2) + \sin(x_1^2 + x_2^2) \\
&& f_2(x_1,x_2,x_3) = \frac{1}{8}(3 x_1^2 - 2 x_2^2 + 4)^2 + \frac{1}{27}(x_1^2 - x_2^2 + 1)^2 + 15 \\
&& f_3(x_1,x_2,x_3) = \frac{1}{x_1^2 + x_2^2 + 1} - 1.1 \exp( -x_1^2 - x_2^2 )
\end{eqnarray}
$$

## References

[1] K. Deb, A. Pratap, S. Agarwal, T. Meyarivan, A fast and elitist multiobjective genetic algorithm: NSGA-II, IEEE Transactions on Evolutionary Computation 6 (2) (2002) 182–197. doi:10.1109/4235.996017.

[2] C. Su, A genetic algorithm approach employing floating point representation for economic dispatch of electric power, in: The International Congress on Modelling and Simulation 1997, Vol. 204, 1997, pp. 1444–1449.

[3] Reducing the Power Consumption of a Shape Memory Alloy Wire Actuator Drive by Numerical Analysis and Experiment, IEEE/ASME Transactions on Mechatronics, Vol. 23, No. 4 (2018).

https://doi.org/10.1109/TMECH.2018.2836352
