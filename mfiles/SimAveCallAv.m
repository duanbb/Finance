%
% SimAveCallAv.m  アベレージ・オプションに対照変量を適用
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. パラメータ設定
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=0.05;      % 金利（100r ％／年）
sigma=0.25;  % ボラティリティ（100sigma ％／年）
T=3/12;      % 満期（年）
S0=100;      % 初期価格
K=100;       % 行使価格
N=10000;     % シミュレーション回数 
L=63;        % 期間の分割数
alpha=0.05;  % 1-信頼水準

randn('state',1);  % 乱数の初期状態の設定
delta=T/L;         % 単位時間間隔

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. 原資産価格のサンプルパスの生成，ペイオフの計算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=zeros(1,N);
hhat=zeros(1,N);
h2=zeros(1,N);

for i=1:N  % シミュレーションの反復
  X=zeros(1,L);
  B=zeros(1,L);
  S=zeros(1,L);
  Shat=zeros(1,L);
  X=sqrt(delta)*randn(1,L);  % ブラウン運動の差分Xのサンプリング
  B=cumsum(X);  % ブラウン運動B1,...,BLの計算
  S=S0*exp((r-sigma^2/2)*delta*(1:L)+sigma*B);  % 価格過程Sの計算
  Shat=S0^2*exp((2*r-sigma^2)*delta*(1:L))./S;  % hat(S)の計算
  h(i)=max(mean(S)-K,0);  % ペイオフh(S)の計算
  hhat(i)=max(mean(Shat)-K,0);  % 対照変量のペイオフh(hat(S))の計算
  h2(i)=(h(i)+hhat(i))/2;  % (h(S)+h(hat(S)))/2の計算
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. オプション価格の平均・信頼区間の計算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Yn=mean(h2);  % サンプル平均
sd=std(exp(-r*T)*h2);  % サンプル標準偏差
corr=diag(corrcoef(h,hhat),1);  % サンプル相関係数

price=exp(-r*T)*Yn;   % オプション価格
CI=[exp(-r*T)*(Yn-norminv(1-alpha/2)*sd/sqrt(N)), ...
  exp(-r*T)*(Yn+norminv(1-alpha/2)*sd/sqrt(N))];  % 信頼区間

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. 結果の表示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(sprintf('option price = %6.4f%n',price));
disp(sprintf('SD           = %6.4f%n',sd));
disp(sprintf('95%% C.I.     = [%6.4f, %6.4f]%n',CI(1),CI(2)));
disp(sprintf('corr. coef.  = %6.4f%n',corr));
