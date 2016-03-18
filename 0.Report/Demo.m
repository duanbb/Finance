% =========================================================================
% Matlab version: R2015b
% Character encoding: Shift-JIS
% Qn_���������O��n�����Ԥ��줿����
% =========================================================================
clearvars

%% �O��1
Q1_Settle = datenum('31-Mar-2015');%�Q����
Q1_CouponRate = [0.03 0.037 0.057 0.093 0.131 0.149 0.173 0.261 0.326 0.398 0.758 1.133 1.272 1.357 1.464]';%���_����Ƥ��륯�`�ݥ��`��
Q1_NSFunction = DetermineZeroYieldCurve(Q1_CouponRate, Q1_Settle, 1);%�ե��åȤ��줿Nelson-Seigel�v��

%% �O��2 
Q2_CFDates = datenum({'30-Sep-2015', '31-Mar-2016', '30-Sep-2016', '31-Mar-2017', '30-Sep-2017',...
    '31-Mar-2018', '30-Sep-2018', '31-Mar-2019', '30-Sep-2019', '31-Mar-2020'})';%ȡ���r��
Q2_Compounding = 2;%���`�ݥ�֧�B������2�أ�1��31�ա�7��31�գ�
Q2_DiscountFactor = getDiscountFactors(Q1_NSFunction, Q2_CFDates);%�����S�����ꤢ����2���g��5���g�Ϥ碌��10���g��
Q2_Value = 1-Q2_DiscountFactor(length(Q2_CFDates));%��ӽ������֤Εr�����̶��������֤Εr���ȵȤ�����
Q2_SwapRate = Q2_Value/sum(Q2_DiscountFactor);%����åץ�`��
fprintf('Answer 2: Swap rate is %.4f%%.\n', Q2_SwapRate*100);%�Y���α�ʾ

%% �O��3
Q3_Settle = datenum('30-Jun-2015');%�Q����
Q3_CouponRate = [0 -0.003 0.016 0.058 0.111 0.151 0.211 0.308 0.381 0.451 0.822 1.202 1.357 1.449 1.572]';%���_����Ƥ��륯�`�ݥ��`��
Q3_NSFunction = DetermineZeroYieldCurve(Q3_CouponRate, Q3_Settle, 3);
Q3_DiscountFactor = getDiscountFactors(Q3_NSFunction, Q2_CFDates);%�����S���������£�0.5���g�������
Q3_FloatingValue = 1-Q3_DiscountFactor(length(Q2_CFDates));%��ӽ������֤Εr��
Q3_FixedValue = Q2_SwapRate*sum(Q3_DiscountFactor);%�̶��������֤Εr��
Q3_Value = Q3_FloatingValue-Q3_FixedValue;%����åפΕr��
fprintf('Answer 3: Value of interest rate swap is %.4fN (N is principal).\n', Q3_Value);%�Y���α�ʾ

%% �O��4
Q4_Maturity = datenum('31-Jan-2019');%����
Q4_CouponRate = 0.92/100;%���_����Ƥ������ʣ����`�ݥ��`�ȣ�
[Q4_CFAmounts, Q4_CFDates] = cfamounts(Q4_CouponRate, Q1_Settle, Q4_Maturity, Q2_Compounding);%����å���ե�`�Υǩ`����Ӌ�㤹��
%����å���ե�`������
figure
cfplot(Q4_CFDates, Q4_CFAmounts, 'ShowAmnt', 'all', 'DateFormat', 1, 'DateSpacing', 100)
title('Cash flow of Question 4')

Q4_CFDates = Q4_CFDates(2:end);%���`�ݥ�֧�B����
Q4_AccruedInt = -Q4_CFAmounts(1);%�U�^��Ϣ
Q4_CFAmounts = Q4_CFAmounts(2:end);%֧�B�����~
Q4_SpotRate = getZeroRates(Q1_NSFunction, Q4_CFDates);%�o�ꥹ�����ݥåȥ�`��
[Q4_RateSpec, ~] = intenvset('Rates', Q4_SpotRate, 'StartDates', repmat(Q1_Settle, length(Q4_CFDates), 1), 'EndDates', Q4_CFDates', 'Compounding', Q2_Compounding);
Q4_CleanPrice = cfbyzero(Q4_RateSpec, Q4_CFAmounts, Q4_CFDates, Q1_Settle);%����`��r��
Q4_DirtyPrice = Q4_CleanPrice + Q4_AccruedInt;%���`�ƥ��r��
fprintf('Answer 4: Clean price is %.4f. Dirty price is %.4f.\n', Q4_CleanPrice, Q4_DirtyPrice);%�Y���α�ʾ

%% �O��5
[Q5_Modified, Q5_Macaulay, ~] = bnddurp(Q4_CleanPrice, Q4_CouponRate, Q1_Settle, Q4_Maturity, Q2_Compounding);%�ǥ��`�����
fprintf('Answer 5: Macaulay duration is %.4f, Modified duration is %.4f.\n', Q5_Macaulay, Q5_Modified);%�Y���α�ʾ

[Q5_RateSpec, ~] = intenvset('Rates', Q4_SpotRate + 0.01, 'StartDates', repmat(Q1_Settle, 1, length(Q4_CFDates)), 'EndDates', Q4_CFDates, 'Compounding', Q2_Compounding);
Q5_Price = cfbyzero(Q5_RateSpec, Q4_CFAmounts, Q4_CFDates, Q1_Settle);%������ȫ����һ��1%�ϕN�����H�Εr��
Q5_ChangeOfPrice = Q5_Price - Q4_CleanPrice;%����仯
fprintf('          Change of price is %.4f.\n', Q5_ChangeOfPrice);%�Y���α�ʾ

%% �O��6 
Q6_ReportedPrice = 102.14;%���I�ο��yӋ���Εr����ƽ������
syms x
Q6_ChangeOfRate = double(vpasolve(Q6_ReportedPrice == ...
    100 / (1+(Q4_SpotRate(end) + x) / Q2_Compounding)^length(Q4_SpotRate) + ...
    Q4_CouponRate * 100 / Q2_Compounding * sum(1./(1 + (Q4_SpotRate' + x) / Q2_Compounding).^(1:length(Q4_SpotRate))),...
    x, [0 Inf]));%�ρ\����x���v���뷽��ʽ��⤯
clear x;
fprintf('Answer 6: If the spot rates of each period increase by %.4f%%, the price is equivalent to the reported price (%.4f).\n', Q6_ChangeOfRate*100, Q6_ReportedPrice);%�Y���α�ʾ

%% �O��7
Q7_RecoveryRate = 0.4;%�؅���
Q7_DefaultIntensity = Q6_ChangeOfRate / (1-Q7_RecoveryRate);%���b����
fprintf('Answer 7: Default intensity is %.4f.\n', Q7_DefaultIntensity);%�Y���α�ʾ