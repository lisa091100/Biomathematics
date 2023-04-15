%% Одна точка
set(0,'DefaultTextInterpreter', 'latex');
hold on
axis([0 10 0 10]);
u = 0:0.01:10;
k = 1;
fplot(@(x) k*x.^3.*exp(-x), 'm');
fplot(@(x) x, 'k');
p1 = plot(0, 0,'ko', 'MarkerFaceColor', [0.6900 0.1250 0.8980]);
grid on
xlabel('$v$','Interpreter','latex');
ylabel('$f(v), g(v)$','Interpreter','latex');
legend(p1, {'$Point_1$'} ,'Interpreter','latex');

%% Две точки
set(0,'DefaultTextInterpreter', 'latex');
hold on
axis([0 10 0 10]);
u = 0:0.01:10;
k = exp(2)/4;
f = @(x) k*x.^3.*exp(-x);
g = @(x) x;
syms X
eqn = k*X^3*exp(-X) - X == 0;
V1 = vpasolve(eqn, X, [0 2]);
V2 = vpasolve(eqn, X, [2 10]);
fplot(@(x) k*x.^3.*exp(-x), 'm');
fplot(@(x) x, 'k');
p1 = plot(V1, f(V1),'ko', 'MarkerFaceColor', [0.6900 0.1250 0.8980]);
p2 = plot(V2, f(V2),'ko', 'MarkerFaceColor', [0.6900 0.1250 0.8980]);
grid on
xlabel('$v$','Interpreter','latex');
ylabel('$f(v), g(v)$','Interpreter','latex');
legend([p1, p2], {'$Point_1$','$Point_2$'} ,'Interpreter','latex');
%% Три точки
set(0,'DefaultTextInterpreter', 'latex');
hold on
axis([0 10 0 10]);
u = 0:0.01:10;
k = 3;
f = @(x) k*x.^3.*exp(-x);
g = @(x) x;
syms X
eqn = k*X^3*exp(-X) - X == 0;
V1 = vpasolve(eqn, X,[0 0.00001]);
V2 = vpasolve(eqn, X,[0.00001 1.99990]);
V3 = vpasolve(eqn, X,[2.00001 10]);
fplot(@(x) k*x.^3.*exp(-x), 'm');
fplot(@(x) x, 'k');
p1 = plot(V1, f(V1),'ko', 'MarkerFaceColor', [0.6900 0.1250 0.8980]);
p2 = plot(V2, f(V2),'ko', 'MarkerFaceColor', [0.6900 0.1250 0.8980]);
p3 = plot(V3, f(V3),'ko', 'MarkerFaceColor', [0.6900 0.1250 0.8980]);
grid on
xlabel('$v$','Interpreter','latex');
ylabel('$f(v), g(v)$','Interpreter','latex');
legend([p1, p2, p3], {'$Point_1$','$Point_2$', '$Point_3$'} ,'Interpreter','latex');

%% Исследование характера неподвижных точек
hold on
grid on
xlabel('$v$','Interpreter','latex');
ylabel('$f(v), g(v)$','Interpreter','latex');
axis([0 10 0 10]);
u = 0:0.01:10;
u0 = 3.3;
k = 7;
fplot(@(x) k*x.^3.*exp(-x), '-m');
fplot(@(x) x, '-r');

f = @(x) k*x.^3.*exp(-x);

yy = [0 f(u0)];
xx = [u0 u0];
drawArrow = @(x, y, varargin) quiver(x(1), y(1), x(2)-x(1), y(2)-y(1), 0, varargin{:}); 
p = plot(xx, yy, ':k');
p.LineWidth = 0.9; 
for i = 1:30
    tmp_xx = xx;
    tmp_yy = yy;
    xx = [xx(2), yy(2)];
    yy = [yy(2), f(tmp_xx(2))];
    h = drawArrow(xx, yy, 'color','k');
end
hold off;

%% Бифуркация
n1 = 600;
n2 = 100;
n = 800;
k = linspace(5, 6, n);
z = @(x, k) k*x.^3.*exp(-x);
vec = zeros(1, n2);
u0 = 3;
hold on
xlabel('$k$','Interpreter','latex'); 
ylabel('$u$','Interpreter','latex');
axis([5 6 0 10]);
xline(5.7, '-k', 'LineWidth', 1.5);
for i=1:n
    u = z(u0, k(1));
    for j = 1:n1
        u = z(u, k(i));
    end
    for j = 1:n2
        u = z(u, k(i));
        vec(j) = u;
    end
    k_vec = ones(1, n2).*k(i);
    plot(k_vec, vec, '.', 'MarkerSize', 3, 'MarkerEdgeColor', [0.4940 0.1840 0.5560]);  
end

[x,y] = ginput(3)


%%
k_grid = linspace(1, 7, 5000);
z1 = @(x, k) k * x.^3.*exp(-x);
z = @(x, k) k * x.^2.*exp(-x).*(3-x);
hold on;
grid on;
axis([1 7 -7 2]);
sum_all = [];
for i = 1:length(k_grid)
    u = 2;
    sum = log(abs(z(u, k_grid(i))));
    for j = 1:1000
        z_next = z1(u, k_grid(i));
        z_now = z(u, k_grid(i));
        sum = sum + log(abs(z_now));
        u = z_next;
    end
    sum_all = [sum_all, sum./1000];
end
nuu = zeros(1, length(k_grid));
plot(k_grid, sum_all,'.', 'MarkerSize', 2, 'MarkerEdgeColor', [0.4940 0.3840 0.8560]);
plot(k_grid, nuu,'-k');
xlabel('$k$','Interpreter','latex'); 
ylabel('$h(v_1)$','Interpreter','latex');

%%
f = @(v, u, k) k.*(v.^3).*exp(-u);

u0 = 5.001;
v0 = 5.001;
k = exp(5)/25;
iteration = 30;

fVec = zeros(1, iteration);
fVec(1) = v0;
fVec(2) = u0;

for i = 3:iteration
    fVec(i) = f(fVec(i-1), fVec(i-2), k);
end
hold on
axis([1 30 -0.01 6]);
grid on
yline(5, '--k', 'LineWidth', 0.5);
plot(v0, f(v0, u0, k)); 
plot(1:iteration, fVec, 'bo-', 'MarkerSize', 6, 'MarkerFaceColor', [0.4940 0.4840 0.7560]);
xlabel('$t$','Interpreter','latex'); 
ylabel('$v_t$','Interpreter','latex');
