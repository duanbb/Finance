%
% GBmotion.m (�􉽓I�u���E���^���̃V�~�����[�V����)
%

disp('  �����Y���i���􉽓I�u���E���^���ɏ]���ꍇ�̃V�~�����[�V���������܂�. ');
disp('  ');
disp('  �h���t�g�� (mu), ����у{���e�B���e�B (sigma) ��ς��邱�Ƃɂ����,');
disp('  �􉽓I�u���E���^���̃p�X���ǂ��ς�邩���l�@���Ă�������. ');
disp('  ');
input('  �������ł��Ă���Ȃ��, �����L�[�������Ă�������. ');

disp('  ');
disp('  �h���t�g������͂��ĉ�����. ');
mu=input('    �h���t�g�� = ');
  if isempty(mu)>0, mu = 0.15; end;

disp('  ');
disp('  �{���e�B���e�B����͂��ĉ�����. ');
sigma=input('    �{���e�B���e�B = ');
  if isempty(sigma)>0, sigma = 0.35; end;

disp('  ');
disp('  �����Y�̏������i����͂��ĉ�����. ');
S0=input('    �����Y�̏������i = ');
  if isempty(S0)>0, S0 = 100; end;

disp('  ');
disp('  �V�~�����[�V��������(=�I�v�V��������)����͂��ĉ�����. ');
T=input('    �V�~�����[�V��������(�N) = ');
  if isempty(T)>0, T = 0.5; end;

disp('  ');
disp('  ����������͂��ĉ�����. ');
N=input('    ������ = ');
  if isempty(N)>0, N = 10000; end;

dt = T/N;

vecdB = randn([1,N]); vecdB = sqrt(dt)*vecdB; 
vecB = []; vecT = []; vecB(1) = vecdB(1); vecT(1) = dt;
for ii = 1:N-1,
   vecB(ii+1) = vecB(ii)+vecdB(ii+1);
   vecT(ii+1) = (ii+1)*dt;
end

nu = mu-sigma^2/2; 
vecS = nu*vecT+sigma*vecB; vecS = S0*exp(vecS);
vecS = [S0 vecS]; vecT = [0 vecT];

disp('  ');
disp('  �����Y�̉��i�ϓ���\�����܂�. ');

figure(1)
plot(vecT,vecS);
xlabel('����(�N)')
ylabel('�����Y���i')
