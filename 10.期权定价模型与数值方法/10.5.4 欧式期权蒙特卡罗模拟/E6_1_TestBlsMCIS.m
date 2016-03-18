%注
S0=50;%股票当前价格
K=52;%执行价
r=0.1;%无风险利率
T=5/12;%期权的到期日
sigma=0.4;%股票波动的标准差
NRepl=1000;%模拟次数
%欧式看涨期权的价格
%欧式看涨期权的价格，模拟期权价格的方差，概率95%的期权置信区间
[Price,VarPrice,Cl] = BlsMCIS(S0,K,r,T,sigma,NRepl)

%欧式期权的解析公式（BSModel）
[call,put]= blsprice(S0,K,r,T,sigma)

NRepl=10000;
[Price1,VarPrice1,CI1]=BlsMCIS(S0,K,r,T,sigma,NRepl)