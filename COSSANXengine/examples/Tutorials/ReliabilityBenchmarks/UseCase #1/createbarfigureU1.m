function createbarfigureU1(ymatrix1,CTicklabel,Stitle)
%CREATEFIGURE(YMATRIX1)
%  YMATRIX1:  bar matrix data

%  Auto-generated by MATLAB on 27-Feb-2009 10:56:26

% Create figure
figure1 = figure('XVisual',...
	'0x62 (TrueColor, depth 32, RGB mask 0xff0000 0xff00 0x00ff)');

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
	'YMinorGrid','on',...
	'YGrid','on',...
	'XTickLabel',CTicklabel,...
	'XTick',1:length(CTicklabel),...
	'XGrid','on',...
	'FontSize',16);
box('on');
hold('all');

% Create multiple lines using matrix input to bar
bar1 = bar(ymatrix1,'BarWidth',0.9,'BaseValue',0.001,'Parent',axes1);
for i=1:length(bar1)
	set(bar1(i),'DisplayName',['X_' num2str(i)]);
end

% Create ylabel
ylabel('\alpha_i','FontSize',16);

% Create title
title(Stitle,'FontSize',16);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Location','Best');

