function fearcloud_pmf_prepost(subjects)


global project_path

[pmf]=isn_getPMF(subjects,[1,5]);

x         = 0:1:150;
cs=0;
for sub=subjects
    cs=cs+1;
    
    fig(1)=figure('units','normalized','outerposition',[0 0 0.8 .7]);
    suptitle(sprintf('Fitting Subject %g, Pre-Post',sub));
    subplot(1,2,1)
    %Pre vs Post, CSN and CSP in one figure
    
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,1,1) 10.^(pmf.beta(cs,1,1)) pmf.gamma(cs,1,1) pmf.lambda(cs,1,1)],x),'r--','linewidth',2)
    hold on;
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,2,1) 10.^(pmf.beta(cs,2,1)) pmf.gamma(cs,2,1) pmf.lambda(cs,2,1)],x),'b--','linewidth',2)
    legend('CS+','CS-','location','southeast')
    title('Pre')
    xlabel('X (deg)')
    ylabel('p("different")')
     axis square
    
    
    %%%%%
    subplot(1,2,2)
    
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,1,2) 10.^(pmf.beta(cs,1,2)) pmf.gamma(cs,1,2) pmf.lambda(cs,1,2)],x),'r','linewidth',2)
    hold on;
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,2,2) 10.^(pmf.beta(cs,2,2)) pmf.gamma(cs,2,2) pmf.lambda(cs,2,2)],x),'b','linewidth',2)
    legend('CS+','CS-','location','southeast')
    title('Post')
    xlabel('X (deg)')
    ylabel('p("different")')
    axis square
   
      
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    save_path = sprintf('%sfigures/%s.png',isn_GetPath(sub,5),mfilename);
    hgexport(fig(1),save_path);
    save_path = sprintf('%sfigures/%s.eps',isn_GetPath(sub,5),mfilename);
    hgexport(fig(1),save_path);
    saveas(fig(1),sprintf('%sfigures/%s.png',isn_GetPath(sub,5),mfilename))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fig(2)=figure('units','normalized','outerposition',[0 0 0.8 .7]);
    suptitle(sprintf('Fitting Subject %g, CS+ vs CS-',sub));
    
    subplot(1,2,1)
    %CS+ left, CS- right figure - pre vs post in one figure.
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,1,1) 10.^(pmf.beta(cs,1,1)) pmf.gamma(cs,1,1) pmf.lambda(cs,1,1)],x),'r--','linewidth',2)
    hold on;
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,1,2) 10.^(pmf.beta(cs,1,2)) pmf.gamma(cs,1,2) pmf.lambda(cs,1,2)],x),'r-','linewidth',2)
    legend('Pre','Post','location','southeast')
    title('CS+')
    xlabel('X (deg)')
    ylabel('p("different")')
     axis square
   
    %%%%% 
    subplot(1,2,2)    
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,2,1) 10.^(pmf.beta(cs,2,1)) pmf.gamma(cs,2,1) pmf.lambda(cs,2,1)],x),'b--','linewidth',2)
    hold on;
    plot(x,...
        PAL_CumulativeNormal([pmf.alpha(cs,2,2) 10.^(pmf.beta(cs,2,2)) pmf.gamma(cs,2,2) pmf.lambda(cs,2,2)],x),'b-','linewidth',2)
    legend('Pre','Post','location','southeast')
      title('CS-')
    xlabel('X (deg)')
    ylabel('p("different")')
    axis square
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    save_path = sprintf('%sfigures/%s_CS.png',isn_GetPath(sub,5),mfilename);
    hgexport(fig(2),save_path);
    save_path = sprintf('%sfigures/%s_CS.eps',isn_GetPath(sub,5),mfilename);
    hgexport(fig(2),save_path);
    saveas(fig(2),sprintf('%sfigures/%s_CS.png',isn_GetPath(sub,5),mfilename))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
end
