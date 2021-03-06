%
% SimBSCall.m : ヨーロピアン・コール・オプションのブラック・ショールズ価格
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. パラメータ設定
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=0.05;      % 金利（100r %／年）
sigma=0.25;  % ボラティリティ（100sigma ％／年）
T=3/12;      % 満期（年）
S0=100;      % 初期価格
K=110;       % 行使価格
N=10000;     % シミュレーション回数 
alpha=0.05;  % 1-信頼水準

randn('state',1);  % 乱数の初期状態の設定

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. 原資産価格のサンプルパスの生成，ペイオフの計算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B=sqrt(T)*randn(1,N);
S=S0*exp((r-sigma^2/2)*T+sigma*B);
h=max(S-K,0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. オプション価格の平均・信頼区間の計算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Yn=mean(h);  % サンプル平均
sd=std(h);   % サンプル標準偏差

price=exp(-r*T)*Yn;   % オプション価格
CI=[exp(-r*T)*(Yn-norminv(1-alpha/2)*sd/sqrt(N)), ...
  exp(-r*T)*(Yn+norminv(1-alpha/2)*sd/sqrt(N))];  % 信頼区間
BSprice=blsprice(S0,K,r,T,sigma,0);  % ブラック・ショールズ価格

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. 結果の表示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(sprintf('option price = %6.4f%n',price));
disp(sprintf('SD           = %6.4f%n',sd));
disp(sprintf('95%% C.I.     = [%6.4f, %6.4f]%n',CI(1),CI(2)));
disp(sprintf('BS price     = %6.4f%n',BSprice));
