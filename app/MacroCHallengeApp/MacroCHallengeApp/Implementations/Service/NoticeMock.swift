//
//  NoticeMock.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 29/10/20.
//

import Foundation


func getNotice(schoolName: String) -> Notice {

    return getNoticeCTI()
}

func getNoticeCTI() -> Notice {
	let topics = [
		"Matemática":[
			"Operações com números inteiros e fracionários",
			"Sistema de medidas usuais",
			"Números racionais relativos",
			"Regra de três simples",
			"Porcentagem",
			"Juros simples",
			"Equação do primeiro grau e sistema simples do primeiro grau",
			"Equação simples do segundo grau",
			"Geometria plana (perímetro e área de polígonos regulares, medidas de ângulos)",
			"Teorema de Pitágoras",
			"Resolução de situação-problema",
			"Propriedades da multiplicação comutativa, associativa e distributiva",
			"Fatoração",
			"Simplificação de expressões algébricas.",
			"Produtos notáveis"],
		"Português":[
			"Interpretação de texto",
			"Sinônimos e antônimos",
			"sinônimos e antônimos",
			"acentuação gráfica",
			"flexão de gênero, número e grau do substantivo e do adjetivo",
			"crase",
			"emprego de pronomes e verbos",
			"emprego de preposições e conjunções",
			"concordância nominal e verbal",
			"predicação verbal",
			"modos verbais e conjugação",
			"acentuação",
			"sintaxe: tipos de sujeito e tipos de predicado",
			"figuras de linguagem",
			"linguagens e variações linguísticas"],
		"Ciências Naturais":[
			"Drogas: categorias, efeitos, problemas sociais e de  saúde decorrentes do uso",
			"métodos contraceptivos humanos",
			"sistema imunológico, antígenos e anticorpos, vacinas e soros",
			"antibióticos",
			"modo de transmissão, profilaxia e sintomas das doenças: AIDS, dengue, doença de Chagas e febre amarela",
			"características básicas dos seres vivos: organização celular, subsistência – obtenção de matéria e energia e reprodução",
			"os reinos dos seres vivos",
			"tipos de ambientes e especificidade como caracterização, localização geográfica, biodiversidade, proteção e conservação dos ecossistemas brasileiros",
			"relações alimentares – produtores, consumidores e decompositores e transferência de energia entre seres vivos",
			"consequências ambientais do desmatamento indiscriminado",
			"importância da reciclagem do papel",
			"visão geral de propriedades dos materiais, como cor, dureza, brilho, temperaturas de fusão e de ebulição, condutividade elétrica, permeabilidade e suas relações com o uso no cotidiano e no sistema produtivo",
			"minerais, rochas e solos – características gerais e importância para a obtenção de materiais como metais, cerâmicas, vidro, cimento e cal",
			"tecnologia da cana – açúcar e álcool",
			"tecnologia do petróleo",
			"processos físicos de separação de misturas",
			"análise dos conceitos de substância simples, substância pura, mistura, fase e componente",
			"poluição do ar, água e do solo: fontes e efeitos sobre a saúde",
			"efeito estufa e aquecimento global",
			"tratamento de água e esgoto",
			"saneamento básico",
			"a coleta e os destinos do lixo: coleta seletiva, lixões, aterros, incineração, reciclagem e reaproveitamento de materiais",
			"o consumo consciente e a importância dos 3Rs (reduzir, reutilizar e reciclar)",
			"materiais como fonte de energia: petróleo, carvão, gás natural e biomassa como recursos energéticos",
			"interpretação das leis ponderais",
			"análise cronológica da evolução atômica",
			"noções de reações químicas",
			"situações simples do cotidiano que envolvam: movimentos dos corpos (cinemática escalar)",
			"densidade",
			"transformações de energia",
			"aplicações das Leis de Newton",
			"eletricidade básica (átomo, corpos condutores e isolantes, eletrizados e neutros, montagem de circuitos elétricos simples)",
			"magnetismo (ímãs e campo magnético)",
			"ondas (classificações)"],
		"Ciências Humanas":["Lugar, paisagem e espaço geográfico",
							 "noções básicas de cartografia e geomorfologia",
							 "paisagens naturais e suas relações biogeográficas (os grandes biomas terrestres)",
							 "aspectos naturais e socioeconômicos do Brasil",
							 "questões ambientais gerais e as relações sociedade-natureza",
							 "aspectos gerais do crescimento, distribuição e movimentos migratórios populacionais",
							 "organização geopolítica do mundo contemporâneo e os conflitos armados regionais",
							 "o cenário econômico mundial no contexto da globalização",
							 "noções gerais dos aspectos geopolíticos no mundo contemporâneo",
							 "a Antiguidade Clássica (Grécia e Roma)",
							 "a Alta Idade Média (os Impérios Cristãos e o Islamismo); a Formação do Feudalismo",
							 "a transição",
							 "feudo-capitalista",
							 "Estados Modernos Absolutistas",
							 "a expansão marítima",
							 "a colonização da América",
							 "o Iluminismo e as Revoluções Burguesas",
							 "a crise do sistema colonial e a América independente",
							 "o Brasil Imperial",
							 "o século XIX: Liberalismo, Nacionalismo, Socialismo e Imperialismo",
							 "o Brasil Republicano: a República Velha, a Era Vargas, o Período Democrático",
							 "a Primeira e a Segunda Guerras Mundiais",
							 "a Guerra Fria",
							 "a Ditadura Militar no Brasil",
							 "a crise do Socialismo Real",
							 "o Neoliberalismo",
							 "Liberalismo econômico"]]

	let numberOfQuestionPerTopic = [
		"Matemática": 15,
		"Português": 15,
		"Ciências Naturais": 15,
		"Ciências Humanas": 5]

	let essay = [
		"Tema":"considera-se se o texto do candidato atende ao tema proposto. A fuga completa ao tema proposto é motivo suficiente para que a redação não seja corrigida em qualquer outro de seus aspectos, recebendo nota 0 (zero) total.",
		"Estrutura":"consideram-se aqui, conjuntamente, os aspectos referentes ao gênero/tipo de texto proposto e à coerência das ideias. A fuga completa ao gênero/tipo de texto é motivo suficiente para que a redação não seja corrigida em qualquer outro de seus aspectos, recebendo nota 0 (zero) total. Avalia-se aqui como o candidato sustenta seu ponto de vista em termos argumentativos e como essa argumentação está organizada, considerando-se a macroestrutura do texto (introdução, desenvolvimento e conclusão). Será considerada aspecto negativo a referência direta à situação imediata de produção textual (ex.: como afirma o autor do primeiro texto/da coletânea/do texto I; como solicitado nesta prova/proposta de redação). Na coerência, será observada, além da pertinência dos argumentos mobilizados para a defesa do ponto de vista, a capacidade do candidato de encadear as ideias de forma lógica e coerente (progressão textual). Serão consideradas aspectos negativos a presença de contradições entre as ideias, a falta de partes da macroestrutura do texto, a falta de desenvolvimento das ideias e a presença de conclusões não decorrentes do que foi previamente exposto.",
		"Expressão":"consideram-se nesse item os aspectos referentes à coesão textual e ao domínio da norma-padrão da língua portuguesa. Na coesão, avalia-se a utilização dos recursos coesivos da língua (anáforas, catáforas, substituições, conjunções etc.), de modo a tornar a relação entre frases e períodos e entre os parágrafos do texto mais clara e precisa. Serão considerados aspectos negativos as quebras entre frases ou parágrafos e o emprego inadequado de recursos coesivos. Na modalidade, serão examinados os aspectos gramaticais, tais como ortografia, acentuação, pontuação, regência, concordância (verbal e nominal) etc., bem como a escolha lexical (precisão vocabular) e o grau de formalidade/informalidade expressa em palavras e expressões."]

	let notice = Notice(topics: topics,
						numberOfQuestionsPerTopic: numberOfQuestionPerTopic,
						essay: essay,
						linkNotice: "https://cti.feb.unesp.br/Home/vestibulinho/vestibulinho-2021.pdf",
						durationTime: "4:30")
	return notice
}

func getNoticeCotuca() -> Notice {
	let topics = [
		"Matemática":[
			"Teoria dos Conjuntos: pertinência, inclusão, reunião, diferença, intersecção, complementar, quantificadores",
			"Números Naturais, Inteiros e Racionais: adição, subtração, multiplicação, divisão, potenciação e radiciação de números inteiros, fracionários e decimais; problemas.",
			"Divisibilidade: múltiplos, divisores, números primos, MDC, MMC",
			"Razões, proporções, regra de três, porcentagens, juros simples",
			"Equações e inequações do 1o Grau \n• Sistemas com duas variáveis \n• Resoluções de problemas",
			"Cálculo algébrico, monômios e polinômios \n• Valores numéricos, adição, subtração, multiplicação, divisão, potenciação \n• Produtos notáveis e fatoração \n• Simplificações de frações algébricas",
			"Números reais \n• Simplificações e operações com radicais e potências \n• Propriedades operatórias e expressões numéricas",
			"Equações do 2o Grau: resolução; discussão sobre o número de raízes; soma e produto de suas raízes; problemas",
			"Geometria \n• Ângulos: classificação, propriedades, operações \n• Triângulos: elementos, propriedades, semelhanças, classificação, congruências, segmentos e pontos notáveis, relações métricas, Teorema de Pitágoras, áreas \n• Classificação, elementos, propriedades, perímetros e áreas de quadriláteros e de polígonos regulares em geral",
			"Circunferência: elementos, comprimento e medida de arcos, ângulo inscrito, ângulo central",
			"Círculo: elementos, setor circular, segmento circular, área do círculo e de suas partes",
			"Sistema métrico decimal: medidas de comprimento, área e volume",
			"Cálculo de capacidade e volume de cilindros e prismas",
			"TrigonometrianoTriânguloRetângulo:seno,cossenoetangente",
			"Estatística: Médias, tabelas, gráficos",
		],
		"Português":[
			"Interpretação de textos verbais e não verbais;",
			"análise linguística",
			"Uso das palavras há/a; mal/mau; mas/mais; por que/por quê/porque/porquê e outros casos especiais de ortografia",
			"Figuras de linguagem",
			"Classes de palavras",
			"Emprego dos tempos e modos verbais",
			"Termos da oração (análise sintática do período simples)",
			"Orações Coordenadas e Subordinadas (análise sintática do período composto)",
			"Concordância nominal e verbal",
			"Pontuação",
			"Acentuação e outras correções ortográficas",
			"Variantes linguísticas e padrão culto da Língua",
			"Características textuais de gêneros literários e jornalísticos",
			"Observação: será exigida a nova ortografia da Língua Portuguesa, conforme o acordo ortográfico em vigor no Brasil desde 2009.",
		],
		"Ciências Naturais":[
			"1. Doenças causadas por: bactérias, vírus, protozoários, vermes",
			"Nutrientes \n• Fontes principais de proteínas, lipídios e carboidratos\n•Doenças causadas pela falta de vitaminas e sais minerais",
			"Características principais dos animais vertebrados e dos invertebrados",
			"Vegetais \n• Características dos vegetais \n• Divisão do Reino Vegetal \n• Os órgãos vegetais e suas funções",
			"Célula: principais organelas e suas funções; noções de divisão celular",
			"Corpo Humano\n• Sistemas digestório, respiratório, circulatório, excretor, locomotor, nervoso e endócrino\n• Sentidos: visão, audição, olfato, gustação e tato",
			"Ecologia: relações entre os seres vivos; teias e cadeias alimentares; poluição",
			"Evolução: Teorias evolucionistas, irradiação e convergência evolutiva, evidências da evolução.",
			"Ar e Água\n• Massas do ar e da água; pressão do ar e da água\n• Relação entre pressão atmosférica e altitude",
			"Movimento\n• Conceito relativo de movimento e repouso\n• Características do movimento uniforme e do movimento uniformemente variado",
			"Força\n• Medida de uma força; diferença entre peso e massa; forças que se opõem ao movimento; resultante de sistemas de forças",
			"Energia: formas de energia; transformação de energia",
			"Ondas: propriedades do som e propriedades da luz",
			"Calor: temperatura e calor; propagação do calor; bons e maus condutores de calor; dilatação térmica; mudanças do estado físico da matéria",
			"Óptica\n• Características da reflexão e da refração\n• Luz, cor e visão",
			"Eletricidade\n• Bons e maus condutores de eletricidade\n• A corrente elétrica\n• Eletricidade estática",
			"Magnetismo: ímãs e suas propriedades; magnetismo terrestre",
			"Matéria\n• Propriedades gerais da matéria\n• Transformações físicas\n• Transformações químicas\n• Estrutura da matéria: o átomo, modelos atômicos, íons\n• Elementos químicos: isótopos, isóbaros, isótonos\n• Distribuição eletrônica em camadas",
			"Substâncias puras e misturas de substâncias\n• Substâncias simples\n• Substâncias compostas\n• Mistura homogênea\n• Mistura heterogênea\n• Processos de separação de misturas",
			"Classificação periódica\n• Critérios de organização da tabelaperiódica\n• Principais famílias e suas características",
			"Ligação química\n• Ligação iônica\n• Ligação covalente\n• Fórmulas de compostos iônicos e de moléculas",
			"Funções químicas • Ácidos\n• Bases\n• Sais\n• Óxidos",
		],
	]

	let numberOfQuestionPerTopic = [
		"Matemática": 12,
		"Português": 12,
		"Ciências Naturais": 12
	]

	let essay = [
		"Tema":"Elaboração de texto do gênero DISSERTAÇÃO ARGUMENTATIVA. Um ou mais textos poderão ser apresentados como leitura de apoio para a elaboração da redação. \nInterpretação de textos verbais e não verbais; análise linguística com aplicação dos seguintes tópicos: \na. Uso das palavras há/a; mal/mau; mas/mais; por que/por quê/porque/porquê e outros casos especiais de ortografia \nb. Figuras de linguagem \nc. Classes de palavras \nd. Emprego dos tempos e modos verbais \ne. Termos da oração (análise sintática do período simples) \nf. Orações Coordenadas e Subordinadas (análise sintática do período composto) \ng. Concordância nominal e verbal \nh. Pontuação \ni. Acentuação e outras correções ortográficas \nj. Variantes linguísticas e padrão culto da Língua \nk. Características textuais de gêneros literários e jornalísticos \nObservação: será exigida a nova ortografia da Língua Portuguesa, conforme o acordo ortográfico em vigor no Brasil desde 2009.",]

	let notice = Notice(topics: topics,
						numberOfQuestionsPerTopic: numberOfQuestionPerTopic,
						essay: essay,
						linkNotice: "https://www.docsity.com/pt/documentos/downloading/?id=5275655",
						durationTime: "4:30")
	return notice
}

func getNoticeCotil() -> Notice {
    let topics = [
        "Matemática":[
            "Números naturais, inteiros, racionais e irracionais",
            "Potenciação, radiciação",
            "Expressões algébricas",
            "Produtos notáveis e fatorações",
            "Porcentagem",
            "Razões e proporções",
            "Equações de 1º e 2º graus",
            "Sistemas de equações de 1º grau",
            "Elementos fundamentais da geometria plana e semelhança de figuras planas",
            "Relações métricas e trigonométricas no triângulo retângulo",
            "Áreas de figuras planas",
            "Noções de estatística"],
        "Português":[
            "Gênero textuais",
            "Acentuação",
            "Ortografia",
            "Estrutura e formação das palavras",
            "Pontuação",
            "Classes de palavras",
            "Período simples e composto: relações de sentido",
            "Concordâncias nominal e verbal",
            "Regências nominal e verbal",
            "Figuras de linguagem",
            "Variações linguísticas"],
        "Ciências Naturais":[
            "Movimento:Conceito de movimento e repouso / Velocidade e aceleração / Características do movimento uniforme variado / movimentode queda livre / Composição de movimentos",
        "Força: Medida de força / Tipos de força / Resultante de sistema de força / Leis de Newton",
        "Energia: Trabalho / Potência / Formas de energia / Fontes de energia / Transformação de energia / Conservação da energia",
        "Hidrostática: Pressão / Pressão atmosférica / Pressão absoluta / Lei de Stevin / Princípio de Pascal / Princípio de Arquimedes",
        "Calor: Temperatura e calor / Propagação do calor / Bons e maus condutores de calor / Dilatação térmica / Equilíbrio térmico / Como funciona a garrafa térmica? / Efeito estufa / Aquecimento global / Aquecedor solar. ",
        "Ondas: Onda em uma corda / Onda na água / Comprimento de onda / Frequência da onda / Velocidade da onda /ropriedades do som / Propagação do som / Ondas eletromagnéticas / Velocidade da Luz / Filtro solar / Forno de microondas / Ondas de rádio e TV",
        "Óptica: Raio de Luz / Princípio de propagação / Meios de propagação / Formação de sombra e de penumbra / Fases da lua / Eclipse solar e lunar / Espelho plano / Espelho esférico / Decomposição da luz branca / Disco de Newton. ",
            "Eletricidade: Carga elétrica / Eletricidade estática / Gerador elétrico / Pilhas e baterias / A corrente elétrica / Potência dos aparelhos elétricos / Consumo de energia elétrica",
        "Magnetismo: Ímãs e suas propriedades / A bússola e o magnetismo terrestre / o eletroímã",
        "Constituição da matéria: O átomo / Prótons, nêutrons e elétrons: massas e cargas elétricas / Íons / Número atômico e Número de massa / Distribuição eletrônica em níveis",
        "Elemento químico: Simbologia e representação / Isótopos / Classificação periódica dos elementos: metais, não metais e gases nobres",
        "Ligações químicas: Substâncias simples e substâncias compostas / Ligação iônica e ligação covalente",
        "Misturas: Processos de separação de misturas homogêneas e heterogêneas",
        "Reações químicas: Equação química / Classificação das reações químicas/ Lei de Lavoisier (conservação das massas) / Funções inorgânicas (ácidos, bases, sais e óxidos)",
        "Corpo Humano: Organização celular / Organização e funcionamento dos aparelhos humanos / Órgãos do sentido / Hereditariedade: reprodução e transmissão de características",
            "Programas de Saúde: Doenças sexualmente transmissíveis: contágio, consequências e prevenção / Nutrição e saúde: tipos de alimentos e alimentação equilibrada / O problema das drogas",
            "Seres vivos: Bactérias, fungos, protozoários, vírus, animais vertebrados e invertebrados e vegetais",
        "Meio Ambiente: Organização do ecossistema / Relações ecológicas entre os seres vivos / Interação homem e meio ambiente: Importância da qualidade da água, tratamento de lixo e esgoto e poluição atmosférica, desmatamento",
        "Ciclos biogeoquímicos: ciclo da água, do oxigênio e do carbono"],
        "História":["Tempo, espaço e formas de registros – origens da humanidade e processos de sedentarização",
                             "A invenção do mundo clássico e o contraponto com outras sociedades – O mundo antigo",
                             "Lógicas de organização política – cidades – estado e passagem ao medievo",
                             "Trabalho e formas de organização social e cultural – servidão e mundo cristão",
                             " O mundo moderno e a conexão entre sociedades africanas, americanas e europeias",
                             "Humanismos, Renascimentos e o Novo Mundo ",
                             "A organização do poder e as dinâmicas do mundo colonial americano – dominação, conflitos e resistências indígenas",
                             "Lógicas comerciais e mercantis da modernidade – escravidão autóctone, africana e emergência do capitalismo",
                             "O mundo contemporâneo: o Antigo Regime em crise – Iuminismo, revoluções e revoltas",
                             "Os processos de independência nas Américas",
                             " O Brasil no século XIX",
                             "Configurações do mundo no século XIX – nacionalismos e imperialismos",
                             "O nascimento da República no Brasil e os processos históricos até a metade do século XX",
                             "Totalitarismos e conflitos mundiais",
                             "Modernização, ditadura civil-militar e redemocratização: o Brasil após 1946",
                             "A história recente – revoluções, pluralidades e confrontos contemporâneos."],
        "Geografia":["Cartografia: Representações da Paisagem e Cartográfica / Escalas / Linguagens dos Mapas / Cartografia e Poder",
                             "Geografia Econômica e Meio Ambiente: Ciclos da natureza e a sociedade / Atividades econômicas e o espaço geográfico / Patrimônio ambiental e a sua conservação / Crise ambiental / Produção e consumo de energia / A produção do espaço geográfico global. ",
                             "Território Brasileiro: Regionalização / Domínios naturais do Brasil / Brasil: população e economia / Redes urbanas e sociais",
                             "Geopolítica: Globalização; A nova “desordem” mundial e o mundo contemporâneo. "]]

    let numberOfQuestionPerTopic = [
        "Matemática": 12,
        "Português": 10,
        "Ciências Naturais": 12,
        "Ciências Humanas": 6]

    let essay = [
        "Produção de Texto":"A redação deve ter no mínimo 10 linhas e no máximo até 20 linhas, totalizando 10 pontos.Produção de textos com menos de 10 linhas será zerada"]

    let notice = Notice(topics: topics,
                        numberOfQuestionsPerTopic: numberOfQuestionPerTopic,
                        essay: essay,
                        linkNotice: "https://www.exame.cotil.unicamp.br/wp-content/uploads/2019/09/manual_exame2020.pdf",
                        durationTime: "3:30")
    return notice
}
