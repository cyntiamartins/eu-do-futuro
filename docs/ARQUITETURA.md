# Eu do Futuro — Arquitetura e plano técnico

Nome provisório. Slogan: "Crescendo um dia de cada vez".

## O que o MVP faz (versão mínima que já entrega a ideia)

1. **Onboarding** — nome, como quer ser tratada(o) (ela/ele/neutro), diagnóstico da Roda da Vida (8 áreas, nota 0–10).
2. **Meta de 90 ou 100 dias** com **engenharia reversa**: meta → 3 ciclos (Fundação, Construção, Consolidação) com um marco cada → ação semanal → **tarefa mínima diária obrigatória**.
3. **Tela Hoje** — card do **Eu do Futuro** (meta, dias que faltam, marco do ciclo atual, recado da própria pessoa e sinal de urgência), tarefa mínima, check-in (energia e humor), missão do pilar do dia e revisão do fim do dia.
4. **Método de Excelência Diária** — 7 pilares, um por dia da semana, cada um com missão prática, passo a passo, cronômetro (1/5/15/25 min) e registro.
5. **Progresso** — placar de disciplina, sequência, mapa dos 90/100 dias, Roda da Vida em radar, últimas revisões.

## Regra do sinal de urgência (Eu do Futuro)

| Sinal | Quando aparece |
|---|---|
| Verde · No ritmo | Cumprimento ≥ 75% e nenhuma falta ontem |
| Amarelo · Atenção | 1 falta ontem, ou cumprimento < 75%, ou faltam ≤ 15 dias e a tarefa de hoje não foi feita |
| Vermelho · Urgente | 2+ faltas seguidas, ou mais da metade do prazo passou com cumprimento < 50% |

## Regras da IA (Fase 4)

- A IA **não inventa dados** sobre a pessoa. Só usa o que ela digitou e os registros do app.
- A IA **sugere**, a pessoa **decide**: toda sugestão (marcos, tarefas) precisa ser aceita antes de entrar no plano.
- Sem promessas de resultado, sem diagnóstico de saúde. Afirmações motivacionais não são tratadas como ciência.
- Sinais de crise → mensagem de acolhimento + CVV 188 e indicação de profissional.
- A chave da API fica **só no servidor** (Firebase Functions, segredo). Nunca no código do app.

## Estrutura de dados (hoje no aparelho; Fase 3 no Firestore)

```
users/{uid}
  perfil: { nome, tratamento }
  roda: { saude, mente, espirito, familia, relacoes, carreira, dinheiro, lazer }   // 0–10
  rodaHistorico: [ { data, roda } ]
  meta: { area, titulo, porque, dias, inicio, marcos[3], semanal, minima, carta }
  metasAnteriores: [ meta ]
users/{uid}/dias/{AAAA-MM-DD}
  minima: bool
  checkin: { energia: 1–5, humor }
  missoes: { [pilarId]: { texto, hora } }
  revisao: { funcionou, melhorar, nota }
```

## Stack

| Camada | Agora (v1) | Próximas fases |
|---|---|---|
| App | HTML + JavaScript num arquivo (PWA instalável) | Mesmo código |
| Hospedagem | GitHub Pages (grátis) | Firebase Hosting (opcional) |
| Dados | localStorage do aparelho | Firestore (região southamerica-east1) |
| Login | — | Firebase Authentication (Google e e-mail) |
| IA | — | Firebase Functions chamando a API (Claude ou Gemini) |
| Lembretes | — | Firebase Cloud Messaging |
| Play Store | — | Empacotar a PWA como app Android (TWA/Bubblewrap ou Capacitor) |

## Arquivos

- `app.html` — fonte única do app (é o que vira o preview no Claude).
- `build.sh` — gera `index.html` a partir de `app.html` para o GitHub Pages.
- `manifest.webmanifest`, `sw.js`, `icon.svg` — instalação na tela inicial e uso sem internet.
- `firestore.rules` — regras de segurança para a Fase 3.
