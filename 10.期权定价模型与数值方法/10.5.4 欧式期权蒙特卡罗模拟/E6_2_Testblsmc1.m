%注
S0=50;%股票当前价格
K=52;%执行价
r=0.1;%无风险利率
T=5/12;%期权的到期日
sigma=0.4;%股票波动的标准差
NRepl=10000;%模拟次数
%欧式看涨期权的价格（对偶法）
[Price,VarPrice,Cl] = blsmc1(S0,K,r,T,sigma,NRepl)