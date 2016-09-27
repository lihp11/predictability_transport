%% detail analysis of predictability vs other params
clc,clear,close all;
eight_roadname = {'changan_ew','changan_we','dianmen_ew','dianmen_we','north4th_ring_ew','north4th_ring_we','west3th_ring_sn','west3th_ring_ns'};
nine_params = {'lowpredict','uppredict','std','cov','BI','MI','PR','lam_skew','lam_var'};
% change here!!!!!!
link_matname = eight_roadname{2};
load([link_matname,'.mat']);    % temp calculation

%% locate which 5min satisfy: one param vary below alpha, but another param vary above beta
% change here!!!
index_param1 = 3; % single=index of param1 in nine_params
index_param2 = 2; % single=index of param2 in nine_params
alpha = 0.05; % single=low varation rate for one param
beta = 0.75; % single=large varation rate for another param
nth_wkday = 8; % single=the nth_wkday u want to analyze,8 stand for whole

eval(['param1 = param_w',num2str(nth_wkday),'(:,index_param1);']);
eval(['param2 = param_w',num2str(nth_wkday),'(:,index_param2);']);
%param1 or param2:vector,length=288,content=relvent param for every 5min at certain wkday
	% param1 = param_w8(:,index_param1);
	% param2 = param_w8(:,index_param2);
raw_param1 = param1;
raw_param2 = param2;
param1 = (param1-min(param1))/(max(param1)-min(param1));
param2 = (param2-min(param2))/(max(param2)-min(param2));
%param1 or param2:vector,length=288,content=relvent normalized param for every 5min at certain wkday,[0,1]

% down2:initiation for pointer index
eval(['large_',nine_params{index_param1},' = [];']);
eval(['large_',nine_params{index_param2},' = [];']);
%large_XXX:array:rownum=not sure,c1=index of first 5min,c2=index of second 5min
	% large_std = [];
	% large_uppredict = [];

for pointer1 = 1:288 %single=first nth5min index
	for pointer2 = pointer1:288 %single=second nth5min index
		if (abs(param1(pointer1)-param1(pointer2))>beta && abs(param2(pointer1)-param2(pointer2))<alpha)
			eval(['large_',nine_params{index_param1},' = [large_',nine_params{index_param1},';pointer1,pointer2];']);
			% large_std = [large_std;pointer1,pointer2];
		elseif (abs(param1(pointer1)-param1(pointer2))<alpha && abs(param2(pointer1)-param2(pointer2))>beta)
			eval(['large_',nine_params{index_param2},' = [large_',nine_params{index_param2},';pointer1,pointer2];']);
			% large_uppredict = [large_uppredict;pointer1,pointer2];
		end

	end
end

%% plot histogram to compare
% change here!!!
nth_5min1 = 77; %single = nth 5 min for detail analysis,[0,288]
nth_5min2 = 94; %single = nth 5 min for detail analysis,[0,288]
tt_min = 200;
tt_bin = 20/40*total_length;
tt_max = 1000;


	set(0,'defaultfigurecolor','w')
figure('numbertitle','off','name','index_compare');
[ax,h_l1,h_l2]=plotyy(1:288,raw_param1,1:288,raw_param2,'plot');
	% set xlabel,ylabel1,ylabel2
	xlabel('hour','fontname','等线','FontWeight','bold','FontSize',12)

	h_ylabel1 = get(ax(1),'ylabel');	% text object
	set(h_ylabel1,'string',nine_params(index_param1),'fontname','等线',...
		'FontWeight','bold','FontSize',12);
	h_ylabel2 = get(ax(2),'ylabel');
	set(h_ylabel2,'string',nine_params(index_param2),'fontname','等线',...
		'FontWeight','bold','FontSize',12);
	set(h_l2,'linewidth',1.5);

	% set xtick
	set(ax,'xlim',[0,288],'xtick',0:12:288,'xticklabel',0:24);
		%gca = ax(1),but  ax(2) also have x property

	%set title
	title([link_matname,'''s ',nine_params{index_param1},'_vs_',nine_params{index_param2}],'fontname','等线',...
		'FontSize',14,'FontWeight','bold','Interpreter', 'none');
	hold on;
    ax_ylim = get(ax(1),'ylim');	%vector:length=2,ylim of ax(1)
	plot(ax(1),[nth_5min1,nth_5min1],ax_ylim,'color','k','linewidth',1.4);
	plot(ax(1),[nth_5min2,nth_5min2],ax_ylim,'color','k','linewidth',1.4);

figure('numbertitle','off','name','first_5min');
xbins = tt_min:tt_bin:tt_max;
hist(tt_sum(nth_5min1,:),xbins);
	xlim([tt_min,tt_max]);
	xlabel('second','fontname','等线','FontWeight','bold','FontSize',12)
	ylabel('counts','fontname','等线','FontWeight','bold','FontSize',12)
	title([link_matname,'''s ',num2str(nth_5min1/12,'%.2f'),'_hour tt distribution'],'fontname','等线',...
		'FontSize',14,'FontWeight','bold','Interpreter', 'none');

figure('numbertitle','off','name','second_5min');
hist(tt_sum(nth_5min2,:),xbins);
	xlim([tt_min,tt_max]);
	xlabel('second','fontname','等线','FontWeight','bold','FontSize',12)
	ylabel('counts','fontname','等线','FontWeight','bold','FontSize',12)
	title([link_matname,'''s ',num2str(nth_5min2/12,'%.2f'),'_hour tt distribution'],'fontname','等线',...
		'FontSize',14,'FontWeight','bold','Interpreter', 'none');

figure('numbertitle','off','name','compare_5min');
hist((tt_sum([nth_5min1,nth_5min2],:))',xbins);
	xlim([tt_min,tt_max]);
	xlabel('second','fontname','等线','FontWeight','bold','FontSize',12)
	ylabel('counts','fontname','等线','FontWeight','bold','FontSize',12)
	title([link_matname,'''s ',num2str(nth_5min1/12,'%.2f'),' and ',num2str(nth_5min2/12,'%.2f'),' hour tt distribution'],'fontname','等线',...
		'FontSize',14,'FontWeight','bold','Interpreter', 'none');
	legend([num2str(nth_5min2/12,'%.2f'),'h'],[num2str(nth_5min1/12,'%.2f'),'h'])





	