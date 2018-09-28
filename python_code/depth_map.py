from PIL import Image #Prøver å bruke minst mulig av hjelpebibloteker, mulig å la være å bruke PIL
#Read image
#im1 = Image.open( 'scene1.row3.col1.ppm' ) #Bilde 1, for å sammenligne med bilde 2
#im2 = Image.open( 'scene1.row3.col5.ppm' ) #Bilde 2, for å sammenligne med bilde 1
im1 = Image.open( 'im0.ppm' )
im2 = Image.open( 'im8.ppm' )
#dep = Image.open( 'scene1.row3.col1.ppm' ) #Bildet vi kommer til å fargelegge, kopi av bilde 1
dep = Image.open( 'im0.pgm' )
#im1 = im1.resize((200,200))
#im2 = im2.resize((200,200))
#dep = dep.resize((200, 200))
W = im1.size[0]
H = im1.size[1]

Wstart = 30
Hstart = 30
Wend = W-30
Hend = H-30

print("Picture is ", W, "x",H) 


#Oversatt fra C, mye variabeldeklarasjoner som ikke er nødvendige
row2 = 0
col2 = 0
tempDepth = 0

depthRed = 0
depthGreen = 0
depthBlue = 0

offset = 6
increment = 3
searchRadCol = 160
searchRadRow = 1

rowStart = 0
bestCol2 = 0
bestMatch = 0

tempIntensity = []
for i in range(0, offset):
    col = []
    for j in range(0,offset):
        col.append(0)
    tempIntensity.append(col)

depthMapReal = []
for i in range(0, H):
    col = []
    for j in range(0,W):
        col.append(0)
    depthMapReal.append(col)

for x in range(0, W): # Konverter bildet om til gråskala, enklere å lese "intensitet" 
    for y in range(0, H):
        pixel1 = im1.getpixel((x,y))
        pixel2 = im2.getpixel((x, y))
        grayValue1 = (int(0.299*pixel1[0]) + int(0.587*pixel1[1]) + int(0.114*pixel1[2]))
        grayValue2 = (int(0.299*pixel2[0]) + int(0.587*pixel2[1]) + int(0.114*pixel2[2]))

        im1.putpixel((x,y), (grayValue1, grayValue1, grayValue1))
        im2.putpixel((x,y), (grayValue2, grayValue2, grayValue2))

#for row in range(0, H):
#    for col in range(0, W):
#        depthMapReal[row][col] = 0


for row in range(0, H-offset, increment):
    for col in range(0, W-offset, increment):
        print("row:",row, "col:", col, end="\r")
        #print(end="\r")
        for rowOffset in range(0, offset):
            for colOffset in range(0, offset):
                pixelY = row+rowOffset
                pixelX = col+colOffset 
                tempIntensity[rowOffset][colOffset] = im1.getpixel((pixelX, pixelY))[0]
        #if (row < H-offset-5):
        #    row2 = row+5
        #else:
        #    row2 = H-row



        rowStart = row2
        row2start = max(row-searchRadRow, 0) 
        row2end = min(H-offset, row+searchRadRow)
        col2start = max(col-searchRadCol, 0)
        col2end = min(W-offset, col+searchRadCol)
        #col2start = 0
        #col2end = W-offset
        #print("search starting at: row:", row2start, "column: ", col2start)
        #print("search ending at: row: ",row2end, "column: ", col2end)
        bestCol2 = 0
        bestMatch = 9999999
        while (row2start < row2end):
            while(col2start < col2end):
                #if (bestMatch < 200):
                #    break
                    #print("bestmatch is:", bestMatch)
                intensityMatch = 0
                for rowOffset in range(0, offset):
                    for colOffset in range(0, offset):
                        pixelY = row2start+rowOffset
                        pixelX = col2start+colOffset
                        #print("at:",pixelX,"x", pixelY)
                        intensityMatch += abs(tempIntensity[rowOffset][colOffset]- im2.getpixel((pixelX, pixelY))[0])
                if (intensityMatch < bestMatch):
                    bestMatch = intensityMatch
                    bestCol2 = col2start
                
                col2start+=1
            row2start+=1
        #Write to depthMap
        #if(col-bestCol2 >0 and col - bestCol2 < 127 ):#and bestMatch < 5000):
        if (col-bestCol2<127 and col-bestCol2>0 and bestMatch < 5000):
            depthMapReal[row//increment][col//increment] = 2*abs(col-bestCol2)
#Fargelegging
for row in range(0, H):
    for col in range(0, W):
        tempDepth = depthMapReal[row//increment][col//increment]
        if (tempDepth < 43):
            depthRed = tempDepth*6
            depthGreen = 0
            depthBlue = tempDepth*6
        elif (tempDepth > 42 and tempDepth < 85):
            depthRed = 255 - (tempDepth-43)*6
            depthGreen = 0
            depthBlue = tempDepth * 6
        elif (tempDepth>84 and tempDepth <128):
            depthRed = 0
            depthGreen = (tempDepth-85)*6
            depthBlue = 255
        elif (tempDepth>127 and tempDepth <169):
            depthRed = 0
            depthGreen = 255
            depthBlue = 255 - (tempDepth-128)*6
        elif (tempDepth>168 and tempDepth <212): 
            depthRed = (tempDepth-169)*6
            depthGreen = 255
            depthBlue = 0
        elif (tempDepth >211 and tempDepth < 254):
            depthRed = 255 
            deptGreen = 255 - (tempDepth-212)*6
            depthBlue = 0
        elif (tempDepth > 255):
            depthRed = 255
            deptGreen = 0
            depthBlue = 0
        #Ifølge dokumentasjon, putpixel er treg, finn en alternativ løsning
        im2.putpixel((col, row), (depthRed, depthGreen, depthBlue))
im1.show()
im2.show()

