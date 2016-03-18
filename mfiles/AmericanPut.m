%
% AmericanPut.m (二項モデルによるアメリカンプットオプション解析)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. パラメータの設定
% 
% S0; 原資産初期値:            sigma; ボラティリティ:        
% r; リスクフリーレート:       rho; 配当率(配当無しの場合は0):
% T; オプション満期(年):       N; 期間数:   
% K; 行使価格:                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S0 = 100; sigma = 0.4; r = 0.1; K = 100; T = 3/12; 

rho = 0; %rho = 0.1; rho = 0.2;  
    % 配当率(配当無しの場合は0).
N = 8;      % 期関数
dt = T/N;   % 各期間の長さ
af = exp((r-rho)*dt); 
    % 配当を考慮した1期間のaccumulation factor

u = exp(sigma*sqrt(dt)); d = 1/u; % 上昇率、および下降率
p = (af-d)/(u-d); q = 1-p;        % リスク中立確率 (p;上昇, q; 下降)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. 原資産二項モデルの計算
% 
% S; 原資産価格行列 (N+1行N+1列)
%    ただし、S(jj,nn)はnn-1ステップにおける上からjj番目のノード
%    における原資産価格
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S = NaN*ones(N+1,N+1);

for nn = 1:N+1,
  for jj = 1:nn,
     S(jj,nn)=u^(nn-jj)*d^(jj-1)*S0;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. プットオプション二項モデルの計算
% 
% Ap; アメリカンプットオプション価格行列 (N+1行N+1列)
%     Ap(jj,nn)はnn-1ステップにおける上からjj番目のノードにおける
%     オプション価値
% Sk; アメリカンプットオプション行使価値行列 (N+1行N+1列)
%     Sk(jj,nn)はnn-1ステップにおける上からjj番目のノードにおける
%     行使価値
% Dk; アメリカンプットオプション行使判定行列 (N+1行N+1列)
%     Dk(jj,nn)はnn-1ステップにおける上からjj番目のノードが、継続
%     領域に入る場合は零、行使領域に入る場合は1が入る
% ex_period; 早期行使が始めて起こったピリオド(時点)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sk=max(K-S,0);                 % 行使価値行列の計算
Dk=NaN*ones(N+1,N+1);          % 行使判定行列の初期化
Ap = NaN*ones(N+1,N+1);        % 価格行列の初期化

Ap(:,N+1) = max(K-S(:,N+1),0); 
Dk(:,N+1) = max(K-S(:,N+1),0)./max(K-S(:,N+1),eps);
ex_period = N; 
for nn = N:-1:1,
  for jj = 1:nn,
    Ap_d = exp(-r*dt)*(p*Ap(jj,nn+1)+q*Ap(jj+1,nn+1)); % 継続価値の計算
    Ap(jj,nn)= max(Ap_d,Sk(jj,nn));                    % 行使価値との比較
    Dk(jj,nn)=0;
    if Ap(jj,nn)==Sk(jj,nn)&Sk(jj,nn)>0,
      Dk(jj,nn)=1;             % 継続領域にある場合は零
      ex_period = nn-1;        % 早期行使時点の更新
    end
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. オプション初期価格の表示と行使領域の検討
% 
% ex_time; 早期行使が始めて起こった時間
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ap0 = Ap(1,1); % 二項モデルにおけるオプション初期価格
     
disp('  アメリカンプットオプション価格 Ap0 = ');
disp(Ap0)

ex_time = ex_period*dt;

disp('  最も早い行使時間 ex_time = ');
disp(ex_time)



