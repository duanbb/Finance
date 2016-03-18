%
% SimDiPut.m  �_�E���E�A���h�E�C���̃v�b�g�E�I�v�V����
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. �p�����[�^�ݒ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=0.05;      % �����i100r ���^�N�j
sigma=0.25;  % �{���e�B���e�B�i100sigma ���^�N�j
T=4/12;      % �����i�N�j
S0=100;      % �������i
K=100;       % �s�g���i
Kb=90;       % �o���A
N=10000;     % �V�~�����[�V������ 
L=84;        % ���Ԃ̕�����
alpha=0.05;  % 1-�M������

randn('state',1);  % �����̏�����Ԃ̐ݒ�
delta=T/L;  % �P�ʎ��ԊԊu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. �����Y���i�̃T���v���p�X�̐����C�y�C�I�t�̌v�Z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=zeros(1,N);

numin=0;  % �_�E���E�C���̔�����

for i=1:N  % �V�~�����[�V�����̔���
  X=zeros(1,L);
  B=zeros(1,L);
  S=zeros(1,L);
  X=sqrt(delta)*randn(1,L);  % �u���E���^���̍���X�̃T���v�����O
  B=cumsum(X);  % �u���E���^��B�̌v�Z
  S=S0*exp((r-sigma^2/2)*delta*(1:L)+sigma*B);  % ���i�ߒ�S�̌v�Z
  if min(S)<Kb
    h(i)=max(K-S(L),0);  % �y�C�I�t�̌v�Z�i�_�E���E�C�������ꍇ�j
    numin=numin+1;  % �_�E���E�C���̔����񐔂��J�E���g
  else
    h(i)=0; % �y�C�I�t�̌v�Z�i�_�E���E�C�����Ȃ��ꍇ�j
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. �I�v�V�������i�̕��ρE�M����Ԃ̌v�Z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
Yn=mean(h);
sd=std(h);

price=exp(-r*T)*Yn;   % �I�v�V�������i
CI=[exp(-r*T)*(Yn-norminv(1-alpha/2)*sd/sqrt(N)), ...
  exp(-r*T)*(Yn+norminv(1-alpha/2)*sd/sqrt(N))];  % �M�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. ���ʂ̕\��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(sprintf('option price = %6.4f%n',price));
disp(sprintf('SD           = %6.4f%n',sd));
disp(sprintf('95%% C.I.     = [%6.4f, %6.4f]%n',CI(1),CI(2)));
disp(sprintf('#down in     = %d%n',numin));
