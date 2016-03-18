%标的资产价格
Price=100;
%执行价格
Strike=95; 
%无风险收益率（年化）
Rate=0.1;%10%
%剩余时间
Time=6/12;%;
%看涨期权 
flag=1;
%每阶段间个1个月
Increment=1/12;
%波动率 
Volatility=0.5;
%注：基础资产的价格路径（S, price），相对应的看涨期权的价格（p, callprice）
[AssetPrice, OptionValue] = binprice(Price, Strike, Rate, Time, Increment, Volatility, flag)
%注：[CallDelta, PutDelta] = blsprice(Price, Strike, Rate, Time, Volatility)