## Mão na Massa
## Vamos abordar comandos de gestão e consumo, isto é, para imagens e containers

# Vamos nos familiarizar com a manipulação de imagens
# Com o 'docker images', utilizamos ele para listarmos as imagens que nós temos no nosso host.

    docker images

# Perceba que a saída nos trás algumas informações:
Repository:     # repositório;
TAG:            # tag utilizada no repositório;
IMAGE ID:       # o id na nossa imagem;
Created:        # data de quando nós criamos a nossa imagem;
Size:           # tamanho da imagem;



# OBS => As tags no Docker são marcadores opcionais que são atribuídos às imagens de contêiner.
#        Elas fornecem uma maneira de identificar e diferenciar diferentes versões ou variantes de uma mesma imagem.
#        Vamos baixer base images do ubuntu de uma tag diferente daquela que já possuímos.

    docker pull ubuntu:18.04        # baixando explicitamente
    docker run --name ubuntu1 ubuntu:18.04 cat /etc/os-release

    docker run --name ubuntu2 ubuntu:20.04 cat /etc/os-release # baixando no runtime de instância um container

# Verifique suas imagens e confira o campo TAG usando 'docker images'
# Depois verifique seus containers


    docker container ls -a # Esse comando é a nova versão do 'docker ps -a'


# A saído do 'docker container ls -a' muitos campos e informações: 

CONTAINER ID:   # Identificador único do contêiner em execução.
IMAGE:          # Imagem base utilizada para criar o contêiner.
COMMAND:        # Comando ou script executado ao iniciar o contêiner.
CREATED:        # Data e hora de criação do contêiner.
STATUS:         # Estado atual do contêiner (running, exited, paused).
PORTS:          # Mapeamento de portas do contêiner para o host.
NAMES:          # Nome atribuído ao contêiner para identificação.


# Muitas vezes precisamos entrar/sair/parar/reiniciar um container sem que seu processo fundamental seja finalizado.
# Vamos abor isso como exemplo. Todavia é importante conhecer um pouco mais a fundo o 'docker run' e suas opções.
# Bora lá!

    docker run --help

# Veja o significado de algumas opções que já usamos em nosso curso. Lembra deles?

    -t, --tty:              # Aloca um pseudo-TTY (terminal) para o contêiner.
    -i, --interactive:      # Mantém a entrada padrão (STDIN) aberta mesmo se não estiver conectado.

# Agora você entende o motivo pelo qual entra no container após um 'docker run -ti <imagem>'.
# Aproveitando, verifique agora o fará a opção '-d', veja mais uma vez a saída do 'docker run --help'.

    -d, --detach:           # Executa o contêiner em segundo plano (background) e exibe o ID do contêiner.

# De posse dessas informações vamos rodar um container em background, além de solicitar interação e um pseudo-terminal.

    docker run --name ubuntu-background -dti ubuntu  # Perceba que ele retornará o ID, assim que subir o container;

# Observer que dessa vez você não recebeu o terminal para interação direta. Isso ocorre porque ele foi 'startado' em segundo plano.
# Não acredita!? Vejamos

    docker conatiner ls  # Veja se ele está com status 'UP'

# Agora vamos interagir com nosso container. Para isso vamos usar o 'docker exec'.
# OBS => Você sempre pode usar a opção '--help' para obter informações sobre o sintaxe do comando, suas opções, etc.

    docker exec -it <ID-CONTAINER | NOME-CONTAINER> /bin/bash

# Após executar o comando acima, você deve estar de posse do terminal.
# Vamos então fazer uma pequena alteração, vamos instalar um pacote: um editor de texto chamado nano.

    apt-get update && apt-get install nano -y # Dentro do container, vamos atualizar o repositório e instalar o pacote 'nano'.

# Vamos testar o nano.
    
    nano meuArquivo.txt # Escreva algo e use 'Ctrl + O' e depois 'ENTER', para salvar. 'Ctrl + X' para sair.

# Agora vamos digitar 'exit'. Anteriormente isso faria com que o processo fundamental do container fosse interrompido,
# mas lembre-se que usamos a flag '-d' ele deve ficar rodando em backgroud. Então vamos ver...

    docker container ls # Veja os containers em execução
    docker exec <ID-CONTAINER | NOME-CONTAINER> ls                      # Aqui vamos interagir sem conectar ao container
    docker exec <ID-CONTAINER | NOME-CONTAINER> cat meuArquivo.txt      # E também visualizar o conteúdo do nosso arquivo

# Por fim vamos dar um fim nesse cara. usaremos então o 'docker container stop'.

    docker conateiner stop <ID-CONTAINER | NOME-CONTAINER>

# Depois vamos ver se ele ainda vive.

    docker container ls -a      # Perceba que ele não está 'UP', mas sim com status 'Exit'

# Isso significa que algo impediu a continuidade do processo (exerceu sua razão, falha, etc). 
# Dependendo do que seja, podemos deixá-lo 'UP' de novo. Segue.

    docker container start <ID-CONTAINER | NOME-CONTAINER>
    docker container ls -a      # Verifique se ele está 'UP'.

# Bom... Nosso objetivo é finalizar esse container, então... Bora lá.

    docker conateiner stop <ID-CONTAINER | NOME-CONTAINER>
    docker conateiner rm <ID-CONTAINER | NOME-CONTAINER>

# Agora sim! 
# Perceba que além de acumular containers que já não estamos usando, também podemos estar acumulando imagens que não
# estão sendo utilizadas.

    docker image ls # Para listar nossas imagens. Comando análogo ao 'docker images' 

# Vamos usar o 'docker image rm' para remover alguma imagem sem utilidade.

    docker image rm <IMAGE ID | NAME:TAG>  

# Rode o comando e veja se não recebe erros. 
# OBS =>    Caso erro, possívelmente há algum container parado ou em execução que
#           ainda depende dessa imagem. Remova os containers dependentes e depois teste o comando novamente.

#:D