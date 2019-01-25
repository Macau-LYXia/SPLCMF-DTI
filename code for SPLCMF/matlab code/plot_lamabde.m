clc
clear
A=textread('S1-nr.txt');
lambda_l = A(:,1);                              % longitude data
lambda_d = A(:,2);     
lambda_t = A(:,3);
AUCpr = A(:,4);  
[m n]=max(AUCpr);                 
figure(1);
scatter3(lambda_t,lambda_d ,lambda_l,15,AUCpr,'filled') ;   % draw the scatter plot
text(lambda_t(n),lambda_d(n),lambda_l(n),['(','AUCPR:',num2str(AUCpr(n)),')'],'FontSize',10,'color','b');
text(lambda_t(n),lambda_d(n),lambda_l(n),'*','FontSize',25,'color','r');
% ax = gca;
 ax.XDir = 'reverse';
view(-31,14)
xlabel('lambda_t')
ylabel('lambda_d')
zlabel('lambda_l')
%title('Influences of parameters on SPLCML models(NR)','fontweight','bold')
cb = colorbar;                                     % create and label the colorbar
cb.Label.String = ' Precision-Recall curve(AUCPR)';
figure_FontSize=12;
set(gca,'LineWidth',1.0);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'fontweight','bold','Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'fontweight','bold','Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize,'fontweight','bold');
% set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
clear all

figure(2)
A=textread('s1-gpcr.txt');
lambda_l = A(:,1);                            
lambda_d = A(:,2);     
lambda_t = A(:,3);
AUCpr = A(:,4);        
[m n]=max(AUCpr);
scatter3(lambda_t,lambda_d ,lambda_l,15,AUCpr,'filled') ;   % draw the scatter plot
text(lambda_t(n),lambda_d(n),lambda_l(n),['(','AUCPR:',num2str(AUCpr(n)),')'],'FontSize',10,'color','b');
text(lambda_t(n),lambda_d(n),lambda_l(n),'*','FontSize',25,'color','r');
% ax = gca;
 ax.XDir = 'reverse';
view(-31,14)
xlabel('lambda_t')
ylabel('lambda_d')
zlabel('lambda_l')
%title('Influences of parameters on SPLCML models(GPCR)','fontweight','bold')
cb = colorbar;                                     % create and label the colorbar
cb.Label.String = ' Precision-Recall curve(AUCPR)';
figure_FontSize=12;
set(gca,'LineWidth',1.0);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'fontweight','bold','Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'fontweight','bold','Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize,'fontweight','bold');

clear all
figure(3)
A=textread('s1-ic.txt');
lambda_l = A(:,1);                            
lambda_d = A(:,2);     
lambda_t = A(:,3);
AUCpr = A(:,4);        
[m n]=max(AUCpr);
scatter3(lambda_t,lambda_d ,lambda_l,15,AUCpr,'filled') ;   % draw the scatter plot
text(lambda_t(n),lambda_d(n),lambda_l(n),['(','AUCPR:',num2str(AUCpr(n)),')'],'FontSize',10,'color','b');
text(lambda_t(n),lambda_d(n),lambda_l(n),'*','FontSize',25,'color','r');
% ax = gca;
 ax.XDir = 'reverse';
view(-31,14)
xlabel('lambda_t')
ylabel('lambda_d')
zlabel('lambda_l')
%title('Influences of parameters on SPLCML models(IC)','fontweight','bold')
cb = colorbar;                                     % create and label the colorbar
cb.Label.String = ' Precision-Recall curve(AUCPR)';
figure_FontSize=12;
set(gca,'LineWidth',1.0);
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'fontweight','bold','Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'fontweight','bold','Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize,'fontweight','bold');