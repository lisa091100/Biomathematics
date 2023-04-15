%%
my_system = @(t, y) systemFcn(t, y, 4, 0.5, 6);
drawing(my_system);

%%
function drawing(odeFun)
    start = 0;
    finish = 10;
    N = 8;
    x_vec = linspace(0.01, 1, N);
    y_vec = linspace(0.01, 1, N);
    hold on;
    axis([0 1 0 1]);
    hold on
    for i = 1:N
        for j = 1:N
            x0 = [x_vec(i), y_vec(j)];
            [~, X] = ode45(odeFun, [start, finish], x0);
            x = X(:, 1);
            y = X(:, 2);          
            q = quiver(x(1:end-1), y(1:end-1), x(2:end) - x(1:end-1), y(2:end)- y(1:end-1), 0.5);
            q.Color = [0.4412 0.4412 0.4412];
        end
    end
    p1 = plot(0, 0,'ko', 'MarkerFaceColor', [0 0 0]);
    p2 = plot(1, 0,'ko', 'MarkerFaceColor', [0 0 0]);
    hold off;
    xlabel('$u$','Interpreter','latex');
    ylabel('$v$','Interpreter','latex');
    legend([p1, p2], {'$Point_1$','$Point_2$'} ,'Interpreter','latex');
end

% Исследуемая система
function dydx = systemFcn(t, y, a, b, c)
    dydx = [y(1).*(-a.*log(y(1)) - y(2)); y(2).*(-1 + b.*y(1)./(c + y(2)))];
end