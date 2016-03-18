%注：9.3.3
function [Va,AssetTheta]=KMVOptSearch(E,D,r,T,EquityTheta)
%KMVOptSearch
%code by ariszheng@gmail.com
EtoD=E/D;
x0=[1,1];%搜素初始点
VaThetaX=fsolve(@(x) KMVfun(EtoD,r,T,EquityTheta,x), x0);%注：调用 fsolve 函数求解方程组
Va=VaThetaX(1)*E;%注：还原市值
AssetTheta=VaThetaX(2);%注：公司市场价值的波动率
% F=KMVfun(EtoD,r,T,EquityTheta,x)