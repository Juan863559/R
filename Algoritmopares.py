#Algoritmo que calcula la suma de los primeros N numeros pares

N=input("Ingresa un numero: ")
N=int(N)
#lista del 1 a N
lista=list(range(1,N+1))
#multiplicar los numeros de la lista por 2
lista2=[i*2 for i in lista]
#suma de los numeros de la lista
suma=sum(lista2)
#imprimir la suma
print(suma)
