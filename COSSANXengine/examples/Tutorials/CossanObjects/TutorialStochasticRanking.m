%% Tutorial for the StochasticRankingES object
% This tutorial shows how to solve the G07 and G12 constrained optimization 
% problems from the paper of T.P.Runarsson and X.Yao "Stochastic Ranking for
% Constrained Evolutionary Optimization", using the Stochastic Ranking
% Evolution Strategy.
% 
% See Also: https://cossan.co.uk/wiki/index.php/@StochasticRanking
%
% $Copyright~1993-2018$
% $Author: Matteo~Broggi$ 


%% Define Problem G07
OpenCossan.resetRandomNumberGenerator(56183568)

% Define design variables
Ndv = 20;
CSmembers = cell(Ndv,1);
CXmembers = cell(Ndv,1);

% introduce quickly the design variables ivolved in the problem
for idv =1:Ndv
    CSmembers{idv} = ['Xdv' num2str(idv)];
    CXmembers{idv} = DesignVariable('value',unifrnd(-10,10),'lowerbound',-10,'upperbound',10);
end

Xinp1 = Input('CSmembers',CSmembers,'CXmembers',CXmembers);

%% Define optimization problem
% Create the objective function
Xobj1 = ObjectiveFunction('Sdescription','objective function',...
    'Sscript',['Moutput=Minput(:,1).^2+Minput(:,2).^2+Minput(:,1).*Minput(:,2)-14*Minput(:,1)-16*Minput(:,2)+(Minput(:,3)-10).^2+'...
    '4*(Minput(:,4)-5).^2+(Minput(:,5)-3).^2+2*(Minput(:,6)-1).^2+5*Minput(:,7).^2+'...
    '7*(Minput(:,8)-11).^2+2*(Minput(:,9)-10).^2+(Minput(:,10)-7).^2+45 ;'],...
    'Cinputnames',CSmembers,'Coutputnames',{'objective'},'Liomatrix',true,'Liostructure',false);

% Add the 8 constraints
Xcon1 = Constraint('Sdescription','',...
    'Sscript','Moutput= -105+4*Minput(:,1)+5*Minput(:,2)-3*Minput(:,7)+9*Minput(:,8);',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con1'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon2 = Constraint('Sdescription','',...
    'Sscript','Moutput= 10*Minput(:,1)-8*Minput(:,2)-17*Minput(:,7)+2*Minput(:,8) ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con2'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon3 = Constraint('Sdescription','',...
    'Sscript','Moutput= -8*Minput(:,1)+2*Minput(:,2)+5*Minput(:,9)-2*Minput(:,10)-12 ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con3'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon4 = Constraint('Sdescription','',...
    'Sscript','Moutput= 3*(Minput(:,1)-2).^2+4*(Minput(:,2)-3).^2+2*Minput(:,3).^2-7*Minput(:,4)-120 ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con4'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon5 = Constraint('Sdescription','',...
    'Sscript','Moutput= 5*Minput(:,1).^2+8*Minput(:,2)+(Minput(:,3)-6).^2-2*Minput(:,4)-40 ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con5'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon6 = Constraint('Sdescription','',...
    'Sscript','Moutput= Minput(:,1).^2+2*(Minput(:,2)-2).^2-2*Minput(:,1).*Minput(:,2)+14*Minput(:,5)-6*Minput(:,6) ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con6'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon7 = Constraint('Sdescription','',...
    'Sscript','Moutput= 0.5*(Minput(:,1)-8).^2+2*(Minput(:,2)-4).^2+3*Minput(:,5).^2-Minput(:,6)-30 ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con7'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

Xcon8 = Constraint('Sdescription','',...
    'Sscript','Moutput= -3*Minput(:,1)+6*Minput(:,2)+12*(Minput(:,9)-8).^2-7*Minput(:,10) ;',...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con8'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

%% Define OptimizationProblem
Xop1  = OptimizationProblem('Sdescription','Optimization problem', ...
    'Xinput',Xinp1,'VinitialSolution',unifrnd(-5,5,1,Ndv), ...
    'XobjectiveFunction',Xobj1,...
    'CXconstraint',{Xcon1 Xcon2 Xcon3 Xcon4 Xcon5 Xcon6 Xcon7 Xcon8});
    
%% Create optimizer

% In this tutorial we use a very limited number of iterations to obtain a
% fast results but the algorithm might not have converged yet. 

Xopalg = StochasticRanking('Nmu',10,'Nlambda',140,...
                        'Vsigma',2*ones(20,1),'Nmaxiterations',100);

% Show details of the object
display(Xopalg)

%% Run optimization
Xoptimum1 = Xop1.optimize('Xoptimizer',Xopalg);  
display(Xoptimum1)   

%% Check Reference solution
% According to the paper the optimal solution is at 24.306 (the identified
% solution is at 24.61)

assert((Xoptimum1.VoptimalScores-24.306)<0.4,...
    'OpenCossan:TutorialStochasticRanking',...
    'Solution doesn''t match')


%% Define Problem G12
% Optimal solution at -1
% Define design variables
Ndv = 3;
CSmembers = cell(Ndv,1);
CXmembers = cell(Ndv,1);

% introduce quickly the design variables ivolved in the problem
for idv =1:Ndv
    CSmembers{idv} = ['Xdv' num2str(idv)];
    CXmembers{idv} = DesignVariable('value',unifrnd(0,10),'lowerbound',0,'upperbound',10);
end

Xinp2 = Input('CSmembers',CSmembers,'CXmembers',CXmembers);

%% Define optimization problem
% Create the objective function
Xobj2 = ObjectiveFunction('Sdescription','objective function',...
    'Sscript','Moutput=(-100 + sum((Minput-5).^2,2))/100;',...
    'Cinputnames',CSmembers,'Coutputnames',{'objective'},'Liomatrix',true,'Liostructure',false);

% Add the constraint. The feasible domain is given by 9^Ndv disjointed 
% hyperspheres with radius 0.25.
Xcon = Constraint('Sdescription','',...
    'Sscript',['Mcenters=round(Minput);',...
               'Mcenters(Mcenters==10)=9;',...
               'Mcenters(Mcenters==0)=1;',...
               'Moutput = sum((Minput-Mcenters).^2,2)-0.0625;'],...
    'Cinputnames',CSmembers,...
    'Coutputnames',{'con'},...
    'Liomatrix',true,'Liostructure',false,'Lfunction',false);

%% Define OptimizationProblem
Xop2  = OptimizationProblem('Sdescription','Optimization problem', ...
    'Xinput',Xinp2,'VinitialSolution',unifrnd(0,10,1,Ndv), ...
    'XobjectiveFunction',Xobj2,...
    'CXconstraint',{Xcon});

%% Create optimizer
Xopalg = StochasticRanking('Nmu',20,'Nlambda',140,'Vsigma',2*ones(10,1));

% Show details of the object
display(Xopalg)

%% Run optimization
Xoptimum2 = Xop2.optimize('Xoptimizer',Xopalg);  
display(Xoptimum2)   
