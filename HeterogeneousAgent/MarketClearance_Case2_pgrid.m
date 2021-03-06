function  [MarketClearanceVec]=MarketClearance_Case2_pgrid(SSvalues_AggVars,p_c,n_p,p_grid, MarketPriceEqns, Parameters, MarketPriceParamNames)
% This code is actually identical to MarketClearance_Case1_pgrid anyway

MarketPriceParamsVec=gpuArray(CreateVectorFromParams(Parameters,MarketPriceParamNames));

MarketClearanceVec=ones(1,length(MarketPriceEqns),'gpuArray')*Inf;
p_sub=ind2sub_homemade_gpu(n_p,p_c);
l_p=length(n_p);
p=zeros(l_p,1,'gpuArray');
for i=1:l_p
    if i==1
        p(i)=p_grid(p_sub(1));
    else
        p(i)=p_grid(sum(n_p(1:i-1))+p_sub(i));
    end
end
for i=1:length(MarketPriceEqns)
    MarketClearanceVec(i)=p(i)-MarketPriceEqns{i}(SSvalues_AggVars, p, MarketPriceParamsVec);
end


end
