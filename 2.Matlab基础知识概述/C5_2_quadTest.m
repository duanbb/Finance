%定义符合变量
%中间为空格，不能为逗号
syms x y  
% int(x*y,x,0,1)计算x*y,关于x在［０，１］上的积分
%再计算函数关于y，在［1,2］的积分
s=int(x*y,x,0,1)
ss=int(s,y,1,2 )