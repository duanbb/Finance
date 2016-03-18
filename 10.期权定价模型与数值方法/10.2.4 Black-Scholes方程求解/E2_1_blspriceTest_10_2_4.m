%标的资产价格
Price=100;%注：S（不是预计的，是当前的股价）
%执行价格
Strike=95; %注：K（注：S>K，in the money）
%无风险收益率（年化）
Rate=0.1;%10%
%剩余时间
Time=3/12;%=0.25;
%年化波动率 %注：标的资产价格的~
Volatility=0.5;
[CallDelta, PutDelta] = blsprice(Price, Strike, Rate, Time, Volatility)