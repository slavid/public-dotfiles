from tokenize import String
import sys
import math
import argparse


# maxCharacteres = 274

class main:


    if __name__ == "__main__":

        parser = argparse.ArgumentParser()
        parser.add_argument("-n", "--num", required=True)
        parser.add_argument("-f", "--file", required=True)
        args = parser.parse_args()

        file = open(args.file)

        maxCharacteres = int(args.num)
        stringFile = file.read()
               
        countCharacters = stringFile.__len__()
        
        chunks = math.ceil(countCharacters / maxCharacteres)
        
        counter=0
        string_list = []
        
        for i in range(chunks):
            new_string = ""
            for k in range(maxCharacteres):
                if(counter<countCharacters):
                    new_string += stringFile[counter]
                    counter+=1
            string_list.append(new_string)        
            print(string_list[i].strip() + " (" + str(i+1) + "/" + str(chunks) + ") \n")
            
                    
        file.close()
        