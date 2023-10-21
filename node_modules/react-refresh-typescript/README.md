# react-refresh-typescript

This package currently matches the upstream runtime of [`react-refresh@0.13.*`](https://github.com/facebook/react/commit/72b7462fe73ea2f7bc296bc58670baf9677ce8b2).

This package implements the plugin to integrate Fast Refresh into bundlers. Fast Refresh is a feature that lets you edit React components in a running application without losing their state.

This package is primarily aimed at developers of bundler plugins. If you’re working on one, here is [a rough guide](https://github.com/facebook/react/issues/16604#issuecomment-528663101) for Fast Refresh integration using this package.

## Minimal requirement

-   TypeScript 4.0
-   `module` (not `target`) set to `es2015` or later (not work with `CommonJS` currently. If you really need it, please vote in [#3](https://github.com/Jack-Works/react-refresh-transformer/issues/3))

## Example (with ts-loader)

```js
{
    test: /\.tsx?$/,
    loader: 'ts-loader',
    exclude: /node_modules/,
    options: {
        getCustomTransformers: () => ({
            before: [require('react-refresh-typescript')()]
        }),
    }
}
```

## Example (with raw TypeScript transpileModule API)

```js
import refresh from 'react-refresh-typescript';
import ts from 'typescript';
const out = ts.transpileModule('const App = () => <Something />', {
    compilerOptions: {
        target: ts.ScriptTarget.ESNext,
        jsx: ts.JsxEmit.Preserve,
    },
    fileName: 'test.jsx',
    transformers: {before: [refresh(options)]},
}).outputText,
```

## Import from Deno

The entry point is [`src/deno.ts`](https://raw.githubusercontent.com/Jack-Works/react-refresh-transformer/main/typescript/src/deno.ts).

You must have [an import map for deno](https://deno.land/manual/linking_to_external_code/import_maps) that specify `typescript` as a peer dependency.

For example:

```json
{
    "imports": {
        "typescript": "https://esm.sh/typescript"
    }
}
```

### Without import-map

If you don't want to set up an import map, you can import [the core file](https://cdn.jsdelivr.net/npm/react-refresh-typescript@latest/dist-src/core.js) and provide TypeScript via `options.ts`.

## Options

```ts
export type Options = {
    /** @default "$RefreshReg$" */
    refreshReg?: string
    /** @default "$RefreshSig$" */
    refreshSig?: string
    /** @default false */
    emitFullSignatures?: boolean
    /** Provide your own TypeScript instance. */
    ts?: typeof import('typescript')
    /** Provide your own hash function when `emitFullSignatures` is `false` */
    hashSignature?: (signature: string) => string
}
```
