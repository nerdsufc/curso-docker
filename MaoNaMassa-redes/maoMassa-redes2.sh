#   Continuando nossos estudos sobre o docker object network, vimos que através do host conseguimos alcançar nossos containers, 
#   via recursos de rede suportados pelo Docker. Isso ocorre graças ao 'driver bridge'. Vamos usar o comando 'docker network'
#   para maiores detalhes, informações e gerenciamento. 

    docker network --help   # Vamos começar dando um boa olhada nas possibilidades.

#   Agora vamos listar as para containers gerenciadas pelo docker.

    docker network ls

#   Veja que há ali uma rede de nome 'bridge', com o driver 'bridge'. Quando você não configura nenhuma entrada de rede em seus
#   containers, o Docker vai conectá-los nessa rede por padrão. 
#   O drive 'bridge' permite que os containers tenham conectividade entre eles, via IP, e também com o host. Vamos testar.

#   Vamos subir dois containers do ubuntu, em background. E um container da imagem busybox, também segundo plano.

    docker run --name C1 -tid ubuntu

    docker run --name C2 -tid ubuntu

    docker run --name C3 -tid busybox

#   Agora vamos inpecionar a rede 'rede bridge' (lembra que o Docker joga todo container ali, por padrão).

    docker network inspect bridge   # Com esse comando conseguiremos ver o IP da cada container, atribuido pelo Docker.

#   Na saída, em "Containers", poderemos ver o nome de cada um dele (em "Name"), logo abaixo os IPs (em "IPv4Address").
#   Deixe essas informações de forma fácil, pois vamos precisar delas para nossa prática

#   Agora vamos interagir com o nosso container 'C3', já que ele tem suporte ao utilitário 'ping'. A partir dele tentaremos chegar
#   via protoclo ICMP aos containers C1 e C2. Vamos rodar o comando abaixo

    docker exec -ti C3 sh   # Isso nos dará acesso ao terminal de C3

#   Agora, use o comando 'ping' para chegar em C1 e C2, via IP.

ping -c3 '<IP-CONTAINER>'   # Verifique se os pacotes foram transmitidos.

#   Agora vamos criar uma nova rede e isolar os containers C1 e C2 do container C3. 

    docker network create minha-rede

#   Agora vamos conectar nossos containers a ela.

    docker network connect minha-rede C1

    docker network connect minha-rede C2

    docker run --name C4 -tid --network minha-rede ubuntu # Bônus => Aqui é uma forma de atribuir um container à rede, em tempo de execução.

#   Inpecione a rede minha-rede e veja os novos endereços IP dos containers, lembre-se de copialos pois vamos tertar
#   a conectividade novamente. 

    docker network inspect minha-rede

#   Bem, agora vamos tentar chegar em C1 e C2, através do C3. Entre C3 e rode o comando abaixo:

ping -c3 '<IP-CONTAINER>'

#   Se tudo correr bem, você não conseguirá conectividade entre C3 os demais(:D) pois os containers estão em redes distintas
#   :D