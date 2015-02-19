# Exemplo de Webhook Server para Boleto Simples

Esse código é um exemplo de servidor que recebe webhooks do [Boleto Simples](http://boletosimples.com.br).

Ele complementa a [Documentação da API](http://api.boletosimples.com.br/webhooks/) mas pode ser usado para testes e debug enquanto se desenvolve uma integração no [ambiente de Sandbox](http://api.boletosimples.com.br/sandbox/).

## Instalando

    $ git clone https://github.com/BoletoSimples/boletosimples-webhook-test.git

## Rodando

Entre no diretório baixado:

    $ cd boletosimples-webhook-test

Configure na variável de ambiente a Chave Secreta do webhook. Exemplo:

    $ export WEBHOOK_SECRET_KEY=2ef97bc3ec0bb91ba9c61afa301bda735a0fdbf2fbee154c7e738ef39be0211c

Atenção: Substitua o valor `2ef97bc...` pela chave secreta do webhook que você deseja testar.

Para iniciar o servidor rode:

    $ shotgun config.ru

Abra o navegador na página:

    $ http://localhost:9393

Se tudo correr bem, você deve ver essa documentação.

## Usando com ngrok

[ngrok](https://ngrok.com/) é um aplicativo que cria um túnel entre a internet e o seu computador, permitindo que as resquisições do webhook cheguem do servidor online ao seu servidor local.

Após [instalar o ngrok](https://ngrok.com/download), rode:

    $ ngrok 9393

Abra o navegador na página:

    $ http://localhost:4040

Você deve ver o painel do ngrok.

## Configurando o webhook

Configure a URL do webhook com o host fornecido pelo output do ngrok em Forwarding e o path /callbacks/boletosimples.

Exemplo:

`http://boletosimples-webhook-test-rafael.ngrok.com/callbacks/boletosimples`

Atenção: Essa configuração não deve ser feita no ambiente de produção, deve ser feita apenas no ambiente de sandbox para propósito de teste e debug.

Pronto! A partir de agora, você irá receber as notificações dos eventos do Boleto Simples no seu servidor local.

## Licença

Esse código é livre para ser usado dentro dos termos da licença [MIT license](http://www.opensource.org/licenses/mit-license.php).

## Bugs, Issues, Agradecimentos, etc

Comentários são bem-vindos. Envie seu feedback através do [issue tracker do GitHub](http://github.com/BoletoSimples/boletosimples-webhook-test/issues)

## Autor

[**Rafael Lima**](http://github.com/rafaelp) trabalhando no [BoletoSimples](https://boletosimples.com.br)

Blog: [http://rafael.adm.br](http://rafael.adm.br)

Twitter: [http://twitter.com/rafaelp](http://twitter.com/rafaelp)
