# Project Zomboid Dedicated Server (Docker)

Este repositório contém tudo que você precisa para rodar um **Servidor Dedicado** de **Project Zomboid** em um container Docker.

## 🚀 Como usar

1. **Clone o repositório**
```bash
git clone https://github.com/rafaelprimeiro/pzserver.git
cd pzserver
```

2. **Configure variáveis de ambiente**

Crie um arquivo `.env` ou defina as variáveis na hora de rodar o container:

| Variável | Descrição | Exemplo |
|:---------|:----------|:--------|
| `PZ_USER` | Nome de usuário admin do servidor | `admin` |
| `PZ_PASSWORD` | Senha do admin no servidor | `senha1234` |

**⚠️ Atenção:**  
- **Escolha uma senha forte**!  
- **Nunca** deixe o campo `PZ_PASSWORD` vazio.

3. **Construa a imagem**

```bash
docker build -t project-zomboid-server .
```

4. **Suba o container**

```bash
docker run -d \
  --name pz-server \
  -e PZ_USER=admin \
  -e PZ_PASSWORD=senha1234 \
  -p 16261:16261/udp \
  -p 16262:16262/udp \
  -p 8766:8766/udp \
  -p 8767:8767/udp \
  project-zomboid-server
```

> 🚪 As portas expostas são importantes para que jogadores consigam conectar!

### 🛠️ Como liberar as portas no Linux (iptables ou ufw)

#### Se você usa **iptables**

1. **Permitir as portas**:

```bash
sudo iptables -A INPUT -p udp --dport 16261 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 16262 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 8766 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 8767 -j ACCEPT
```

2. **Salvar as regras** (depende da distro):
```bash
sudo iptables-save > /etc/iptables/rules.v4
```

---

#### Se você usa **UFW**

1. **Liberar as portas**:
```bash
sudo ufw allow 16261/udp
sudo ufw allow 16262/udp
sudo ufw allow 8766/udp
sudo ufw allow 8767/udp
```

2. **Ativar o UFW** (se ainda não estiver ativo):
```bash
sudo ufw enable
```

3. **Verificar as regras ativas**:
```bash
sudo ufw status
```

---

## ⚙️ Personalizações

Você pode configurar seu servidor editando os arquivos:

- `game_default/dedicated_server.ini` ➔ Configurações gerais;
- `game_default/dedicated_server_SandboxVars.lua` ➔ Configurações do mundo;
- `game_default/dedicated_server_spawnregions.lua` ➔ Regiões de spawn.

Esses arquivos são copiados durante o build do container.

---

## 📦 Docker Compose

Exemplo de `docker-compose.yml`:

```yaml
version: '3.9'
services:
  zomboid-server:
    image: rafaelprimeiro/pz-server:latest
    ports:
      - "16261:16261/udp"
      - "16262:16262/udp"
      - "8766:8766/udp"
      - "8767:8767/udp"
    volumes:
      - ./Zomboid:/root/Zomboid
    environment:
      - SERVER_NAME=servertest
      - ADMIN_USERNAME=bob
      - ADMIN_PASSWORD=bob123
      - MAX_MEMORY=2g
      - MIN_MEMORY=1g
    restart: unless-stopped
```

Rodar com:
```bash
docker-compose up -d
```

---

## 🛡️ Segurança

- **NUNCA** exponha o servidor sem senha de admin (`PZ_PASSWORD`).
- **Troque a senha regularmente** se for um servidor aberto.
- **Considere** limitar IPs ou usar firewall caso queira um servidor privado.

---

## Gerenciador de server

https://linuxgsm.com/servers/pzserver/

## 📜 Licença

MIT License.
