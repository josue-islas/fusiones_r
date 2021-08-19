#Definimos 2 vectores
#Para realizar operaciones, los vectores deben ser de la misma longitud

vector_num1 <- c(1:4)
vector_num2 <- c(2:5)

#Suma de dos vectores
suma_vectores <- vector_num1 + vector_num2

#R suma cada entrada, 1-1, 2-2, 3-3 ... n-n

#Multiplicacion de dos vectores
mult_vectores <- vector_num1 * vector_num2


#Resta de dos vectores
resta_vectores <- vector_num1 - vector_num2


#divicion de dos vectores
div_vectores <- vector_num1 / vector_num2


#Producto escalar de dos vectores (suma de los productos de las entradas)
esc_vectores <- vector_num1 %*% vector_num2

#Suma de todas las entradas de un vector
sum(vector_num1)
sum(vector_num2)
#Producto escalar v2
sum(vector_num1 * vector_num2)

#----------------------------
#         LIBRERIA
#----------------------------
#Contienen diversas funciones, una funcion es aquella palabra reservada que tiene codigo que podemos resiclar una y ptra vez

source(file = 'Docs//archivos_r//curso_r//3_8_Librerias.R') #Para ejecutar librias

