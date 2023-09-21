#EJERCICIO 1
""" 
while True:
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Hasta luego!")
    break
 elif opcion<'1' or opcion > '5':
    print("opcion no valida")
 else:
   num1 = float(input("Ingresa el primer número: "))
   num2 = float(input("Ingresa el segundo número: "))
   
   if opcion == '1':
      print("Resultado:", num1 + num2)
   elif opcion == '2':
      print("Resultado:", num1 - num2)
   elif opcion == '3':
      print("Resultado:", num1 * num2)
   elif opcion == '4':
      if num2 != 0:
         print("Resultado: ", num1 / num2)
      else:
         print("No se puede dividir entre cero")
   else:
      print("¡Gracias por usar Mi Calculadora!")

 """
#Ejercicio 2

""" class MiCalculadora:
 def __init__(self):
    pass
 def suma(self, a, b):
    return a + b
 def resta(self, a, b):
    return a - b
 def multiplicacion(self, a, b):
    return a * b
 def division(self, a, b):
    if b != 0:
        return a / b
    else:
        return "No se puede dividir entre cero" 
calculadora = MiCalculadora()
while True:
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Gracias por usar Mi Calculadora!")
    break
 elif opcion < '1' or opcion > '5':
        print("Opción no válida")
 else:
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))
 if opcion == '1':
    print("Resultado:", calculadora.suma(num1, num2))
 elif opcion == '2':
    print("Resultado:", calculadora.resta(num1, num2))
 elif opcion == '3':
    print("Resultado:", calculadora.multiplicacion(num1, num2))
 elif opcion == '4':
    if num2 != 0:
        print("Resultado:", calculadora.division(num1, num2))
    else:
        print("No se puede dividir entre cero")
 """

 #Ejercicio 3
""" 
def suma(a, b):
 return a + b
def resta(a, b):
 return a - b
def multiplicacion(a, b):
 return a * b
def division(a, b):
 return a / b

def mi_calculadora(opcion, num1, num2):
 if opcion == '1':
    return suma(num1, num2)
 elif opcion == '2':
    return resta(num1, num2)
 elif opcion == '3':
    return multiplicacion(num1, num2)
 elif opcion == '4' and num2 != 0:
    return division(num1, num2)
 else:
    return "Opción no válida"
while True:
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Gracias por usar Mi Calculadora!")
    break
 elif opcion < '1' or opcion > '5':
    print("Opción no válida")
 else:
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))
    resultado = mi_calculadora(opcion, num1, num2)
 print("Resultado:", resultado) """


#Ejercicio 4
""" 
def suma(a, b):
 return a + b
def resta(a, b):
 return a - b
def multiplicacion(a, b):
 return a * b
def division(a, b):
 return a / b if b != 0 else "No se puede dividir entre cero"
def mi_calculadora(opcion, num1, num2):
 return (
 suma(num1, num2) if opcion == '1'
 else resta(num1, num2) if opcion == '2'
 else multiplicacion(num1, num2) if opcion == '3'
 else division(num1, num2) if opcion == '4' and num2 != 0
 else "Opción no válida"
 )
while True:
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Gracias por usar Mi Calculadora!")
    break
 elif opcion < '1' or opcion > '5':
    print("Opción no válida")
 else:
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))
    resultado = mi_calculadora(opcion, num1, num2)
    print("Resultado:", resultado)

 """

#Ejercicio 5
""" 
def suma(a, b):
 return a + b
def resta(a, b):
 return a - b
def multiplicacion(a, b):
 return a * b
def division(a, b):
 return a / b if b != 0 else "No se puede dividir entre cero"
def mi_calculadora(opcion, num1, num2):
 return (
 suma(num1, num2) if opcion == '1'
 else resta(num1, num2) if opcion == '2'
 else multiplicacion(num1, num2) if opcion == '3'
 else division(num1, num2) if opcion == '4' and num2 != 0
 else "Opción no válida"
 )
def mostrar_menu():
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
while True:
 mostrar_menu()
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Gracias por usar Mi Calculadora!")
    break
 elif opcion < '1' or opcion > '5':
    print("Opción no válida")
 else:
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))
    resultado = mi_calculadora(opcion, num1, num2)
    print("Resultado:", resultado)
 """

#Ejercicio 6
""" 
def suma(a, b):
 return a + b
def resta(a, b):
 return a - b
def multiplicacion(a, b):
 return a * b
def division(a, b):
 return a / b if b != 0 else "No se puede dividir entre cero"
def operar(func, a, b):
 return func(a, b)
def mostrar_menu():
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
while True:
 mostrar_menu()
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Gracias por usar Mi Calculadora!")
    break
 elif opcion < '1' or opcion > '5':
    print("Opción no válida")
 else:
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))
 if opcion == '1':
    resultado = operar(suma, num1, num2)
 elif opcion == '2':
    resultado = operar(resta, num1, num2)
 elif opcion == '3':
    resultado = operar(multiplicacion, num1, num2)
 elif opcion == '4':
    resultado = operar(division, num1, num2)
 print("Resultado:", resultado)
 """


#Ejercicio 7

""" 
def operacion(op, a, b):
 if op == 'suma':
    return a + b
 elif op == 'resta':
    return a - b
 elif op == 'multiplicacion':
    return a * b
 elif op == 'division':
    return a / b if b != 0 else "No se puede dividir entre cero"
 else:
    return "Operación no válida"
def mostrar_menu():
 print("\nMi Calculadora")
 print("1. Suma")
 print("2. Resta")
 print("3. Multiplicación")
 print("4. División")
 print("5. Salir")
while True:
 mostrar_menu()
 opcion = input("Selecciona una opción: ")
 if opcion == '5':
    print("¡Gracias por usar Mi Calculadora!")
    break
 elif opcion < '1' or opcion > '5':
    print("Opción no válida")
 else:
    num1 = float(input("Ingresa el primer número: "))
    num2 = float(input("Ingresa el segundo número: "))
 if opcion in ['1', '2', '3', '4']:
    operacion_seleccionada = {
 '1': 'suma',
 '2': 'resta',
 '3': 'multiplicacion',
 '4': 'division'
 }[opcion]
 resultado = operacion(operacion_seleccionada, num1,
num2)
 print("Resultado:", resultado)

 """


print("pedro".capitalize())