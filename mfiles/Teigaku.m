%
% Teigaku.m (二項モデルによる変更オプションの評価)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. 初期パラメータの設定
% ARPU0; 従量制を継続する場合のARPU
% uprate; 定額制を導入する場合のARPUの増加率
% K; 定額制を導入する場合のコスト(一人あたり)
% sigma; 契約者数ボラティリティ:       N; 期間数:    
% r; リスクフリーレート:       rho; 契約者減少率:
% T; オプション満期(年):       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S0 = 1; sigma = 0.3; r = 0.1; K = 1500; T = 24/12; 
ARPU0 = 5000; uprate = 0.2;

rho = 0.05; 
N = 100;            
dt = T/N; % 各期間の長さ
af = exp((r-rho)*dt); 
          % 契約者数減少率を考慮した1期間のaccumulation factor

u = exp(sigma*sqrt(dt)); d = 1/u; % 上昇率および下降率
p = (af-d)/(u-d); q = 1-p;        % リスク中立確率 (p;上昇, q; 下降)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. 契約者数二項モデルの計算
% 
% S; 契約者数行列 (N+1行N+1列)
%    ただし, S(jj,nn)はnn-1ステップにおける上からjj番目のノード
%    における契約者数(ただし，初期時点の契約者数は1に正規化)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S = NaN*ones(N+1,N+1);

for nn = 1:N+1,
  for jj = 1:nn,
     S(jj,nn)=u^(nn-jj)*d^(jj-1)*S0;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. 変更オプション二項モデルの計算
% 
% Ac; 変更オプション価値を考慮した事業価値行列 (N+1行N+1列)
%     Ac(jj,nn)はnn-1ステップにおける上からjj番目のノードにおける
%     変更オプション価値を考慮した事業価値
% Cc; 従量制を継続する場合の事業価値行列 (N+1行N+1列)
%     Cc(jj,nn)はnn-1ステップにおける上からjj番目のノードにおける
%     変更オプションが無い場合の事業価値
% Dk; アメリカンコールオプション行使判定行列 (N+1行N+1列)
%     Dk(jj,nn)はnn-1ステップにおける上からjj番目のノードが、継続
%     領域に入る場合は零、行使領域に入る場合は1が入る(行使→1, 継続→0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ARPU1 = ARPU0*S;
ARPU2 = max((1+uprate)*ARPU0*S-K*ones(N+1,N+1),0);

Sk=max(ARPU1,ARPU2);           % 行使価値行列の計算
Dk=NaN*ones(N+1,N+1);          % 行使判定行列の初期化
Ac = NaN*ones(N+1,N+1);        % 変更オプション付事業価値行列の初期化
Cc = NaN*ones(N+1,N+1);        % 変更オプション無事業価値行列の初期化

Ac(:,N+1) = Sk(:,N+1); Cc(:,N+1) = ARPU1(:,N+1); 
Dk(:,N+1) = floor(ARPU2(:,N+1)./Sk(:,N+1));
ll = N; 
for nn = N:-1:1,
  for jj = 1:nn,
    Ac_d = exp(-r*dt)*(p*Ac(jj,nn+1)+q*Ac(jj+1,nn+1)); % 継続価値の計算
    Ac(jj,nn)= max(Ac_d,ARPU2(jj,nn));                 % 行使価値との比較
    Dk(jj,nn)=0;
    if Ac(jj,nn)==ARPU2(jj,nn)&Sk(jj,nn)>0,
      Dk(jj,nn)=1;             % 継続領域にある場合は零
      ll = min(ll,nn-1);
    end
    Cc(jj,nn)= exp(-r*dt)*(p*Cc(jj,nn+1)+q*Cc(jj+1,nn+1)); 
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. オプション初期価格の表示と最も早い行使時点
% 
% Ac0; 二項モデルにおけるコールオプション初期価格
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ac0 = Ac(1,1)-Cc(1,1); % 二項モデルにおけるオプション初期価格
     
disp('  オプション価値 = ');
disp(Ac0)

disp('  最も早い行使時点(年後)  = ');
disp(ll*dt)

