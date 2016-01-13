%plot synt

plotseismic(data_out(950:1050,:),time_series(950:1050),offset);
xlabel('Offset (ft)','Fontsize',14);
ylabel('TWT (s)', 'Fontsize', 14);
set(gca,'fontsize',14)
grid on
set(gcf, 'PaperUnits', 'inches');
x_width=4.8; y_width=7.1;
set(gcf, 'PaperPosition', [0 0 x_width y_width]); %

print(gcf, '-dpng', '-loose', '-r100', 'model_syn101_corrected');