# HP-AU: High Performance Arithmetic Unit 
### Projeto de Aceleração de Hardware em Verilog

![Status](https://img.shields.io/badge/Status-Phase%206%20Complete-success)
![Language](https://img.shields.io/badge/Language-Verilog%20HDL-blue)
![Platform](https://img.shields.io/badge/Simulation-ModelSim%20%7C%20Quartus-green)
![Context](https://img.shields.io/badge/Program-CI%20Digital%20%28Softex%2FMCTI%29-orange)

## 📌 Sobre o Projeto
A **HP-AU (High Performance Arithmetic Unit)** é uma Unidade Lógica e Aritmética (ALU) projetada em nível RTL (*Register Transfer Level*), focada em explorar diferentes arquiteturas de somadores, multiplicadores e otimização de caminho crítico.

Este projeto serve como **Artefato Prático** para o **Módulo Básico (Fase 1)** do **Programa de Desenvolvimento de Competências em Sistemas Digitais (CI Digital)**, promovido pela Softex/MCTI em parceria com a UEMA.

O objetivo é sair da teoria de portas lógicas e implementar estruturas de hardware que resolvam problemas reais de latência e área em processadores modernos.

## 🎓 Contexto Acadêmico (Pós-Graduação)
Este repositório cobre as competências exigidas nas seguintes disciplinas do programa:
* **SD100:** Introdução à Microeletrônica (Conceitos de VLSI e Transistores).
* **SD112:** Introdução ao Verilog (Modelagem de Hardware).
* **SD122:** Circuitos Digitais I (Lógica Combinacional e Aritmética).
* **SD192:** Trabalho Orientado I (Implementação Prática).

## 🚀 Arquitetura e Evolução (Roadmap)

O projeto foi construído em fases incrementais, onde cada fase resolve uma limitação física ou lógica da anterior:

| Fase | Módulo | Problema Resolvido | Teoria Aplicada |
| :--- | :--- | :--- | :--- |
| **01** | `setup` | Configuração de ambiente e CI/CD. | Fluxo de Design RTL. |
| **02** | `binary_core` | Implementação base de soma/subtração. | Ripple Carry Adder (RCA). |
| **03** | `bcd_core` | Necessidade de operações em base decimal. | Aritmética BCD e Correção +6. |
| **04** | `cla_4bit` | **Gargalo de Performance:** O atraso de propagação do Ripple Carry era $O(N)$. | **Carry Look-Ahead (CLA):** Redução do atraso para tempo constante $O(1)$ usando Geradores/Propagadores ($G, P$). |
| **05** | `barrel_shifter` | **Gargalo de Lógica:** Falta de operações bit-a-bit e deslocamentos lentos. | Multiplexadores, Lógica Booleana e Barrel Shifters Combinacionais. |
| **06** | `hardware_multiplier` | **Gargalo de Cálculo:** Multiplicação por laços (software) é lenta. | Multiplicador de Hardware, Expansão de Arquitetura e Truncamento de Bits. |

## 🛠️ Estrutura do Projeto

```text
HP_AU/
├── rtl/                  # Source Code (Verilog)
│   ├── hp_au_top.v       # Top Level Module (Integração)
│   ├── cla_4bit.v        # Carry Look-Ahead Adder
│   ├── barrel_shifter.v  # Deslocador de Bits
│   ├── hardware_mult.v   # Multiplicador (Fase 6)
│   └── ...
├── tb/                   # Testbenches (Simulação)
│   ├── hp_au_top_tb.v    # Teste de Integração
│   ├── cla_4bit_tb.v     # Teste Unitário CLA
│   └── ...
├── docs/                 # Evidências e Waveforms
│   ├── fase4_cla_proof.png
│   ├── fase5_shifter_wave.png
│   └── ...
└── README.md             # Documentação
