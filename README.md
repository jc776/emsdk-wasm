# Emscripten SDK w/ LLVM WebAssembly

- `--enable-wasm` for the new LLVM WebAssembly backend. (instead of converting asm.js to WebAssembly)
- `sdk-incoming-32bit` + "Latest Waterfall" LLVM `wasm-binaries`
- The image isn't minified in any way - for a smaller image, base a [Multistage Build](https://docs.docker.com/engine/userguide/eng-image/multistage-build/) off of this.

```bash
docker run --rm -e EMCC_WASM_BACKEND=1 -v $(pwd):/src jc776/emsdk-wasm emcc -s WASM=1 hello.c -o hello.html
```