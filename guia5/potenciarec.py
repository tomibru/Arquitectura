def potencia(base, exp):
    if exp == 0:
        return 1
    else:
        return potencia(base, exp -1)*base

print("Ingrese base y exponente")
base = int(input("Introduce base"))
exp = int(input("Introduce exp"))
print(potencia(base, exp))
