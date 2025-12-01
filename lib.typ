#import "@preview/ctheorems:1.1.3": *

// 文本和代码的字体
#let songti = "SimSun"
#let heiti = "SimHei"
#let kaiti = "SimKai"
#let text-font = "Times New Roman"
#let code-font = "DejaVu Sans Mono"

// 设置页面
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  footer: align(center)[#context (counter(page).display("1"))],
)

//默认分割线
#set line(length: 100%, stroke: 0.5pt)


// 设置正文和代码的字体
#set text(font: (text-font, songti), size: 12pt, lang: "zh", region: "cn")
show strong: it => {
show regex("[\p{hani}\s]+"): set text(stroke: 0.02857em)
it
}

#show raw: set text(font: code-font, 8pt)

//设置标题
#set heading(numbering: "1.1 ")
#show heading: set text(size: 16pt, stroke: 0.3pt + black)
#show heading: it => box(width: 100%)[
  #set text(font: (text-font, songti), weight: "bold")  // 改为宋体加粗
  #if it.numbering != none { counter(heading).display() }
  #it.body
  #v(8pt)
]

#show heading.where(
  level: 1,
): it => box(width: 100%)[
  #set text(size: 16pt, weight: "bold")  // 改为16pt加粗
  #set align(center)
  #set heading(numbering: "一、")
  #v(4pt)
  #it
]

#show heading.where(
  level: 2,
): it => box(width: 100%)[
  #set text(size: 16pt, weight: "bold")  // 改为16pt加粗
  #it
]

// 配置公式的编号、间距和字体
#set math.equation(numbering: "(1.1)")
#show math.equation: eq => {
  set block(spacing: 0.65em)
  eq
}
#show math.equation: it => {
  show regex("[\p{hani}\s]+"): set text(font: songti)
  it
}

#show figure: it => [
  #v(4pt)
  #it
  #v(4pt)
]

#show figure.where(
  kind: raw,
): it => {
  set block(width: 100%, breakable: true)
  it
}

// 段落配置
#set par(
  first-line-indent: 2em,
  linebreaks: "optimized",
  justify: true,
)

// 配置列表
#set list(tight: false, indent: 1em, marker: ([•], [◦], [•], [◦]))
#show list: set text(top-edge: "ascender")

#set enum(tight: false, indent: 1em)
#show enum: set text(top-edge: "ascender")


#counter(page).update(0)



#let bib(bibliography-file) = {
  show bibliography: set text(12pt)
  set bibliography(title: "参考文献", style: "gb-7714-2015-numeric")
  bibliography-file
  v(12pt)
}

#let appendix-num = counter("appendix")

#let appendix(title, body) = {
  appendix-num.step()
  table(
    fill: (_, row) => if row == 0 or row == 1 { luma(200) } else { none },
    rows: 3,
    columns: 1fr,
    text[*附录 #context appendix-num.display()：*],
    text[*#title*],
    body
  )
}


// 定理环境

#let envbox = thmbox.with(
  base: none,
  inset: 0pt,
  breakable: true,
  padding: (top: 0em, bottom: 0em),
)

#let definition = envbox(
  "definition",
  "定义",
).with(numbering: "1")

#let lemma = envbox(
  "lemma",
  "引理",
).with(numbering: "1")

#let corollary = envbox(
  "corollary",
  "推论",
).with(numbering: "1")

#let assumption = envbox(
  "assumption",
  "假设",
).with(numbering: "1")

#let conjecture = envbox(
  "conjecture",
  "猜想",
).with(numbering: "1")

#let axiom = envbox(
  "axiom",
  "公理",
).with(numbering: "1")

#let principle = envbox(
  "principle",
  "定律",
).with(numbering: "1")

#let problem = envbox(
  "problem",
  "问题",
).with(numbering: "1")

#let example = envbox(
  "example",
  "例",
).with(numbering: "1")

#let proof = envbox(
  "proof",
  "证明",
).with(numbering: "1")

#let solution = envbox(
  "solution",
  "解",
).with(numbering: "1")
