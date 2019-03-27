"""
给定序列的参数计算多采每一次预相位梯度需要打的的大小
"""

BW_FRE = 256000 #频率维带宽(Hz)
BW_PE = 256000 #相位维带宽(Hz)
FOV_FRE = 0.22  #频率维视野（m)
FOV_PE = 0.22 #相位维视野(m)
GAMMA = 42.58e6 #旋磁比(MHz/T)
TE = 0.1395#采集信号的中点(s)  从180° 脉冲开始算起 这个是自己计算完序列自己算的，
NUM = 256 #采样点数
N = 16 #多采次数
pre_gradient = {}#每一次需要打的预梯度,字典形式储存
n = NUM/N #每次采集的K空间线条数
T_prepare = 0.001# 180度脉冲之后破坏梯度施加的时间(s)，在这里我们将此脉冲和破坏梯度整合到一起
GRA_CRUSH = 3.219 #破坏梯度的大小
delta_tf = 1/BW_FRE#频率维采样时间间隔
delta_tpe = 1/BW_PE #相位维采样时间间隔
Tf = NUM*delta_tf #读出时频率梯度持续的时间
Tblip = delta_tpe #读出时相位梯度持续的时间
Gf = BW_FRE/(GAMMA*FOV_FRE)#读出时频率梯度的大小
Gpe = BW_PE/(GAMMA*FOV_PE)#读出时相位梯度的大小

halftime = (n/2-0.5)*Tf
time_point = TE - T_prepare -halftime#加0.01是因为我额外加了0.01的缓冲时间
for i in range(1,N+1):
    pre_gradient[str(i)] = delta_tpe*(-Gpe)*(i-1)/T_prepare


print("采集开始的时间(从前一个evovel算起):" + str(time_point))

print("每次需要打的预梯度大小：")
for i in range(1,N+1):
    print(str(i)+":" + str(GRA_CRUSH+pre_gradient[str(i)]))




