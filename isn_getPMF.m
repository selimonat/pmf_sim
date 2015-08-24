function [pmf]=isn_getPMF(subject,run)
global project_path
project_path='C:\Users\onat\Google Drive\EthnoMaster\data\';
cs=0;
cr=0;
for ns=subject
    cs=cs+1;
    cr=0;
    for nr=run
        cr=cr+1;
        p=isn_GetData(ns,nr,'stimulation');
        p=p.p;
        for chain=1:2
            pmf.alpha(cs,chain,cr)=p.psi.log.alpha(chain,end);
            pmf.seAlpha(cs,chain,cr)=p.psi.log.seAlpha(chain,end);
            pmf.beta(cs,chain,cr)=p.psi.log.beta(chain,end);
            pmf.seBeta(cs,chain,cr)=p.psi.log.seBeta(chain,end);
            pmf.gamma(cs,chain,cr)=p.psi.log.gamma(chain,end);
            pmf.seGamma(cs,chain,cr)=p.psi.log.seGamma(chain,end);
            pmf.lambda(cs,chain,cr)=p.psi.log.lambda(chain,end);
            pmf.seLambda(cs,chain,cr)=p.psi.log.seLambda(chain,end);
         
            %
            pmf.indsubject(cs,chain,cr)=ns;
            pmf.indrun(cs,chain,cr)=cr;
            pmf.indchain(cs,chain,cr)=chain;
        end
        
    end
end
end
