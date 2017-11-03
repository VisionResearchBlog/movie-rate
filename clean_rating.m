clear all
%load data
data_dir='/Volumes/1TB/GLANCE/tent/';
subnum='11/';
fn='11.190717.tent.rating.mat'
load([data_dir subnum fn])

r_tmp=0;
for i=1:length(rating)
	
	
	if(rating(i)~=0)
		r_tmp=rating(i);
	else %keep old
		%nothing
	end
	
	new_rate(i)=r_tmp;
end

figure(1); clf; hold on 
plot(rating); 
plot(new_rate)