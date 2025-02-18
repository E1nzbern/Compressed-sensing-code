% 利用稀疏理论进行图像重建测试
clear; clc;

im = imread('lena.bmp');  % 读入图像
figure(),
subplot(131),
imshow(im);
title('原始彩色图像');


imgrey = im2gray(im);              % 转为灰度图像
subplot(132),
imshow(imgrey);
title('原始灰度图像');

bsize = 8;
imcols = im2col(im2double(imgrey), [bsize, bsize], 'distinct');

codebook = dctmtx(bsize ^ 2);% DCT字典矩阵，经典教程里的Psi，用作正交变换基

M = 64;%观测值个数，次数，观测向量长度
N = 64;%信号x的长度
Phi = randn(M,N);%测量矩阵为高斯矩阵
A = Phi * codebook;
% 稀疏求解，需要对imcols的行进行遍历
cols = size(imcols, 2);
sparse = zeros(size(imcols));
for i = 1 : cols
    sparse(:, i) = BP_linprog(Phi * imcols(:, i), A);
end

% 图像重建
imrecons = codebook * sparse;
imrecons = col2im(imrecons, [bsize bsize], size(imgrey), 'distinct');
subplot(133),
imshow(imrecons);
title('稀疏重建图像');

%% 评价
imrecons = uint8(255.*mat2gray(imrecons));
PSNR = psnr(imgrey, imrecons);
SSIM = ssim(imgrey, imrecons);
MSE = mse(imgrey, imrecons);