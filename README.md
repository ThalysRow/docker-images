# Documentação do Projeto Docker

## Introdução

Este projeto demonstra uma aplicação simples em Node.js rodando dentro de um container Docker. Abaixo estão os passos detalhados e comandos para gerenciar containers Docker de forma eficaz.

## Comandos Docker

### 1. Executando um Container com um Nome Personalizado

```sh
docker run --name mynginx nginx
```

### 2. Executando um Container em Modo Desanexado

```sh
docker run -d --name mynginx nginx
```

### 3. Mapeando Portas

```sh
docker run -d -p 8080:80 nginx
```

### 4. Parando, Iniciando e Removendo Containers

- **Listar Containers em Execução:**
  ```sh
  docker ps
  ```
- **Listar Todos os Containers (incluindo parados):**
  ```sh
  docker ps -a
  ```
- **Parar um Container:**
  ```sh
  docker stop mynginx
  ```
- **Iniciar um Container Parado:**
  ```sh
  docker start mynginx
  ```
- **Remover um Container:**
  ```sh
  docker rm mynginx
  ```
- **Remover um Container em Execução (forçado):**
  ```sh
  docker rm -f mynginx
  ```

### 5. Anexar e Desanexar

- **Anexar a um Container em Execução:**
  ```sh
  docker attach mynginx
  ```
- **Desanexar sem Parar (CTRL + P, CTRL + Q):**

### 6. Executando Comandos e Removendo Containers Automaticamente

- **Executar um Comando em um Novo Container:**
  ```sh
  docker run nginx ls -la
  ```
- **Entrar em um Container com Bash:**
  ```sh
  docker run -it nginx bash
  ```
- **Executar um Comando em um Container em Execução:**
  ```sh
  docker exec -it mynginx bash
  ```
- **Remover Automaticamente um Container Após Execução:**
  ```sh
  docker run --rm nginx ls -la
  ```

### 7. Removendo Todos os Containers

- **Remover Todos os Containers Parados:**
  ```sh
  docker rm $(docker ps -a -q)
  ```
- **Remover Todos os Containers (incluindo em execução):**
  ```sh
  docker rm -f $(docker ps -a -q)
  ```

### 8. Publicando Portas

```sh
docker run -d -p 8080:80 nginx
```

### 9. Execução Interativa e Acesso ao Shell

- **Acessar o Shell de um Container em Execução:**
  ```sh
  docker exec -it mynginx bash
  ```

### 10. Gerenciando Volumes

- **Criar um Volume:**
  ```sh
  docker volume create my_volume
  ```
- **Listar Volumes:**
  ```sh
  docker volume ls
  ```
- **Inspecionar um Volume:**
  ```sh
  docker volume inspect my_volume
  ```
- **Remover um Volume:**
  ```sh
  docker volume rm my_volume
  ```
- **Montar Volumes em Containers:**
  ```sh
  docker run -d -p 8081:80 -v my_volume:/usr/share/nginx/html nginx
  ```

### 11. Backup e Restauração de Volumes

- **Backup de um Volume:**
  ```sh
  docker run --rm -v my_volume:/data -v $(pwd):/backup busybox tar czf /backup/backup.tar.gz /data
  ```
- **Restauração de um Volume:**
  ```sh
  docker run --rm -v my_volume:/data -v $(pwd):/backup busybox tar xzf /backup/backup.tar.gz -C /
  ```

### 12. Gerenciamento de Imagens

- **Listar Imagens Locais:**
  ```sh
  docker images
  ```
- **Remover uma Imagem:**
  ```sh
  docker rmi nginx
  ```
- **Inspecionar uma Imagem:**
  ```sh
  docker inspect nginx
  ```

### 13. Trabalhando com Registries

- **Buscar uma Imagem:**
  ```sh
  docker search ubuntu
  ```
- **Fazer Pull de uma Imagem:**
  ```sh
  docker pull nginx
  ```

### 14. Limpeza

- **Remover Imagens Dangling:**
  ```sh
  docker image prune
  ```
- **Remover Todas as Imagens Não Utilizadas:**
  ```sh
  docker image prune -a
  ```

### 15. Docker Hub

- **Enviar uma Imagem para o Docker Hub:**
  ```sh
  docker push username/repository:tag
  ```

## Explicação do Dockerfile

Vamos detalhar cada linha do nosso Dockerfile para entender melhor o que está acontecendo:

- `ARG NODE_VERSION=22.2.0`: Definimos uma variável de build chamada `NODE_VERSION` com o valor `22.2.0`. Isso nos permite alterar a versão do Node.js facilmente.
- `FROM node:${NODE_VERSION}`: Usamos a imagem base do Node.js na versão especificada pela variável `NODE_VERSION`. Isso garante que estamos usando a versão correta do Node.js.
- `RUN apt-get update && apt-get install -y vim && rm -rf /var/lib/apt/lists/*`: Atualizamos a lista de pacotes e instalamos o editor de texto `vim`. Após a instalação, removemos os arquivos de lista de pacotes para economizar espaço.
- `WORKDIR /app`: Definimos o diretório de trabalho dentro do container como `/app`. Todos os comandos subsequentes serão executados a partir deste diretório.
- `COPY package*.json ./`: Copiamos os arquivos `package.json` e `package-lock.json` para o diretório de trabalho no container. Isso é necessário para instalar as dependências do projeto.
- `RUN npm install`: Instalamos as dependências do projeto listadas no `package.json`.
- `COPY . .`: Copiamos todos os arquivos do diretório atual para o diretório de trabalho no container. Isso inclui o código-fonte da aplicação.
- `RUN useradd -m mynode`: Criamos um novo usuário chamado `mynode`. Isso é uma boa prática de segurança para não executar a aplicação como root.
- `USER mynode`: Definimos o usuário `mynode` como o usuário padrão para executar comandos no container.
- `HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 CMD [ "curl", "-f", "http://localhost:3000" ]`: Definimos um health check para o container, verificando a URL `http://localhost:3000` a cada 10 segundos. Isso ajuda a garantir que a aplicação está rodando corretamente.
- `CMD ["node", "index.js"]`: Definimos o comando padrão para iniciar a aplicação Node.js. Quando o container é iniciado, este comando é executado.

## Conclusão

Esta documentação fornece um guia abrangente para gerenciar containers e imagens Docker. Para informações mais detalhadas, consulte a documentação oficial do Docker.
