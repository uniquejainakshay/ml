
word_dict = {}
y = []
data_file = open("new_train","r")

output_file1 = open("class_labels.txt","w")
output_file2 = open("doc_term_mat.txt","w")

i = 0
for line in data_file:
    line_list = line.split()
    #y[i] = line_list[1]
    y.append(line_list[1])
    n = len(line_list)
    for j in xrange(2,n,2): #words come alternately after every third line
        key = line_list[j]

        if word_dict.has_key(key):
            word_dict[key] += 1
        else:
            word_dict[key] = 1
    i += 1

total_words  = word_dict.keys()
print total_words
print i
for Y in y:
    output_file1.write(Y)
    output_file1.write("\n")
    

output_file1.close()
vocab_size = len(total_words)

doc_matrix = [[0 for x in range(vocab_size)] for x in range(i)] #no of training examples 


#reopen data file for processing
data_file.close()
data_file = open("new_train","r")

v = 0
for line in data_file:
    line_list = line.split()
    n = len(line_list)
    print v
    for j in xrange(2,n,2): #words come alternately after every third line
        key = line_list[j]
        occurence = int(line_list[j+1])
        
        # get the positions . only one occurence of each word should be there.
        pos_list = [u for u,x in enumerate(total_words) if x == key] 
        position = pos_list[0]
        doc_matrix[v][position] = occurence
    v += 1   

data_file.close()

for d in doc_matrix:
    for elem in d:
        output_file2.write(str(elem))
        output_file2.write("\t")
    output_file2.write("\n")

output_file2.close()
