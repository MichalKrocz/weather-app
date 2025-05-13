Aplikacja została napisana w języku Go. Zasada działania jest bardzo prosta - użytkownik wybiera kraj i miasto, a na podstawie jego wyboru backend zmienia wartości w URL i pobiera odpowiednie dane z API. Następnie przeformatowane dane są wyświetlane na stronie.


a. Budowanie aplikacji:

docker build -t aplikacja-pogodowa-michal-krocz .

b. Uruchomienie kontenera:

docker run -p 8080:8080 aplikacja-pogodowa-michal-krocz

c. Sprawdzenie logów

docker logs <id kontenera>

d. Rozmiar obrazu

docker images

