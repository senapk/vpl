# Moodle Modificações

## vpl_evaluate.cpp

## javascript

A macro IMPORT_IO é utilizada para carregar a função de input e write.

```js
let _cin_ = require("fs").readFileSync(0).toString().split("\n");let input = () => _cin_.length === 0 ? "" : _cin_.shift();let write = (text, end="\n") => process.stdout.write("" + text + end);
```

## typescript

A macro IMPORT_IO é utilizada para carregar a função de input e write.

```ts
let _cin_: string[] = require("fs").readFileSync(0).toString().split("\n");let input = () : string => _cin_.length === 0 ? "" : _cin_.shift()!;let write = (text: any, end:string="\n")=> process.stdout.write("" + text + end);
```

## cpp

- Habilitado o c++17

## vpl_evaluate.cpp

- suporta testes no formato vpl e no formato tio
- esconde as respostas se o case começa com um _
- esconde entradas e saídas se o case começa com dois _
- mostra o diff vertical indicando qual linha está errada
- mostra na linha errada a renderização dos whitespaces
