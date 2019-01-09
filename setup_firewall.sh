#!/bin/bash

sudo apt-get install ufw
echo "y" | ufw enable >/dev/null 2>&1
sudo ufw default deny incoming
sudo ufw allow 22
sudo ufw allow 39697
sudo ufw allow 6667
sudo ufw allow 18988
sudo ufw allow 44433
sudo ufw allow 9333
sudo ufw allow 26969
sudo ufw allow 23230
sudo ufw allow 39105
sudo ufw allow 48484
sudo ufw allow 9797
sudo ufw allow 7214
echo "y" | ufw enable >/dev/null 2>&1
sudo ufw reload
sudo ufw status
#{Birake: 39697,
 #                   DarkPayCoin: 6667,
  #                  SnodeCoin: 18988,
   #                 MidasCoin: 44433,
    #                BitcoinGreen: 9333,
     #               LuxCoin: 26969,
      #              ExclusiveCoin: 23230,
       #             SafeInsureCoin: 39105,
        #            LogisCoin: 48484,
         #           Energi: 9797,
         #PayDayCoin: 7214,
          #          }

