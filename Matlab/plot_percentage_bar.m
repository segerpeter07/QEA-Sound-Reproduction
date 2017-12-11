function plot_percentage_bar(percent_done, plot_title, color)
    %   Plots a percentage bar when running a function
    cla;
    hold on;
    ax = gca;
 
    if color == 'r'
        bar_color = [0.8, 0.15, 0.2];
        dark_bar_color = [0.6, 0.1, 0.12];
    end
    if color == 'b'
        bar_color = [0.3, 0.4, 0.9];
        dark_bar_color = [0.22, 0.3, 0.7];
    end
    if color == 'g'
        bar_color = [0.15, 0.8, 0.15];
        dark_bar_color = [0.1, 0.6, 0.1];
    end
    

    rectangle('Position', [0, 0, 10, 0.3], 'FaceColor',[0.85, 0.85, 0.85], 'LineWidth',0.1, 'EdgeColor', [0.85, 0.85, 0.85])
    rectangle('Position', [0, 0, percent_done/10, 1],'FaceColor',bar_color, 'LineWidth',0.1, 'EdgeColor', bar_color)
    rectangle('Position', [0, 0, percent_done/10, 0.3],'FaceColor',dark_bar_color, 'LineWidth',0.1, 'EdgeColor', dark_bar_color)
       rectangle('Position',[0,0,10,1],'EdgeColor','k','LineWidth',2)
    ax.DataAspectRatio = [1, 1, 1];
    ax.Box = 'off';
    ax.XTick = [];
    ax.YTick = [];
    title([plot_title ' - ' num2str(round(percent_done)) '%']);
end