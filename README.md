# Emscripten + LLVM WebAssembly Backend

Use Emscripten with the new LLVM WebAssembly backend.

https://github.com/WebAssembly/waterfall

- Installs `wasm-binaries` and `nodejs`
- Adds `emcc`, `emmake`, etc to `PATH`

```bash
sudo docker run --rm -e EMCC_WASM_BACKEND=1 -v $(pwd):/src jc776/emsdk-wasm emcc -s WASM=1 hello.c -o hello.html

# serve this directory - CORS requests
sudo docker run --rm -it -v $(pwd):/var/www:ro -p 8080:8080 trinitronx/python-simplehttpserver
```