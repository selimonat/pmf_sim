alphas  = unique(d2.param.alpha(~isnan(d2.param.ttrials)));
sds     = unique(d2.param.sd(~isnan(d2.param.ttrials)));
trials  = unique(d2.param.ttrials(~isnan(d2.param.ttrials)));

%
cmap    = jet(length(alphas));%in rgb
cmap    = rgb2hsv(cmap);%in hsv, it is easier to change color and brightness separately
%%
%plot the bias separately for different trials
figure(1);
clf;
hold on;
for i_a = 1:length(alphas)
   for i_s = 1:length(sds)       
       %select a color for each a, and change its brightness for different
       %s values.
       color = [cmap(i_a,1) (i_s)./length(sds) (i_s)./length(sds)];
       m     = squeeze(nanmean(d.alpha(:,i_a,i_s,:)));%average estimation       
       plot(trials, m , 'o-' , 'color' , hsv2rgb(color),'linewidth',4);
   end
end
hold off


%plot the different methods in one plot
% 1) PSI method
% 2) PSI marginal 2 AFC, means with marginalized Lambda
% 3) PSI marginal Yes/No, menas marginalized Gamma and Lambda

%load the three guys here
psi1=load('C:\Users\onat\Dropbox\feargen_lea\EthnoMaster\simdata\diffSDs\d_PSI_3SDs_end.mat');
psi2=load('C:\Users\onat\Dropbox\feargen_lea\EthnoMaster\simdata\diffSDs\d_PSImarg2AFC_3SDs_end.mat');
psi3=load('C:\Users\onat\Dropbox\feargen_lea\EthnoMaster\simdata\diffSDs\d_PSImargYN_3SDs_end.mat');

% how many trial levels do you want to display?
t=7;

mean1=squeeze(nanmean(psi1.d.alpha(:,1,1:3,1:t)));%average estimation       
mean2=squeeze(nanmean(psi2.d.alpha(:,1,1:3,1:t)));
mean3=squeeze(nanmean(psi3.d.alpha(:,1,1:3,1:t)));
E1=squeeze(nanstd(psi1.d.alpha(:,1,1:3,1:t)));
E2=squeeze(nanstd(psi2.d.alpha(:,1,1:3,1:t)));
E3=squeeze(nanstd(psi3.d.alpha(:,1,1:3,1:t)));
% rows=SD [15 30 45]

% % these guys are for one Method but 3 parameters of SD

% mean1=squeeze(nanmean(psi1.d.sd(:,1,1,:)));%average estimation       
% mean2=squeeze(nanmean(psi1.d.sd(:,1,2,:)));
% mean3=squeeze(nanmean(psi1.d.sd(:,1,3,:)));
% E1=squeeze(nanstd(psi1.d.sd(:,1,1,:)));
% E2=squeeze(nanstd(psi1.d.sd(:,1,2,:)));
% E3=squeeze(nanstd(psi1.d.sd(:,1,3,:)));



trials  = unique(psi1.d.param.ttrials(~isnan(psi1.d.param.ttrials)));
trials  = trials(1:t);

truealpha=45;
for i=1:3
alphafig15=figure(i);
title(sprintf('Threshold Estimation by 3 PSI methods, SD=%d',i*15),'FontSize',14)
line([0 max(trials)+10], [truealpha truealpha],'color','yellow','linewidth',2)
hold on;
errorbar(trials-2,mean1(i,:),E1(i,:),'bo--','linewidth',2)
hold on;
errorbar(trials,mean2(i,:),E2(i,:),'ro--','linewidth',2)
hold on;
errorbar(trials+2,mean3(i,:),E3(i,:),'ko--','linewidth',2)
legend('true Threshold','PSI','PSI marginal 2AFC',...
        'PSI marginal Y/N','Location','southoutside','orientation','horizontal')
xlabel('ntrials');
ylabel('Mean estimated threshold in degrees (\pm std)');
ylim([30 100])
end

% same for the beta estimation



meanslope1=squeeze(nanmean(psi1.d.sd(:,1,1:3,1:t)));%average estimation       
meanslope2=squeeze(nanmean(psi2.d.sd(:,1,1:3,1:t)));
meanslope3=squeeze(nanmean(psi3.d.sd(:,1,1:3,1:t)));

slopeE1=squeeze(nanstd(psi1.d.sd(:,1,1:3,1:t)));
slopeE2=squeeze(nanstd(psi2.d.sd(:,1,1:3,1:t)));
slopeE3=squeeze(nanstd(psi3.d.sd(:,1,1:3,1:t)));

trials  = unique(psi1.d.param.ttrials(~isnan(psi1.d.param.ttrials)));
trials  = trials(1:t);



for i=1:3

betafig=figure(i);
truebeta=i*15;

line([0 max(trials)+10], [truebeta truebeta],'color','yellow','linewidth',2)
hold on;
errorbar(trials-5,meanslope1(i,:),slopeE1(i,:),'bo--','linewidth',2)
hold on;
errorbar(trials,meanslope2(i,:),slopeE2(i,:),'ro--','linewidth',2)
hold on;
errorbar(trials+5,meanslope3(i,:),slopeE3(i,:),'ko--','linewidth',2)
xlabel('ntrials');
ylabel('Mean estimated Slope in SD (\pm std)');
legend('true slope','PSI','PSI marginal 2AFC',...
        'PSI marginal Y/N','Location','southoutside','orientation','horizontal')
title('Slope Estimation by 3 PSI methods, constant \alpha=45','FontSize',14)
xlim([0 max(trials)+20])
ylim([0  max(meanslope1(:,end))+max(slopeE1(:,end))+5])

end


% % plotting the real observer's procedure
load('C:\Users\onat\Documents\Experiments\FearGeneralization_Ethnic\data\')
figure
title('Procedure Subject 01')

for chain=1:4
subplot(2,2,chain)

plot(Log.globaltrial(chain,:),abs(Log.x(chain,:)),'bo-')
hold on;
plot(Log.globaltrial(chain,(Log.response(chain,:)==1)),abs(Log.x(chain,Log.response(chain,:)==1)),'ko','MarkerFaceColor','k')
plot(Log.globaltrial(chain,(Log.response(chain,:)==0)),abs(Log.x(chain,Log.response(chain,:)==0)),'ko','MarkerFaceColor','w')
errorbar(Log.globaltrial(chain,:),Log.alpha(chain,:),Log.seAlpha(chain,:),'r--')
xlabel('overall trial')
ylabel('presented \Delta X in degrees')
title(sprintf('chain %d',chain))
xlim([0 max(max(Log.globaltrial))])
ylim([0 max(max(abs((Log.x))))])
end

legend('presented X (deg)','subject: Different','subject: Same','estimated \alpha (\pm SE)','Location','southoutside','orientation','horizontal')
figure
for chain=1:4
subplot(2,2,chain)

% plot(Log.globaltrial(chain,:),abs(Log.x(chain,:)),'bo-')
% hold on;
% plot(Log.globaltrial(chain,(Log.response(chain,:)==1)),abs(Log.x(chain,Log.response(chain,:)==1)),'ko','MarkerFaceColor','k')
% plot(Log.globaltrial(chain,(Log.response(chain,:)==0)),abs(Log.x(chain,Log.response(chain,:)==0)),'ko','MarkerFaceColor','w')
errorbar(Log.globaltrial(chain,:),Log.beta(chain,:),Log.seBeta(chain,:),'r--')
xlabel('overall trial')
ylabel('presented \Delta X in degrees')
title(sprintf('chain %d',chain))
xlim([0 max(max(Log.globaltrial))])
ylim([-2 0])
end

legend('estimated \beta (\pm SE)','Location','southoutside','orientation','horizontal')


h=figure;
line([0 max(trials)+10], [45 45],'color','yellow','linewidth',2)
hold on;
errorbar(trials,mean3,E3,'o--','Linewidth',2,'color',[.04 .52 .78]) %[.08 .17 .55]
xlabel('ntrials')
ylabel('Slope in SD')
title('Estimation of Beta for SD = 45','fontsize',14)
legend('true slope', 'mean estimated slope (\pm std)','location','southeast')
print('..\..\Dropbox\feargen_lea\EthnoMaster\simdata\diffSDs\trial_question\plots\Beta_45_45_20to120_lines','-dpng','-r300');
print('..\..\Dropbox\feargen_lea\EthnoMaster\simdata\diffSDs\trial_question\plots\Beta_45_45_20to120_lines','-deps');
saveas(h,'C:\Users\onat\Dropbox\feargen_lea\EthnoMaster\simdata\diffSDs\trial_question\plots\Beta_45_45_20to120_lines.fig')



