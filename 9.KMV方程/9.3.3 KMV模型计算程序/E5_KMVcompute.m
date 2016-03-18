%test KMV
%r: risk-free rate
r=0.0225; %注：无风险利率

%T: Time to expiration
T=1;%输入 年数%注：预测周期1年

%DP:Defaut point
%SD: short debt,  LD: long debt
SD=1e8;%输入 %注：短期债务（流动负债）
LD=4e7;%输入 %注：长期债务
%计算违约点 %注：公司负债的市场价值
DP=SD+0.5*LD;%注：根据公司的负债计算出公司的违约实施点 （default exercise poin t，为企业一年以下短期债务的价值加上未清偿长期债务账面价值的一半，具体可以根据需要设定）

%D:Debt maket value
D=DP;%债务的市场价值，可以修改


%theta: volatility
%PriceTheta:  volatility of stock price
PriceTheta=0.2893;%(输入）
%EquityTheta: volatility of Theta value
EquityTheta=PriceTheta;%注：公司的股权价值（年）波动率
%AssetTheta: volatility of asset

%E:Equit maket value
E=141276427;%注：公司的股权价值
%Va: Value of asset

%to compute the Va and AssetTheta
[Va,AssetTheta]=KMVOptSearch(E,D,r,T,EquityTheta)

%计算违约距离
DD=(Va-DP)/(Va*AssetTheta)
%计算违约率
EDF=normcdf(-DD)