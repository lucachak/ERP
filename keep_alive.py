import datetime
import random
import time
import urllib.request

URL = "https://cambiomatic.onrender.com/"
URL2 = "https://fingen-app.onrender.com/"


def ping():
    while True:
        try:
            print(
                f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Fazendo request para {URL} and {URL2}..."
            )
            response = urllib.request.urlopen(URL)
            response2 = urllib.request.urlopen(URL2)

            print(
                f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Status: {response.getcode()} OK"
            )
            print(
                f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Status: {response2.getcode()} OK"
            )
        except Exception as e:
            print(
                f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Erro: {e}"
            )

        # Espera um tempo aleatório entre 60 (1 minuto) e 90 (1.5 minutos) segundos
        wait_time = random.randint(60, 90)
        print(f"Aguardando {wait_time} segundos para o próximo request...\n")
        time.sleep(wait_time)


if __name__ == "__main__":
    print("Iniciando o script de keep-alive...")
    ping()
