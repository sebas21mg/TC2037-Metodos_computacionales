def sumaDigitos (s, n):
  if n < 10:
    return s + n
  s = s + n % 10
  n = n // 10
  return sumaDigitos(s, n)

s = 0
s = sumaDigitos(s, 52838)
print(s)

# s = 0
# s = sumaDigitos(s, 762)
# print(s)

# s = 0
# n = 764
# for i in range(2):
#   s = s + n % 10
#   n = n // 10
# s = s + n
# print(s)

