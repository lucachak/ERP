import datetime
import random
import sys
import time
import urllib.request
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor

URL = "https://cambiomatic.onrender.com/"
URL2 = "https://fingen-app.onrender.com/"


class URLRequest:

    def __init__(self, url, *args) -> None:
        self.__urls = [url, *args]
        self.__running = True
        self.__stats = defaultdict(
            lambda: {"success": 0, "error": 0, "last_status": None}
        )

    def ping(self, url):
        consecutive_errors = 0

        while self.__running:
            try:
                response = urllib.request.urlopen(url, timeout=10)
                status = response.getcode()

                print(
                    f"✅ {url} [{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Status: {status}"
                )

                self.__stats[url]["success"] += 1
                self.__stats[url]["last_status"] = status
                consecutive_errors = 0

            except urllib.error.URLError as e:
                self.__stats[url]["error"] += 1
                consecutive_errors += 1

                print(
                    f"❌ {url} [{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Erro: {e.reason}"
                )

                if consecutive_errors > 3:
                    print(
                        f"⚠️ {url} - Muitos erros consecutivos, aguardando mais tempo..."
                    )
                    time.sleep(30)
                    continue

            except Exception as e:
                self.__stats[url]["error"] += 1
                print(
                    f"❌ {url} [{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Erro inesperado: {str(e)}"
                )

            if self.__running:
                wait_time = random.randint(5, 40)
                for _ in range(wait_time):
                    if not self.__running:
                        break
                    time.sleep(1)

    def start(self):
        upper_limit = min(10, len(self.__urls))

        print(f"\n🚀 Iniciando monitoramento de {len(self.__urls)} URLs")
        print(f"🔧 Usando {upper_limit} threads")
        print("⏰ Intervalo aleatório entre 5-40 segundos")
        print("⚠️  Pressione Ctrl+C para parar\n")

        with ThreadPoolExecutor(max_workers=upper_limit) as executor:
            executor.map(self.ping, self.__urls)

    def stop(self):
        print("\n🛑 Parando todas as threads...")
        self.__running = False
        self.show_stats()

    def show_stats(self):
        print("\n" + "=" * 60)
        print("📊 ESTATÍSTICAS FINAIS")
        print("=" * 60)
        for url in self.__urls:
            stats = self.__stats[url]
            total = stats["success"] + stats["error"]
            if total > 0:
                success_rate = (stats["success"] / total) * 100
                print(f"\n🌐 {url}")
                print(f"   ✅ Sucessos: {stats['success']}")
                print(f"   ❌ Erros: {stats['error']}")
                print(f"   📊 Taxa de sucesso: {success_rate:.1f}%")
                if stats["last_status"]:
                    print(f"   🏁 Último status: {stats['last_status']}")
        print("=" * 60)


if __name__ == "__main__":
    args = []

    if "--urls" in sys.argv:
        urls_index = sys.argv.index("--urls")
        args = sys.argv[urls_index + 1 :]

    if args:
        program = URLRequest(args[0], *args[1:])
    else:
        print("Using base config.")
        program = URLRequest(URL, URL2)

    try:
        program.start()
    except KeyboardInterrupt:
        program.stop()
        print("\nQuitting...\n")
