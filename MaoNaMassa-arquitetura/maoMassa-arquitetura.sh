## Mão na Massa
## Vamos alguns fluxos usando a arquitetura do docker como plano de fundo.

## FLUXO ----------- 'PULL' --------------

# Baixando uma imagem
# Acesse o docker hub e baixe a imagem do ubuntu

    https://hub.docker.com/_/ubuntu # acesse a imagem oficial do ubuntu

    docker pull ubuntu  # baixe a imagem mais recente do ubuntu

# Verifique as imagens locais

    docker images

# -----------------------------------------



## FLUXO ----------- 'RUN' --------------

#   Execute um container ubuntu e veja informações gerais da release

    docker run ubuntu cat /etc/*release*

# ---------------------------------------



## FLUXO ----------- 'BUILD' --------------

# Vamos criar nossa aplicação. Abra um editor e crie seu cód.fonte

    $editor meuPrograma.py

# Vamos usar algo simples e didático. Por exemplo o código abaixo. Depois salve o arquivo.

    # Exemplo de código python
    nameuser = input ('Digite seu nome:')
    print('Nome do usuário é:',nameuser)

# Agora vamos construir nossa imagem. No editor, abra um novo arq. e nomeie de 'dockerfile'. 
# Use o conteúdo abaixo como código para seu dockerfile. Depois salve.

FROM debian                             # layer 1: Aqui usamos uma imagem base;

RUN apt-get update                      # layer 2: Atualizamos a base de dados sobre repositórios e pacotes;

RUN apt-get install python3 -y          # layer 3: Aqui instalamos os binários do python e suas dependências;

COPY ./meuPrograma.py .                 # layer 4: Aqui copiamos nossa aplicação para imagem final

CMD ["python3" , "meuPrograma.py"]      # layer 5: Esse é o comando rodado quando executarem algum container com nosso imagem


# Por fim, vamos nomear nossa imagem(bolo) e construí-la usando nosso passo-a-passo dockerfile(receita do bolo);

docker build -t <NOME-DA-IMAGEM> -f dockerfile .

# Verique em suas imagens, e veja o seu bolo lá, bonitão!

docker images

# Agora vamos consumir(o bolo), ou seja, rodar um container usando a imagem criada.

docker run -ti --name meuContainer <NOME-DA-IMAGEM>

# -----------------------------------------
# :D
