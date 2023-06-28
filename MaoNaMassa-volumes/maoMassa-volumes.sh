#   Como trataremos de volumes, e usaremos o 'docker run', vamos analisar a flag '-v'.

-v, --volume list   # Monta um volume / bind mount

#   Agora vamos a sintaxe do nosso comando 'docker run' com o uso da flag '-v': 

    docker run -ti --name <NOME-DO-CONTAINER> -v '<CAMINHO-ABSOLUTO>'/dados:/tmp/ ubuntu bash

#   DICA => Você pode usar o comando 'pwd' para descobrir o caminho até o diretório atual no linux.

    docker run -ti --name <NOME-DO-CONTAINER> -v $(pwd)/dados:/tmp/ ubuntu bash # comando alternativo

#   Observe que o trecho '-v  .../dados:tmp/'. Com baso no separador ':' , na parte esquerda você selecionou a pasta a ser montada,
#   na parte direita você referenciou onde isso será refletido no container.

#   Dentro do container, navegue até o diretório '/tmp'.
#   Vamos criar um arquivo.txt usando comando touch

touch arquivo.txt

#   E então vamos inserir mais informações

echo "Olá, Mundo Cruel!" > /tmp/arquivo.txt

#   Verifique no arquivo se as mudanças ocorreram

cat arquivo.txt # A saída deve ser exatamente o que inserimos.

#   Agora saia e remova o container usado. Bem agora vamos subir 2 outros container, iremos pradonizá-los chamando-os de C1 e C2.
#   Usaremos imagem do debian, rodaremos C1 e C2 em background, e montaremos o mesmo diretório 'dados' para ambos

    docker run -tid --name C1 -v $(pwd)/dados:/tmp/ debian # Subindo C1
    
    docker run -tid --name C2 -v $(pwd)/dados:/tmp/ debian # Subindo C2

#  Agora usando o 'docker exec' verifique se ambos possuem o 'arquivo.txt', montados no diretório '/mnt'.

    docker exec C1 bash -c 'ls /tmp/arquivo.txt && cat /tmp/arquivo.txt'

    docker exec C2 bash -c 'ls /tmp/arquivo.txt && cat /tmp/arquivo.txt'

#  Um pequeno desafio: Entre no container C1 e crie um novo arquivo e escreva algo, no diretório dados. Depois acesse C2 e leia as
#  alterações realizadas.

# :D