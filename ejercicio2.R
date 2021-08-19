#Contruir un vector numerico con 10 entradas de los numeros 5:14
vector_num <- c(5:14)


#Obtenga la longitud del vector
length(vector_num)


#Uso del [] para acceder a la primera posicion
vector_num[1]


#Uso de la funcion length para acceder a la ultima posicion del vector 
vector_num[length(vector_num)]


#Agregue una nueva entrada con el numero 23 al vector
vector_num <- append(x = vector_num, values = 23, after = length(vector_num))

length(vector_num)

vector_num[length(vector_num)]