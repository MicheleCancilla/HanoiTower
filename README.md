# HanoiTower
Hanoi Tower implemented in MATLAB

In order to play a "console" game you have to run "towerOfHanoi.m" script, setting the follow parameters:
{nOfDisks, gamma, alpha, epsilon}

The training results will be stored in a "hanoi-x.mat" file, where x is the number of the disks used in game.

The script "GUI.m" allow to play a GUI game. This script need a "hanoi-x.mat" file frowm which read the matrix of actions Q.
Every time "GUI.m" is lanched, the number of disks to use is requested, after that the game is automatically showed.
