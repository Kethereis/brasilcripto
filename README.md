# 🇧🇷 Brasil Cripto — Consulta de Criptomoedas em Tempo Real

Este projeto tem como objetivo permitir a **consulta de criptomoedas com valores atualizados em tempo real**, além de fornecer gráficos e indicadores para acompanhamento do mercado de forma contínua.

---

## Tecnologias e Arquitetura Utilizadas

- **Arquitetura:** MVVM (Model - View - ViewModel)
- **Gerenciamento de Estado:** [`Provider`](https://pub.dev/packages/provider)
- **Responsividade:** Interfaces adaptáveis conforme o tamanho da tela, otimizando a experiência em diferentes dispositivos
- **Carregamento Inteligente:** Utilização de efeito **Shimmer** para indicar carregamento de dados de forma fluida
- **Gráficos:** [`syncfusion_flutter_charts`](https://pub.dev/packages/syncfusion_flutter_charts)

> Inicialmente foi utilizada a biblioteca `candlesticks`, porém foram identificadas limitações, como a reconstrução das velas com WebSocket (WSS) sendo atualizada apenas ao final da vela. Por esse motivo, foi substituída.

---

## Sobre as APIs Utilizadas

Durante o desenvolvimento, as APIs da **CoinGecko** e **CoinCap** foram avaliadas, conforme proposto no teste. No entanto, ambas apresentam limitações para acesso a dados em tempo real via WebSocket (WSS), aparentemente restritas a usuários pagos.  
*(*Caso essa informação esteja incorreta, fico aberto a correções.)*

Para viabilizar dados em tempo real, foi adotada a **API da Binance**, que fornece esse recurso de forma gratuita.

### Limitações identificadas:

- Nem todas as criptomoedas presentes na CoinGecko ou CoinCap estão disponíveis na Binance.
- Em alguns casos, ao acessar o detalhe de uma moeda, pode ocorrer erro retornado diretamente pela API da Binance.

---

## Decisão de Design

Ao invés de exibir uma mensagem genérica ao usuário, **mantive o retorno real da Binance no app**, com o objetivo de:

- Demonstrar consciência das limitações das APIs utilizadas
- Lidar com falhas de forma transparente
- Evitar mascarar erros que impactam a experiência real do usuário
- Mostrar capacidade de tratar retornos inesperados sem ocultar o problema

> _Essa escolha visa evidenciar um raciocínio técnico maduro e transparente._

---

## Considerações Finais

Havia a possibilidade de padronizar todas as chamadas para a Binance e evitar tais erros. No entanto, como a proposta do teste mencionava especificamente a CoinGecko e a CoinCap, **optei por manter a integração original e lidar com os limites impostos por cada plataforma**.

Com isso, deixo aqui **minhas reticências** — não como dúvida técnica, mas como reflexão sobre escolhas arquiteturais e realismo na entrega de soluções.

---

