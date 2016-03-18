x0 = [-5; -5];%注：初始迭代点
options=optimset('Display','iter');  %注：显示迭代过程结果
[x,fval] = fsolve(@Eqfun,x0,options) %注：调用 fsolve 函数进行求解
