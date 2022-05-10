Podział na zbiory treningowy i testowy w stosunku 8/2. Zbiory składają się z cech(X_) oraz DEATH_EVENT(y_)
Dobierałem zbiory tak, aby udział "1" we wszystkich obserwacjach był taki sam oraz opis (.describe()) zbiorów X był do siebie zbliżony. 

train_set = X_train + y_train 
y_train: 
0 - 162
1 - 77  (32%)

test_set = X_test + y_test
y_test:
0 - 41
1 - 19 (32%)

