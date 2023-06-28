## Mão na Massa
## Verificar o isolamento de processos entre host e container

# Comando 'top' gerencia processos em tempo real. Vamos ver a gama de processos rodando em um SO.

    top;

# Agora vamos subir um container e verificar o isolamento dos processos.

    docker run -ti ubuntu;

# Uma vez que for dado um terminal interativo do container ao usuário, você pode verificar os processos mais uma vez.

    top;

# Agora vamos destruir o sistema (simulando uma catástrofe), excluindo os binários do sistema;
# Certifique-se que de fato está no container e não no host.

    rm -rf /bin && rm -rf /sbin

# Agora vamos sair do container, dessa forma a docker-engine vai entender que o ciclo de vida chegou ao fim, finalizando o processo.
# Use um dos comandos abaixo:

    Ctrl + D  #Atalho para encerrar o processo
    exit      #Para finalizar o processo do terminal aberto

# Agora suba um container novinho do ubuntu.

        docker run -ti ubuntu;

# :D