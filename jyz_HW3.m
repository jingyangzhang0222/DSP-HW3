clear
close all

u = @(n) (n >= 0); %Function
del = @(n) (n == 0); % Function

n1 = 0 : 2;
h = del(n1) + 4 * del(n1 - 1) + 2 * del(n1 - 2);
n2 = -10 : 10;
[r, p, k] = residue([1 0],[1 4 2]);
g1 = r(1) * p(1).^n2 .* u(n2) + r(2) * p(2).^n2 .* u(n2);
%Causal but Unstable, ROC: z > 3.4142
g2 = -r(1) * p(1).^n2 .* u(-n2-1) + r(2) * p(2).^n2 .* u(n2);
%Stable but Non-causal, ROC: 0.5858< z <3.4142

load DataEOG.txt 
x = DataEOG;
b = conv(x, h);
lenb = length(b);
b(1 : (lenb - length(x)) / 2) = [];
b(end - ((lenb - length(x)) / 2) + 1: end) = [];
%Cutting

y1 = filter([1 4 2], [1], b);

y2 = conv(b, g2);
leny2 = length(y2);
y2(1 : (leny2 - length(x)) / 2) = [];
y2(end - (leny2 - length(x)) / 2 + 1: end) = [];
%Cutting

subplot(4, 2, 1)
plot(0 : length(x) - 1, x)
title('Input signal : x')

subplot(4, 2, 3)
plot(0 : length(b) - 1, b)
title('Received signal : b = conv(h, x)')

subplot(4, 2, 5)
plot(0 : length(y1) - 1, y1)
title('Output signal using Causal but Unstable inverse : y1 = filter([1 4 2], [1], b)')

subplot(4, 2, 7)
plot(0 : length(y2) - 1, y2)
title('Output signal using Stable but Non-causal inverse : y2 = conv(b, g2)')

subplot(4, 2, 2)
plot(0 : length(x) - 1, x)
xlim([400 450])%Set range of axe of n
title('Segment of x')

subplot(4, 2, 4)
plot(0 : length(b) - 1, b)
xlim([400 450])%Set range of axe of n
title('Segment of b')

subplot(4, 2, 6)
plot(0 : length(y1) - 1, y1)
xlim([400 450])%Set range of axe of n
title('Segment of y1')

subplot(4, 2, 8)
plot(0 : length(y2) - 1, y2)
xlim([400 450])%Set range of axe of n
title('Segment of y2')