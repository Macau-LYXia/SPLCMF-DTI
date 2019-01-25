clc
clear
figure(1)
A=textread('NRrr.txt');
rr=10:10:120;
a=A(:,1);
b=A(:,2);
plot(rr,a,'-*b',rr,b,'-or','LineWidth',2); %线性，颜色，标记
hold on
plot([100 100], [0 1.1],'--g','LineWidth',2)
axis([0 140 0.2 1.1])
legend('AUCPR','AUC','location','SouthEast');
xlabel('The dimension of the feature spaces(r)')
ylabel('value')
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');
set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',2,'fontweight','bold');
%title('NR','FontName','Times New Roman','FontSize',16,'fontweight','bold');

clear all
figure(2)
A=textread('GPCRrr.txt');
rr=10:10:120;
a=A(:,1);
b=A(:,2);
plot(rr,a,'-*b',rr,b,'-or','LineWidth',2); %线性，颜色，标记
hold on
plot([100 100], [0 1.1],'--g','LineWidth',2)
axis([0 140 0.2 1.1])
legend('AUCPR','AUC','location','SouthEast');
xlabel('The dimension of the feature spaces(r)')
ylabel('value')
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');
set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',2,'fontweight','bold');
%title('GPCR','FontName','Times New Roman','FontSize',16,'fontweight','bold');
clear all
figure(3)
A=textread('ICrr.txt');
rr=10:10:120;
a=A(:,1);
b=A(:,2);
plot(rr,a,'-*b',rr,b,'-or','LineWidth',2); %线性，颜色，标记
hold on
plot([100 100], [0 1.1],'--g','LineWidth',2)
axis([0 140 0.2 1.1])
legend('AUCPR','AUC','location','SouthEast');
xlabel('The dimension of the feature spaces(r)')
ylabel('value')
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');
set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',2,'fontweight','bold');
%title('IC','FontName','Times New Roman','FontSize',16,'fontweight','bold');

clear all
figure(4)
A=textread('Err.txt');
rr=10:10:120;
a=A(:,1);
b=A(:,2);
plot(rr,a,'-*b',rr,b,'-or','LineWidth',2); %线性，颜色，标记
hold on
plot([100 100], [0 1.1],'--g','LineWidth',2)
axis([0 140 0.2 1.1])
legend('AUCPR','AUC','location','SouthEast');
xlabel('The dimension of the feature spaces(r)')
ylabel('value')
set(gca, 'XGrid','on');
set(gca, 'YGrid','on');
set(gca,'FontName','Times New Roman','FontSize',14,'LineWidth',2,'fontweight','bold');
%title('E','FontName','Times New Roman','FontSize',16,'fontweight','bold');