from scipy.io import loadmat
import matplotlib.pyplot as plt
import numpy as np

acc = [ 0, 0.25, 0.5]
cacc = [0.5, 0.25, 0]
time_CAR = []
flow_det3 = []
flow_det4 = []
speed_vehicles_det3 = []
speed_vehicles_det4 = []

for i in range(3):
    for r in range(3):
        seed = r+1
        file = 'b_1_seed' + str(seed) + '_acc_' + str(acc[i]) + '_cacc_' + str(cacc[i]) + '.mat'
        #x = loadmat('b_1_seed_1_acc_0.5_cacc_0.mat')
        x = loadmat(file)

        time_CAR_mean = x['output']['travelTime'][0][0][0][0][0].mean()

        flow_det3_mean = x['output']['detector'][0][0][0][2][1].mean()
        flow_det4_mean = x['output']['detector'][0][0][0][3][1].mean()

        speed_vehicles_det3_mean = x['output']['detector'][0][0][0][2][1].mean()
        speed_vehicles_det4_mean = x['output']['detector'][0][0][0][3][1].mean()

        print(file)
        print('Mean Travel time:' , time_CAR_mean)

        print('\n Mean Flow through detector 3:', flow_det3_mean )
        print('\n Mean Flow through detector 4:', flow_det4_mean )
        print('\n Mean Flow through detector 3+4:', (flow_det3_mean+flow_det4_mean)/2.0 )

        print('\n Mean vehicle speed through detector 3:', speed_vehicles_det3_mean )
        print('\n Mean vehicle speed through detector 4:', speed_vehicles_det4_mean )
        print('\n Mean vehicle speed through detector 3+4:', (speed_vehicles_det3_mean + speed_vehicles_det4_mean)/2.0 )

'''    time_CAR = np.array(time_CAR)
    flow_det3 = np.array(flow_det3)
    flow_det4 = np.array(flow_det4)
    speed_vehicles_det3 = np.array(speed_vehicles_det3)
    speed_vehicles_det4 = np.array(speed_vehicles_det4)


x = loadmat('b_1_seed_1_acc_0.5_cacc_0.mat')

time_CAR = x['output']['travelTime'][0][0][0][0][0]

flow_det3 = x['output']['detector'][0][0][0][2][1]
flow_det4 = x['output']['detector'][0][0][0][3][1]

speed_vehicles_det3 = x['output']['detector'][0][0][0][2][1]
speed_vehicles_det4 = x['output']['detector'][0][0][0][3][1]

print(speed_vehicles_det4.shape)

#print(x['output']['travelTime'][0][0][0][0][0].shape) #Last zero is to caluculate the speed of CAR, if 1 then ACC_CAR, 2: ACC_TRUCK, 3: CACC_TRUCK

#print(x['output']['travelTime'].shape)
#print(x['output']['detector'][0][0][0][2][1])  #here [2] is detector which means detector 3,  the last [1] is flow (q)
#plt.plot(x['output']['detector'][0][0][0][2][1])
#plt.show()

#lon = loadmat('test.mat')['lon']


'''
