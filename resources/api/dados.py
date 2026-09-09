"""Massa de dados única para a API ServeRest.

Não reutilizo usuário fixo porque o ambiente online é compartilhado
e os dados podem ser limpos. Timestamp + sufixo aleatório reduz
colisão entre execuções paralelas.
"""

from datetime import datetime
import random


def gerar_usuario(administrador="false"):
    marca = datetime.now().strftime("%Y%m%d%H%M%S%f")
    sufixo = random.randint(100, 999)
    return {
        "nome": f"Fernanda QA {marca}",
        "email": f"qa.trillia.{marca}{sufixo}@teste.com",
        "password": "Teste@123",
        "administrador": administrador,
    }


def gerar_email_unico():
    usuario = gerar_usuario()
    return usuario["email"]
