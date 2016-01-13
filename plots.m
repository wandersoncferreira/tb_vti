%plots

h1=subplot(1,3,1);
plot(A(1:10848,3),depth(1:10848),'-r');
grid on
axis ij
xlabel('Amplitude','fontsize', 15)
ylabel('Depth (ft)','fontsize',15)
title('Gamma - Seismic Unix code','fontsize',15)
set(h1,'fontsize',15)



h2=subplot(1,3,2);
plot(gamma(1:10848,1),depth(1:10848),'-k');
grid on
axis ij
xlabel('Amplitude','fontsize', 15)
ylabel('Depth (ft)','fontsize',15)
title('Delta - my code','fontsize',15)
set(h2,'fontsize',15)

h3=subplot(1,3,3);
plot(gamma(1:10848,1),depth(1:10848),'-k');
hold on
plot(A(1:10848,3),depth(1:10848),'-r');
grid on
axis ij
xlabel('Amplitude','fontsize', 15)
ylabel('Depth (ft)','fontsize',15)
title('Both on the same plot','fontsize',15)
legend('My code','SU code')
set(h3,'fontsize',15)


set(gcf, 'PaperUnits', 'inches');
x_width=18; y_width=12;
set(gcf, 'PaperPosition', [0 0 x_width y_width]); 
print(gcf, '-dpng', '-loose', '-r100', 'gamma');
