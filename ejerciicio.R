#Ejercicio
#While mientras valor <= 5 y se cumpla cuando llegue  a 5
#Guardar los valores en una variables llamada acumulado

acumulado <- 0 
contador <- 1
while(contador <= 5){
  acumulado <- acumulado + contador
  contador <- contador + 1
}

#Realize un ciclo for 1:5 y cuando termine diga ;este es el ultimo valor del item

for(i in 1:5){
  if(i == 5){
    print(paste('Este es el ultimo item: ', i, sep = ' '))
  }
}
