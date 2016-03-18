% =========================================================================
% Matlab version: R2015b
% Character encoding: Shift-JIS
% Qn_変数名：設問nで宣言された変数
% =========================================================================
clearvars

%% 設問1
Q1_Settle = datenum('31-Mar-2015');%決算日
Q1_CouponRate = [0.03 0.037 0.057 0.093 0.131 0.149 0.173 0.261 0.326 0.398 0.758 1.133 1.272 1.357 1.464]';%公開されているクーポンレート
Q1_NSFunction = DetermineZeroYieldCurve(Q1_CouponRate, Q1_Settle, 1);%フィットされたNelson-Seigel関数

%% 設問2 
Q2_CFDates = datenum({'30-Sep-2015', '31-Mar-2016', '30-Sep-2016', '31-Mar-2017', '30-Sep-2017',...
    '31-Mar-2018', '30-Sep-2018', '31-Mar-2019', '30-Sep-2019', '31-Mar-2020'})';%取引時点
Q2_Compounding = 2;%クーポン支払いは年2回（1月31日、7月31日）
Q2_DiscountFactor = getDiscountFactors(Q1_NSFunction, Q2_CFDates);%割引係数（年あたり2期間、5年間合わせて10期間）
Q2_Value = 1-Q2_DiscountFactor(length(Q2_CFDates));%変動金利部分の時価（固定金利部分の時価と等しい）
Q2_SwapRate = Q2_Value/sum(Q2_DiscountFactor);%スワップレート
fprintf('Answer 2: Swap rate is %.4f%%.\n', Q2_SwapRate*100);%結果の表示

%% 設問3
Q3_Settle = datenum('30-Jun-2015');%決算日
Q3_CouponRate = [0 -0.003 0.016 0.058 0.111 0.151 0.211 0.308 0.381 0.451 0.822 1.202 1.357 1.449 1.572]';%公開されているクーポンレート
Q3_NSFunction = DetermineZeroYieldCurve(Q3_CouponRate, Q3_Settle, 3);
Q3_DiscountFactor = getDiscountFactors(Q3_NSFunction, Q2_CFDates);%割引係数、三ヶ月（0.5期間）ずれる
Q3_FloatingValue = 1-Q3_DiscountFactor(length(Q2_CFDates));%変動金利部分の時価
Q3_FixedValue = Q2_SwapRate*sum(Q3_DiscountFactor);%固定金利部分の時価
Q3_Value = Q3_FloatingValue-Q3_FixedValue;%スワップの時価
fprintf('Answer 3: Value of interest rate swap is %.4fN (N is principal).\n', Q3_Value);%結果の表示

%% 設問4
Q4_Maturity = datenum('31-Jan-2019');%満期
Q4_CouponRate = 0.92/100;%公開されている利率（クーポンレート）
[Q4_CFAmounts, Q4_CFDates] = cfamounts(Q4_CouponRate, Q1_Settle, Q4_Maturity, Q2_Compounding);%キャッシュフローのデータを計算する
%キャッシュフローを引く
figure
cfplot(Q4_CFDates, Q4_CFAmounts, 'ShowAmnt', 'all', 'DateFormat', 1, 'DateSpacing', 100)
title('Cash flow of Question 4')

Q4_CFDates = Q4_CFDates(2:end);%クーポン支払い日
Q4_AccruedInt = -Q4_CFAmounts(1);%経過利息
Q4_CFAmounts = Q4_CFAmounts(2:end);%支払い金額
Q4_SpotRate = getZeroRates(Q1_NSFunction, Q4_CFDates);%無リスクスポットレート
[Q4_RateSpec, ~] = intenvset('Rates', Q4_SpotRate, 'StartDates', repmat(Q1_Settle, length(Q4_CFDates), 1), 'EndDates', Q4_CFDates', 'Compounding', Q2_Compounding);
Q4_CleanPrice = cfbyzero(Q4_RateSpec, Q4_CFAmounts, Q4_CFDates, Q1_Settle);%クリーン時価
Q4_DirtyPrice = Q4_CleanPrice + Q4_AccruedInt;%ダーティ時価
fprintf('Answer 4: Clean price is %.4f. Dirty price is %.4f.\n', Q4_CleanPrice, Q4_DirtyPrice);%結果の表示

%% 設問5
[Q5_Modified, Q5_Macaulay, ~] = bnddurp(Q4_CleanPrice, Q4_CouponRate, Q1_Settle, Q4_Maturity, Q2_Compounding);%デュレーション
fprintf('Answer 5: Macaulay duration is %.4f, Modified duration is %.4f.\n', Q5_Macaulay, Q5_Modified);%結果の表示

[Q5_RateSpec, ~] = intenvset('Rates', Q4_SpotRate + 0.01, 'StartDates', repmat(Q1_Settle, 1, length(Q4_CFDates)), 'EndDates', Q4_CFDates, 'Compounding', Q2_Compounding);
Q5_Price = cfbyzero(Q5_RateSpec, Q4_CFAmounts, Q4_CFDates, Q1_Settle);%金利が全年限一律1%上昇した際の時価
Q5_ChangeOfPrice = Q5_Price - Q4_CleanPrice;%価格変化
fprintf('          Change of price is %.4f.\n', Q5_ChangeOfPrice);%結果の表示

%% 設問6 
Q6_ReportedPrice = 102.14;%売買参考統計値の時価（平均値）
syms x
Q6_ChangeOfRate = double(vpasolve(Q6_ReportedPrice == ...
    100 / (1+(Q4_SpotRate(end) + x) / Q2_Compounding)^length(Q4_SpotRate) + ...
    Q4_CouponRate * 100 / Q2_Compounding * sum(1./(1 + (Q4_SpotRate' + x) / Q2_Compounding).^(1:length(Q4_SpotRate))),...
    x, [0 Inf]));%上乗せ幅xに関する方程式を解く
clear x;
fprintf('Answer 6: If the spot rates of each period increase by %.4f%%, the price is equivalent to the reported price (%.4f).\n', Q6_ChangeOfRate*100, Q6_ReportedPrice);%結果の表示

%% 設問7
Q7_RecoveryRate = 0.4;%回収率
Q7_DefaultIntensity = Q6_ChangeOfRate / (1-Q7_RecoveryRate);%倒産強度
fprintf('Answer 7: Default intensity is %.4f.\n', Q7_DefaultIntensity);%結果の表示