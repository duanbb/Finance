%
% SimDiPutCm.m  ダウン・アンド・イン・プット・オプションと条件付きモンテカルロ法
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. パラメータ設定
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=0.05;      % 金利（100r ％／年）
sigma=0.25;  % ボラティリティ（100sigma ％／年）
T=4/12;      % 満期（年）
S0=100;      % 初期価格
K=100;       % 行使価格
Kb=90;       % バリア
N=10000;     % シミュレーション回数 
L=84;        % 期間の分割数
alpha=0.05;  % 1-信頼水準

randn('state',1);  % 乱数の初期状態の設定
delta=T/L;  % 単位時間間隔

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. 原資産価格のサンプルパスの生成，ペイオフの計算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=zeros(1,N);

numin=0;  % ダウン・インの発生回数

for i=1:N  % シミュレーションの反復
  S=zeros(1,L);
  for n=1:L  % 各ステップの反復
    if n==1
      S(1)=S0*exp((r-sigma^2/2)*delta+sigma*sqrt(delta)*randn);  % S1のサンプル
    else
      S(n)=S(n-1)*exp((r-sigma^2/2)*delta+sigma*sqrt(delta)*randn);
                                                                 % Snのサンプル
    end
    if S(n)<Kb
      [BScall,BSput]=blsprice(S(n),K,r,T-n*delta,sigma,0);  % BSオプション価格
      h(i)=exp(r*(T-n)*delta)*BSput;  % ペイオフの計算（ダウン・インした場合）
      numin=numin+1;  %  ダウン・インの発生回数をカウント
      break;
    end
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. オプション価格の平均・信頼区間の計算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YN=mean(h);
sd=std(h);

price=exp(-r*T)*YN;   % オプション価格
CI=[exp(-r*T)*(YN-norminv(1-alpha/2)*sd/sqrt(N)), ...
  exp(-r*T)*(YN+norminv(1-alpha/2)*sd/sqrt(N))];  % 信頼区間

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. 結果の表示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(sprintf('option price = %6.4f%n',price));
disp(sprintf('SD           = %6.4f%n',sd));
disp(sprintf('95%% C.I.     = [%6.4f, %6.4f]%n',CI(1),CI(2)));
disp(sprintf('#down in     = %d%n',numin));
