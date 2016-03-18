%TestImpliedVolatility
Price=100; %注：市场价格
Strike=95; %注：执行价格
Rate=0.10; %注：无风险利率
Time=1.0; %注：时间 （年）
CallPrice=15.0; %注：看涨期权交易价格
PutPrice=7.0; %注：看跌期权交易价格
%注：没有波动
[Vc,Vp,Cfval,Pfval]=ImpliedVolatility(Price,Strike,Rate,Time,CallPrice,PutPrice)