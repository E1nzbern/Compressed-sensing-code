%ѹ����֪�ع��㷨����
% ѹ����֪�ع��㷨֮��׷��(Basis Pursuit, BP)����������������������
% �ָ��вans = 3.2370e-14  ����������������������������������������
clear all;close all;clc;
M = 64;%�۲�ֵ����������
N = 256;%�ź�x�ĳ���
K = 10;%�ź�x��ϡ���
Index_K = randperm(N);
x = zeros(N,1);
% x(Index_K(1:K)) = 5*randn(K,1);%xΪKϡ��ģ���λ���������
x(Index_K(1:K)) = 1;%���������һά�ź�x
Psi = eye(N);%x������ϡ��ģ�����ϡ�����Ϊ��λ��x=Psi*theta
Phi = randn(M,N);%��������Ϊ��˹����
A = Phi * Psi;%���о���
y = Phi * x;%�õ��۲�����y
%% �ָ��ع��ź�x
tic
theta = BP_linprog(y,A);
x_r = Psi * theta;% x=Psi * theta
toc
%% ��ͼ
figure;
plot(x_r,'k.-');%���x�Ļָ��ź�
hold on;
plot(x,'r');%���ԭ�ź�x
hold off;
legend('Recovery','Original')
fprintf('\n�ָ��в');
norm(x_r-x)%�ָ��в�
[n1,r1] = biterr(x,round(x_r));