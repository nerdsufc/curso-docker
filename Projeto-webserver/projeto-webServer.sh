# Nesse primeiro projeto nosso objetivo é subir um serviço http.
# Como toda requisição de páginas web é feita usando uma arquitetura cliente/servidor, então teremos
# que prover acesso externo ao nosso container (afinal você interagiu até aqui usando a Docker-CLI) mas ainda
# não fez interações sem esse recurso da arquitetura. Então vamos aprender como fazer!

# Vamos recorrer ao 'docker run --help' e analisar o flag '-p'.

    -p, --publish list:     #Publica a(s) porta(s) do contêiner para o host.

# Usando a flag '-p', abriremos acesso (mapeamento) externo. O mapeamento de portas host:container é um recurso do Docker que
# permite redirecionar as solicitações de um determinado número de porta do host para uma porta específica dentro do contêiner.
# Isso possibilita a exposição de serviços dentro do contêiner para serem acessíveis a partir do host ou da rede externa.

#---

# Bem então aí vai o nosso desafio pra você, amigo leitor. 

## --- SUBA UM SERVIDOR WEB E DISPONIBILIZE UM SITE QUE POSSA SER ACESSADO POR TODOS NA REDE --- ##

    1 - Como servitor de páginas HTTP use a imagem do nginx (https://hub.docker.com/_/nginx);
    2 - Baixe a imagem do nginx:latest;
    3 - Crie um Dockerfile que use a base-image "nginx:latest";
    4 - Ainda no Dockerfile copie o projeto (nosso website) "site" para a pasta onde o nginx disponibiliza os projetos web;
        # DICA => O mantenedor da imagem oficial normalmente colocar intruções de como manipular o serviço;
    5 - Build uma imagem com a tag meu-webserver;
    6 - Suba um container em 'background', usando a flag 'p' mapeando a porta 8080 do host com a 80 do container;
        # DICA => O comando final deve possivelmenter ser algo parecido isso: 'docker run --name <NOME-DO-CONTAINER> -p 80:80 <IMAGEM>'
    7 - Acesse seu navegador e acesse o endereço <SEU-IP:8080> e assim terá acesso ao container e ao serviço de maneira externa.

#OBS => Aproveitando, dá uma olhada no container, usando o 'docker container ls'. Veja que há informações em 'PORTS'.