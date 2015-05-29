function feargenET_PFfitting_Fitplot(subject,p,phase)
 x=0:1:100;
 xstimrange=0:11.25:100;
% collect number of trials per stimulus Level

folder='C:\Users\onat\Dropbox\feargen_lea\EthnoMaster\firstdata\plots\';

minn=5;
maxn=25;
% 
fig=figure('units','normalized','outerposition',[0 0 0.8 1]);
suptitle(sprintf('Fitting Subject %g, Phase %g',subject,phase));

for chain=1:size(p.psi.log.x,1)
    %dotsize gets scaled by number of trials at this x
    dotsize  = Scale(sum(~isnan(p.psi.log.xrounded(:,:,chain)),2))*(maxn-minn)+minn;
    pcorrect = nanmean(p.psi.log.xrounded(:,:,chain),2);
    error    = nanstd(p.psi.log.xrounded(:,:,chain),0,2);
   
    subplot(4,2,chain)
    plot(x,...
        PAL_CumulativeNormal([p.psi.log.alpha(chain,end) 10.^(p.psi.log.beta(chain,end)) p.psi.log.gamma(chain,end) p.psi.log.lambda(chain,end)],x),'b')
    hold on;
    line([p.psi.log.alpha(end) p.psi.log.alpha(end)],[ -.2 1.2],'Color','y')
    %detect the nonnan entries
%     for i =  find(~isnan(pcorrect(:))')
%         errorbar(xstimrange(i),pcorrect(i),error(i),'ko','Markersize',dotsize(i));
%         hold on;
%     end
    for i =  find(~isnan(pcorrect(:))')
        errorbar(xstimrange(i),pcorrect(i),error(i),'ko','Markersize',4);
        hold on;
    end
    ylabel('p(different)')
    xlabel('X (deg)')
    xlim([-10 100])
    ylim([-.2 1.2])
    title(sprintf('chain %d',chain))
    hold off




subplot(4,2,2+chain)
for i =  find(~isnan(pcorrect(:))')
    plot(xstimrange(i),1.2,'ko','Markersize',dotsize(i),'MarkerFaceColor',[0.3 0.3 0.3]);
    hold on;
end
xlim([-10 100]);
title('Stimulus Placement')
% folder='C:\Users\onat\Dropbox\feargen_lea\EthnoMaster\DiscriminationTask\pilotedata\';
% saveas(fig,sprintf('%sFit_Subj%02s.png',folder,subject))

subplot(4,2,4+chain)
plot([1:length(p.psi.log.x(chain,:))],abs(p.psi.log.x(chain,:)),'ko-')
hold on;
plot(1:length(p.psi.log.alpha(chain,:)),p.psi.log.alpha(chain,:),'r-')
errorbar([1 length(p.psi.log.alpha(chain,:))],p.psi.log.alpha(chain,[1 end]),p.psi.log.seAlpha(chain,[1 end]),'ro')
title(sprintf('estimated alpha=%f (%f)',p.psi.log.alpha(chain,end),p.psi.log.seAlpha(chain,end)))
xlim([-5 length(p.psi.log.beta(chain,:))+5])

subplot(4,2,6+chain)
plot(1:length(p.psi.log.beta(chain,:)),(p.psi.log.beta(chain,:)),'b-')
hold on;
errorbar([1 length(p.psi.log.beta(chain,:))],p.psi.log.beta(chain,[1 end]),p.psi.log.seBeta(chain,[1 end]),'bo')
title(sprintf('estimated log10(beta) = %f (%f)',p.psi.log.beta(chain,end),p.psi.log.seBeta(chain,end)))
xlim([-5 length(p.psi.log.beta(chain,:))+5])
end

saveas(fig,sprintf('%sFit_Subj%d_ph%d.png',folder,subject,phase))
saveas(fig,sprintf('%sFit_Subj%d_ph%d.eps',folder,subject,phase))
% 
% % to plot the presented x-values
% nx=mean(d.nxmean,2)
% a
% % 
%  x=0:1:100;
%  xstimrange=0:11.25:100;
%  a0=45;
%  b0=10;
%  g0=0.1;
%  l0=0.02;
% % collect number of trials per stimulus Level
% minn=5;
% maxn=25;
% figure
% plot(x,PAL_CumulativeNormal([a 1/b g l],x),'b')
% hold on;
% plot(x,PAL_CumulativeNormal([a0 1/b0 g0 l0],x),'r')
%  for i =  1:length(xstimrange)
%         plot(xstimrange(i),1.2,'ko','Markersize',dotsize(i),'MarkerFaceColor',[0.3 0.3 0.3]);
%         hold on;
%  end
%  xlim([-5 100])
%  ylim([-.1 1.8])
%  legend('estimated PF','generating PF','stimulus placement','Location','southeast')
%  
% bar(mean(d.nxmean,2))
% set(gca,'XTick',[1 2 3 4 5 6 7 8 9],'XTickLabel',{'0','11.25','22.5','33.75','45','56.25','67.5','78.75','90'})


