%
% SimAveCallCv.m : �A�x���[�W�E�I�v�V�����ɐ���ϗʁi���ύ��v�j��K�p
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. �p�����[�^�ݒ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=0.05;      % �����i100r ���^�N�j
sigma=0.25;  % �{���e�B���e�B�i100sigma ���^�N�j
T=3/12;      % �����i�N�j
S0=100;      % �������i
K=100;       % �s�g���i
N=10000;     % �V�~�����[�V������ 
N1=N*0.1;    % �\���V�~�����[�V������
L=63;        % ���Ԃ̕�����
alpha=0.05;  % 1-�M������

randn('state',1);  % �����̏�����Ԃ̐ݒ�
delta=T/L;  % �P�ʎ��ԊԊu
cvmean=S0*(exp(r*delta*(L+1))-exp(r*delta))/(exp(r*delta)-1)/L; % ����ϗʂ̕���

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. �\���V�~�����[�V�����iC*�̐���j
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=zeros(1,N1);  % �W���V�~�����[�V�����̃y�C�I�t
cv=zeros(1,N1);  % ����ϗ�

for i=1:N1
  X=zeros(1,L);
  B=zeros(1,L);
  S=zeros(1,L);
  X=sqrt(delta)*randn(1,L);  % �u���E���^���̍���X�̃T���v�����O
  B=cumsum(X);  % �u���E���^��B�̌v�Z
  S=S0*exp((r-sigma^2/2)*delta*(1:L)+sigma*B);  % ���iS�̌v�Z
  h(i)=max(mean(S)-K,0);  % �y�C�I�th(S)�̌v�Z
  cv(i)=mean(S);  % ����ϗʁi���ω��i�j�̌v�Z
end
cast=diag(cov(h,cv),1)/var(cv);  % c*�̐����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. �����Y���i�̃T���v���p�X�̐����C�y�C�I�t�̌v�Z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=zeros(1,N);  % �W���V�~�����[�V�����̃y�C�I�t
cv=zeros(1,N);  % ����ϗ�
Z=zeros(1,N);  % ����ϗʂ𗘗p�����y�C�I�t

for i=1:N
  X=zeros(1,L);
  B=zeros(1,L);
  S=zeros(1,L);
  X=sqrt(delta)*randn(1,L);  % �u���E���^���̍���X�̃T���v�����O
  B=cumsum(X);  % �u���E���^��B�̌v�Z
  S=S0*exp((r-sigma^2/2)*delta*(1:L)+sigma*B);  % ���i�ߒ�S�̌v�Z
  h(i)=max(mean(S)-K,0);  % �W���V�~�����[�V�����̃y�C�I�t�̌v�Z
  cv(i)=mean(S)-cvmean;  % ����ϗʂ̌v�Z
  Z(i)=h(i)-cast*cv(i);  % ����ϗʂ𗘗p�����y�C�I�t�̌v�Z
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. �I�v�V�������i�̕��ρE�M����Ԃ̌v�Z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Yn=mean(Z);  % �T���v������
sd=std(exp(-r*T)*Z);  % �T���v���W���΍�
corr=diag(corrcoef(h,cv),1);  % �T���v�����֌W��

price=exp(-r*T)*Yn;   % �I�v�V�������i
CI=[exp(-r*T)*(Yn-norminv(1-alpha/2)*sd/sqrt(N)), ...
  exp(-r*T)*(Yn+norminv(1-alpha/2)*sd/sqrt(N))];  % �M�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. ���ʂ̕\��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(sprintf('option price = %6.4f%n',price));
disp(sprintf('SD           = %6.4f%n',sd));
disp(sprintf('95%% C.I.     = [%6.4f, %6.4f]%n',CI(1),CI(2)));
disp(sprintf('corr. coef.  = %6.4f%n',corr));
disp(sprintf('c*           = %6.4f%n',cast));