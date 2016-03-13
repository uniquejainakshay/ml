f = open('train')

featureSet = 1000*[None]
featureindex = -1
mailIndex = -1
X = [[ 0 for x in range(1000)] for x in range(9000)]
Y = [0 for x in range(9000)]
tmp = 0;
for mail in f :
    mailIndex = mailIndex + 1
    print mailIndex
    wordlist = mail.split(" ")
    # assigning labels
    if wordlist[1] == 'spam' :
        Y[mailIndex] = 1
    else :
        Y[mailIndex] = -1
    
    size = len(wordlist)
    i = 2
    while i < size :
        word = wordlist[i]
        if featureindex == -1 :
            featureindex = featureindex + 1
            featureSet[featureindex] = word
            X[0][0] = int(wordlist[i+1])
        else :
            #now searching for word in current
            flag = -1
            index = -1
            for feature in featureSet :
                index = index + 1
                if feature == word :  #existing feature
                    flag = 0
                    X[mailIndex][index] = int(wordlist[i+1])
                    break
            if flag == -1 :    #new feature
                featureindex = featureindex + 1
                featureSet[featureindex] = word
                X[mailIndex][featureindex] = int(wordlist[i+1])
        i = i + 2
    #breaking early remove it
    #tmp = tmp + 1
    #if tmp == 100 :
    #    break

f1 = open('test')
mailIndex = -1
Xtest = [[ 0 for x in range(1000)] for x in range(1000)]
Ytest = [0 for x in range(1000)]
for mail in f1 :
    mailIndex = mailIndex + 1
    print mailIndex
    wordlist = mail.split(" ")
    if wordlist[1] == 'spam' :
        Ytest[mailIndex] = 1
    else :
        Ytest[mailIndex] = -1
    size = len(wordlist)
    i = 2
    while i < size :
        word = wordlist[i]
        flag = -1
        index = -1
        for feature in featureSet :
            index = index + 1
            if feature == word :
                Xtest[mailIndex][index] = int(wordlist[i+1])
                break
        i = i + 2

        
    

    
    
print featureSet

import numpy, scipy.io

scipy.io.savemat('/home/mtech/mcs142800/Desktop/Q1/flarge.mat',mdict={'X':X , 'Y':Y})

scipy.io.savemat('/home/mtech/mcs142800/Desktop/Q1/testlarge.mat',mdict={'X':Xtest , 'Y':Ytest})



