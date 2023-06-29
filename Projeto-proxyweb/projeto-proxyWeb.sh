#   Agora vamos revisar algumas coisas antes de iniciar nosso projeto

#   Inicialmente vamos criar uma rede para nossos webservers fique isolado do universo exterior.
#   Na sintaxe do comando, usaremos a opção '--subnet' para definir a faixa de rede qual o Docker colocará os containers.

docker network create --subnet=192.168.101.0/24 '<NOME-DA-REDE>'    #   Assim criaremos a bridge

#   Volumes são usados para persistir dados. Uma vez que containers são efêmeros, seus dados 
#   serão perdidos ao fim do ciclo de vida deles.
#   Usaremos o 'docker run', com a 'flag -v' para persistir os dados em volumes.

    docker run ... -v '<NOME-VOLUME>:<DIRETORIO-CONTAINER>' # O resultado será algo similar a isso.

#   Dessa forma os sites que iremos utilizar serão armazenados em volumes gerenciados pelo Docker.

docker run -d --name web1 --net '<REDE-CRIADA>' -v vol-web1:/usr/local/apache2/htdocs/ httpd; # Subimos o web1, na rede que criamos e com  o volume 'vol-web1'
docker run -d --name web2 --net '<REDE-CRIADA>' -v vol-web2:/usr/local/apache2/htdocs/ httpd; # Subimos o web1, na rede que criamos e com  o volume 'vol-web2'

#   Verificando ips atribuidos aos containers.

docker network inspect lb-web;

#   output será algo parecido com isso

"Containers": {
            "49681248a55f12832a97d082d4489157212f746f47c419ea319bb9fbe6faf7f5": {
                "Name": "web1",
                "EndpointID": "6257bd026273cd05a46d5f15558fee74ea26d1af2c38cf85bdc64b60034ff88f",
                "MacAddress": "02:42:c0:a8:65:02", 
                "IPv4Address": "192.168.101.2/24",  # Os meus ficaram assim
                "IPv6Address": ""
},
            "adec8bd31b64ec40c86be2892813ad72aea2b17bbf19e58446269e5877e6078d": {
                "Name": "web2",
                "EndpointID": "94b7ba96938071c5f9ed5f307501d0594b86ea551dc7d7c2853577488af1ff4e",
                "MacAddress": "02:42:c0:a8:65:03",
                "IPv4Address": "192.168.101.3/24",  # Os meus ficaram assim
                "IPv6Address": ""
            }


#   Lembra do 'docker cp', comando usado para enviar/receber arquivos entre host/container? Usaremos eles pra enviar nossos sites aos volumes.

docker cp FRONT_web1/. web1:/usr/local/apache2/htdocs;
docker cp FRONT_web2/. web2:/usr/local/apache2/htdocs;

#   Será que você consegue ver se os diretórios estão nos containers? Tente listar os arquivos interagindo com o comando 'docker exec'.

#   Agora vamos subir nosso balanciados de carga, nosso proxy, usaremos uma imagem da aplicação haproxy.
#   Vamos nomear de 'lb' conectá-lo em nossa rede usando 'docker run --net/--network'. Também faremos uma 'bind mount', 
#   espelhando o arquivo de configuração 'haproxy.cfg' para dentro do diretório '/usr/local/etc/haproxy/'.

docker run -tid --name lb -p 80:80 -v $(pwd)/proxy-config/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro --net '<REDE-CRIADA>' haproxy:1.6

#   Verifique com o 'docker ps'/'docker container ls' se está tudo diretinho. Caso sim, acesse no navegador o endereço: '127.0.0.1'
# :D
