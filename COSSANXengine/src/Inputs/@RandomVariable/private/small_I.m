function Xobj = small_I(Xobj)
%SMALL_I compute missing parameters (if is possible) of the small I
%distribution 
%
% Input/Output is the structure of the random variable

Xobj.Sdistribution='SMALL-I';

if ~isempty(Xobj.Vdata)
    if min(size(Xobj.Vdata)) ~= 1
        error('openCOSSAN:RandomVariable:exponential',...
            'Vdata must be a vector');
    end
    a= mle(Xobj.Vdata,'distribution','ev','frequency',Xobj.Vfrequency, 'censoring',  Xobj.Vcensoring, ...
        'alpha',Xobj. confidenceLevel);
    
    Xobj.Cpar{1,1}='mu (location parameter)';
    Xobj.Cpar{2,1}='alpha (scale parameter)';
    Xobj.Cpar{1,2}=a(1); % invert the sign of the first parameter
    Xobj.Cpar{2,2}=1/a(2);
    
    if length(Xobj.Vdata)>15 && chi2gof(Xobj.Vdata,'cdf',@(z)cdf('ev',z,a(1),a(2)),'nparams',2)
        warning('OpenCossan:RandomVariable:small_I',...
            'The distribution may badly fit the input values');
    end
end



if ~isempty([Xobj.Cpar{:}])
    Xobj.Cpar{1,1}='mu (location parameter)';
    Xobj.Cpar{2,1}='alpha (scale parameter)';
    Xobj.mean=Xobj.Cpar{1,2} - 0.5772156/Xobj.Cpar{2,2};
    Xobj.std=pi/sqrt(6)/Xobj.Cpar{2,2};
elseif ~isempty(Xobj.std) && ~isempty(Xobj.mean)
    return
elseif ~isempty(Xobj.CoV) && ~isempty(Xobj.mean)
    Xobj.std=abs(Xobj.mean-Xobj.shift)*Xobj.CoV;
elseif ~isempty(Xobj.std) && ~isempty(Xobj.CoV)
    Xobj.mean=Xobj.std/Xobj.CoV+Xobj.shift;
else
    error('OpenCossan:rv:small_I','Irrelevant parameters have been used, the distribution could not be created');
end


        