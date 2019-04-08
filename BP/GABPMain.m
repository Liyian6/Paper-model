clc
clear all
close all
%%�����������ѵ����������������ÿ��һ������������P�����T
data=xlsread('�ܵ�all')';
P= data(1:5,1:45);
T=data(6,1:45);
P_test = data(1:5,[1 14 17 29 33 49]);
T_test = data(6,[1 14 17 29 33 49]);

%��ʼ��������Ԫ����
hiddennum=10;
%�������������ֵ����Сֵ
threshold=[0 1;0 1;0 1;0 1;0 1];
inputnum=size(P,1);
outputnum=size(T,1);
w1num=inputnum*hiddennum;
w2num=outputnum*hiddennum;
N=w1num+hiddennum+w2num+outputnum;

%% �����Ŵ��㷨����
NIND=40;        %������Ŀ
MAXGEN=50;      %����Ŵ�����
PRECI=10;       %�����Ķ�����λ��
GGAP=0.95;      %����
px=0.7;         %�������
pm=0.01;        %�������
trace=zeros(N+1,MAXGEN);                        %Ѱ�Ž���ĳ�ʼֵ

FieldD=[repmat(PRECI,1,N);repmat([-0.5;0.5],1,N);repmat([1;0;1;1],1,N)];                      %����������
Chrom=crtbp(NIND,PRECI*N);                      %��ʼ��Ⱥ
%% �Ż�
gen=0;                                 %��������
X=bs2rv(Chrom,FieldD);                 %�����ʼ��Ⱥ��ʮ����ת��
ObjV=Objfun(X,P,T,hiddennum,P_test,T_test);        %����Ŀ�꺯��ֵ
while gen<MAXGEN
   fprintf('%d\n',gen)
   FitnV=ranking(ObjV);                              %������Ӧ��ֵ
   SelCh=select('rws',Chrom,FitnV,GGAP);                 %ѡ������ѡ��
   SelCh=recombin('xovsp',SelCh,px);
   SelCh=mut(SelCh,pm);                               %����(ԭ����)
   
   X=bs2rv(SelCh,FieldD);               %�Ӵ������ʮ����ת��
   ObjVSel=Objfun(X,P,T,hiddennum,P_test,T_test);             %�����Ӵ���Ŀ�꺯��ֵ����
   [Chrom,ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel); %�ز����Ӵ����������õ�����Ⱥ
   X=bs2rv(Chrom,FieldD);
   gen=gen+1;                                             %������������
   %��ȡÿ�������Ž⼰����ţ�YΪ���Ž�,IΪ��������
   [Y,I]=min(ObjV);
   trace(1:N,gen)=X(I,:);                       %����ÿ��������ֵ
   trace(end,gen)=Y;                               %����ÿ��������ֵ
end
%% ������ͼ
figure(1);
P0 = plot(1:MAXGEN,trace(end,:));
grid on
xlabel('�Ŵ�����')
ylabel('���ı仯')
title('��������')
bestX=trace(1:end-1,end);
bestErr=trace(end,end);
fprintf(['���ų�ʼȨֵ����ֵ:\nX=',num2str(bestX'),'\n��С���err=',num2str(bestErr),'\n'])
set(P0,'LineWidth',1.5);       %| ����ͼ���߿�


%% �Ƚ��Ż�ǰ���ѵ��&����
callbackfun

