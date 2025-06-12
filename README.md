# UnBeatables-Template-CPP

---

Esse template é útil para iniciar um projeto em CPP utilizando a NAOQI, a importação dela é complicada logo o arquivo CMakeLists automatiza para evitar dor de cabeça.

Para compilar e executar main.cpp basta digitar:

```bash
chmod +x CMakeLists.sh
./CMakeLists.sh
```

---

# Instalador

Para instalar todo o setup de desenvolvimento simplesmente cole esse comando no terminal:

```bash
sudo apt install curl
curl https://raw.githubusercontent.com/lara-unb/UnBeatables-Template-CPP/refs/heads/main/instalador.sh | sh
rm instalador.sh 
```

---

O instalador também cria um atalho chamado **naopy** para executar scripts python no ambiente virtual correto.

> Exemplo de uso:

```bash
naopy main.py
```
> main.py

```python
 -*- coding: utf-8 -*-

from naoqi import ALProxy

NAO_IP = "120.0.0.2"
NAO_PORT = 9559

tts = ALProxy("ALTextToSpeech", NAO_IP, NAO_PORT)

tts.say("Olá UnBeatables")
```
