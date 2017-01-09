clear
close all

I=imread('pepsi00.jpg');

imgseq = zeros(201,201,11);
imgseq(:,:,1)=rgb2gray(imread('pepsi00.jpg'));
imgseq(:,:,2)=rgb2gray(imread('pepsi01.jpg'));
imgseq(:,:,3)=rgb2gray(imread('pepsi02.jpg'));
imgseq(:,:,4)=rgb2gray(imread('pepsi03.jpg'));
imgseq(:,:,5)=rgb2gray(imread('pepsi04.jpg'));
imgseq(:,:,6)=rgb2gray(imread('pepsi05.jpg'));
imgseq(:,:,7)=rgb2gray(imread('pepsi06.jpg'));
imgseq(:,:,8)=rgb2gray(imread('pepsi07.jpg'));
imgseq(:,:,9)=rgb2gray(imread('pepsi08.jpg'));
imgseq(:,:,10)=rgb2gray(imread('pepsi09.jpg'));
imgseq(:,:,11)=rgb2gray(imread('pepsi10.jpg'));


LKTrackWrapper(imgseq);


