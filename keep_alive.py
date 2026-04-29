import urllib.request
import time
import datetime
import random


URL = "https://cambiomatic.onrender.com/login"
# "https://www.cambiomatic.onrender.com"

def ping():
    while True:
        try:
            print(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Fazendo request para {URL}...")
            response = urllib.request.urlopen(URL)
            print(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Status: {response.getcode()} OK")
        except Exception as e:
            print(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Erro: {e}")
        
        # Espera um tempo aleatório entre 60 (1 minuto) e 90 (1.5 minutos) segundos
        wait_time = random.randint(60, 90)
        print(f"Aguardando {wait_time} segundos para o próximo request...\n")
        time.sleep(wait_time)

if __name__ == "__main__":
    print("Iniciando o script de keep-alive...")
    ping()
