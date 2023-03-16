function plot_fun(loop,Variable,y_lim2,beso,var_name)

hold on
plot(0:loop-1,Variable(:,1),'k','LineStyle','-','Marker','o')
xlim([0 loop-1])
ylabel(var_name)
xlabel('Iterations')

yyaxis right
ylim([y_lim2(1) y_lim2(2)])
ylabel('Volume Fraction')
set(gca,'ycolor','k') 

plot(0:loop-1,beso.history(:,2),'m','LineStyle','-','Marker','s')

legend(var_name, 'Volume Fraction' ,'Location', 'Best')
grid on
box on
hold off




end