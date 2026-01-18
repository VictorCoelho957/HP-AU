# HP-AU: High-Performance Parametric Arithmetic Unit

[![Hardware Design](https://img.shields.io/badge/Hardware-Verilog_HDL-blue.svg)](https://github.com/VictorCoelho957/HP-AU)
[![FPGA](https://img.shields.io/badge/FPGA-Cyclone_V-orange.svg)](https://www.intel.com/content/www/us/en/products/details/fpga/cyclone/v.html)

Unidade Aritmética Parametrizada de alto desempenho, desenvolvida para aplicações em sistemas embarcados e controle inteligente (LabSECI/UFMA). O projeto foca em modularidade, otimização de caminho crítico e conformidade com padrões aritméticos industriais.

## 🏗️ Arquitetura do Sistema

A HP-AU utiliza uma abordagem de design hierárquico, permitindo a escalabilidade da largura de dados via parâmetros de Verilog.

### Módulos Implementados:

1. **Routing Unit (Fase 1)**: Multiplexador 4:1 parametrizado responsável pelo roteamento de dados entre os núcleos aritméticos.
2. **Binary Core (Fase 2)**: Unidade de soma e subtração unificada. Utiliza lógica de Complemento de 2 com inversão controlada por portas XOR para otimização de área.
3. **BCD Core (Fase 3 - Em Progresso)**: Somador decimal com algoritmo de correção por salto de base (+6).

## 📈 Resultados de Síntese

Dados obtidos através do Quartus Prime Lite Edition para o dispositivo **Cyclone V (5CGXFC7C7F23C8)**:

| Métrica | Resultado |
| :--- | :--- |
| **Logic Utilization (ALMs)** | 5 / 56,480 (< 1%) |
| **Total Pins** | 22 / 268 (8%) |
| **Data Path** | Combinacional puro (Latência zero) |

## 🧪 Verificação e Simulação

O projeto inclui testbenches exaustivos para cada submódulo, validados via ModelSim.

### Casos de Teste Validados:
- [x] Roteamento de barramento 4-bit sem latches.
- [x] Soma binária com detecção de overflow.
- [x] Subtração via complemento de 2.

```bash
# Para rodar a simulação no ModelSim:
do run_sim.do
