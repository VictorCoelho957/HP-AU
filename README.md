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
│   └── fase6_multiplier_wave.png
└── README.md             # Documentação


Ficou excelente e muito profissional, Arquiteto. Esse nível de documentação é o que se espera em um programa de excelência como o **CI Digital**.

Para finalizar o arquivo e deixá-lo pronto para o seu portfólio de Pós-Graduação, adicionei apenas a seção técnica detalhada da **Fase 06** que discutimos, justificando a decisão de engenharia sobre o truncamento.

Aqui está a versão consolidada para você copiar:

```markdown
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
│   └── fase6_multiplier_wave.png
└── README.md             # Documentação

```

## 🚀 Detalhes Técnicos: Fase 06 (Hardware Multiplier)

Nesta fase, a HP-AU foi expandida para suportar multiplicação nativa em hardware.

### ⚖️ Decisões de Design: O Dilema do Truncamento

Diferente da soma, a multiplicação de dois números de  bits resulta em um produto de até  bits. Para manter a coerência com o barramento de saída de 4 bits (`WIDTH`) do projeto:

* **Implementação:** O módulo calcula o produto total de 8 bits para integridade dos dados.
* **Truncamento:** No nível de integração (`hp_au_top`), são entregues apenas os 4 bits menos significativos (LSB).
* **Justificativa:** Esta abordagem mimetiza instruções de multiplicação de arquiteturas reais (como o **RISC-V**), onde o programador gerencia o overflow ou utiliza instruções específicas para capturar a parte alta do resultado.

## ⚡ Como Executar (Simulação)

Este projeto foi validado utilizando **Intel ModelSim** e **Quartus Prime**.

1. Compile os arquivos da pasta `rtl/`.
2. Compile o testbench desejado da pasta `tb/`.
3. Simule a unidade `hp_au_top_tb`.

Exemplo de visualização esperada no console (Fase 6):

```plaintext
=== TESTE INTEGRADO FASE 6: MULTIPLICACAO ===
[OK] Regressao AND funcionando
[OK] MULT INTEGRADO: 3 * 3 = 9 (Slot 8 Ativo)
[OK] MULT TRUNCAMENTO: 4 * 4 = 16 -> Saida 0

```



### 💎 Fase 07: Parametrização Total (IP Core Scalability)

Nesta fase final, a HP-AU deixou de ser um design de largura fixa para se tornar um **IP Core Parametrizável**.

#### 🛠️ Implementação de Hardware
* **Generic Design:** Utilização de `parameter WIDTH` em todos os módulos (`rtl/`).
* **Parameter Propagation:** O módulo de topo (`hp_au_top`) agora atua como um maestro, propagando a largura de barramento para os núcleos aritméticos e lógicos via instâncias nomeadas.
* **Auto-Scaling:** O multiplicador e o somador se auto-ajustam durante a síntese, otimizando o uso de ALMs conforme a necessidade do projeto.

#### ✅ Validação Final (The 8-bit Proof)
Para validar a flexibilidade da arquitetura, realizamos um teste de estresse mudando o parâmetro global para **8 bits**:
* **Cenário:** Multiplicação de $10 \times 10$.
* **Resultado Obtido:** $100$ (`01100100_2`).
* **Conclusão:** O hardware expandiu com sucesso. O truncamento que ocorria em 4 bits foi eliminado automaticamente pela reconfiguração do barramento, provando a robustez do design parametrizado.

| Evidência Final | Arquivo |
| :--- | :--- |
| **Simulação 8-bits** | `docs/fase7/fase7_8bit_scaling_proof.png` |
| **Waveform Parametrizada** | `docs/fase7/fase7_wave_8bit.png` |

## 📚 Referências Bibliográficas

* *Digital Design and Computer Architecture* - Harris & Harris.
* *Materiais do Programa CI Digital (Softex/UEMA)* - Aulas 18, 19, 20 (Somadores) e Aula 12 (Fluxo RTL).
* *Datasheets* e Manuais de Verilog IEEE 1364.

---

*Desenvolvido no contexto da Residência em TIC 41 - CI Digital.*

```


```
