# Datalog-based vulnerability detection for WebAssembly binaries
### Dependencies
The project use the following dependencies in the form of Docker images:
- Wasmati (https://github.com/wasmati/wasmati): Code Property Graph generator for WebAssembly binaries

- Souffle (https://github.com/souffle-lang/souffle): Datalog engine to execute Datalog programs

- Emscripten (https://github.com/emscripten-core/emscripten): Compilers for C/C++ programs into WebAssembly binaries

### Instruction
- Pull and create Docker images:
```
docker build -f wasmati.Dockerfile -t wasmati .
docker build -f souffle.Dockerfile -t souffle .
docker pull emscripten/emsdk
```

- Execute script to run Datalog program (`sudo` might be needed to run docker):
```
./script.sh
```

### Note
- This script compiles a test case into a WebAssembly binary, generates the CPG from the binary using Wasmati, and executes the program using Soufflé. Each of these three steps use a different Docker container to perform the task.

- This script is created specifically to test on Juliet Test cases (in `/test`). To use on other binaries, modify the first of the three steps in `script.sh`.
