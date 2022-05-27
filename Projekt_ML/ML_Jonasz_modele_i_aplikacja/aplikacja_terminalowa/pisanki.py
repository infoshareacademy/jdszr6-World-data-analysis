# import bibliotek
import pickle # do otwarcia modelu
import argparse #służy do parsowania parametrów z konsoli
import logging #żeby logować
import sys

# predykcja
def death_pred(params):
    model = pickle.load(open('1_model_pickled_pisanki.pkl','rb')) # otwórz zapiklowany predyktor
    result = model.predict([[params.age, params.anaemia, params.creatinine_phosphokinase, params.diabetes, params.ejection_fraction, params.high_blood_pressure, params.platelets, params.serum_creatinine, params.serum_sodium, params.sex, params.smoking]])
    if result[0] == 1: # sprawdź co wyrzyuca model dla wprowadzonych danych
        pred = 'Person has a risk of soon death'
    else:
        pred = 'Person has no risk of soon death'
    return pred # zwróć wynik z modelu
  
# główna funkcja 
def main(params):
    log = logging.getLogger('pisanki') #definiujemy logger - weź logger 'pisanki'
    result = death_pred(params) # taka jest konwencja, tu nie piszemy całości (dostęp poprzez params.1,2,3,n,...)
    log.debug('checking death event for the following input: age({0}), anaemia({1}), creatinine_phosphokinase({2}), diabetes({3}), ejection_fraction({4}), high_blood_pressure({5}), platelets({6}), serum_creatinine({7}), serum_sodium({8}), sex({9}), smoking({10})'.format(params.age,params.anaemia,params.creatinine_phosphokinase,params.diabetes,params.ejection_fraction, params.high_blood_pressure, params.platelets, params.serum_creatinine, params.serum_sodium, params.sex, params.smoking))
    if result: #służy do sprawdzenia czy wsad jest ok
        log.info('Result: {0}'.format(result))
    else:
        log.error('Wrong operation!')
    
if __name__ == "__main__": #oznacza, że uruchomi się to jeżeli uruchomimy sobie skrypt w konsoli
    ## parsowanie (analiza) argmentów z konsoli 
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter) #mówi o tym, ze będziemy wprowadzali parametry z ręki 
    parser.add_argument('--age', type=int, default=60,
                        help="put age in years")
    parser.add_argument('--anaemia', type=int, default=0,
                        help="inform about anaemia state by 0-1 input")
    parser.add_argument('--creatinine_phosphokinase', type=int, default=300,
                        help="inform about creatinine phosphokinase level (put number). Default set to mode.")
    parser.add_argument('--diabetes', type=int, default=0,
                        help="put information about diabetes (0-1 input)")   
    parser.add_argument('--ejection_fraction', type=int, default=38,
                        help="inform about ejection fraction (put number). Default set to mean.")
    parser.add_argument('--high_blood_pressure', type=int, default=0,
                        help="inform about hypertension state by 0-1 input")
    parser.add_argument('--platelets', type=int, default=263358,
                        help="inform about platelets level (put number). Default set to mean.")    
    parser.add_argument('--serum_creatinine', type=float, default=1.0,
                        help="inform about serum ceratinine level (put number). Default set to mode.")
    parser.add_argument('--serum_sodium', type=int, default=137,
                        help="inform about serum sodium level (put number). Default set to mode.")
    parser.add_argument('--sex', type=int, default=1,
                        help="put 1 for male, 0 for female")    
    parser.add_argument('--smoking', type=int, default=0,
                        help="inform about smoking status, use 0 or 1.")  
    parser.add_argument('--debug', action='store_const', const=True, default=False, #store_const oznacza, że argument został podany albo nie
                        help='Set debug logging level, otherwise info level is set.')    
    parser.add_argument('--to_file', action='store_const', const=True, default=False, #można zapisać do pliku
                        help='possible logging to file') 
    
    params = parser.parse_args() #zczytuje wszystkie parametry do obiektu params
    # konfiguracja loggera
    logger = logging.getLogger('pisanki') #będziemy się na niego powoływać
    logger.setLevel(logging.DEBUG)
    if params.to_file:
        ch = logging.StreamHandler(sys.stdout)  
    else:
        ch = logging.StreamHandler()
        
    ch.setLevel(logging.DEBUG if params.debug else logging.INFO)
    ch.setFormatter(logging.Formatter(fmt='%(asctime)s [%(name)s:%(levelname)s]: %(message)s', 
                                      datefmt="%H:%M:%S")) # rodzaj formatowania
    logger.addHandler(ch)
    # wywolanie funckji main
    main(params)

# age, anaemia, creatinine_phosphokinase, diabetes, ejection_fraction, high_blood_pressure, platelets, serum_creatinine, serum_sodium, sex, smoking      