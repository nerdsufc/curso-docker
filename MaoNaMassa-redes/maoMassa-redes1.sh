#   Vamos criar um contêiner com serviço mysql, inspecioná-lo e verificar o endereço IP, por fim acessá-lo via endereço de rede.

#   Primeiro vamos baixar a imagem do mariadb (um fork mysql - software livre).
#   Perceba que para ter acesso ao SGBD vamos precisar da senha de root. Vamos ver na informações do mantenedor como ele
#   disponibiliza suporte a usuário e senhas.

#   Observando as informações chegaremos até as entradas de variáveis ambientes. No caso da senha de root seria a entrada abaixo:

    MYSQL_ROOT_PASSWORD

#   OBS => As variáveis de ambiente são valores configuráveis que podem ser acessados pelos processos em execução dentro do contêiner. 
#          Essas variáveis são úteis para fornecer configurações específicas do ambiente, como informações de conexão de banco de dados,
#          chaves de API, configurações de localização, entre outros.


#   Então, para definir a senha de root, usaremos a flag '-e', no 'docker run'.

    docker run --name <NOME_CONTAINER> -d -e MYSQL_ROOT_PASSWORD='SENHA' -p 3306:3306 mariadb:latest

#   Agora vamos usar o 'docker inspect', para inspecionar o container, dessa forma vamos obter informações sobre todos elementos do container
#   entre ele procure a entrada "IPAddress":"VALOR". Copie o endereço, agora acesse o SGBD e crie uma base de dados com seu nome.
#   Use o comando SQL abaixo:

CREATE DATABASE <SEU-NOME>;

#   Verifique as bases de dados;

SHOW SCHEMAS;

#   Você acha que consegueria acessar o SGBD do colega ao lado e criar uma base de dados?
# :D