# C / C++ development

How to write, build, run, debug and test C/C++ CMake projects in this config.

`<leader>` is **Space**. Press `<leader>` and wait to see every group in
which-key; `<leader>sk` searches all keymaps.

## The pieces

| Plugin       | Job                                                                 |
| ------------ | ------------------------------------------------------------------- |
| clangd       | Language server: completion, navigation, live errors, clang-tidy    |
| cmake-tools  | Configure, build, run and debug CMake targets                       |
| overseer     | Runs builds in the background; task list with output and history   |
| Trouble      | Lists of diagnostics, quickfix entries, symbols, references        |
| neotest      | Discovers, runs and debugs tests through CTest                      |
| nvim-dap     | Debugger UI, using codelldb                                         |
| conform      | Formatting (clang-format for C/C++, gersemi for CMake)              |

## Project setup

1. **Open nvim in the project root**, the directory with the top-level
   `CMakeLists.txt`. cmake-tools works from the current directory.
2. **Generate**: `<leader>rg`. You can usually skip this, because building
   generates automatically when needed.
   - Build files go in `build/`. The build type defaults to `Debug`.
   - `compile_commands.json` is symlinked into the project root, which is how
     clangd learns your real compile flags. If clangd can't find headers,
     you probably haven't generated yet.
   - Saving a `CMakeLists.txt` regenerates automatically.
3. **Pick targets**:
   - `<leader>rt` sets the build target.
   - `<leader>rT` sets the launch target (the executable to run or debug).
   - `<leader>ry` sets the build type (Debug, Release, RelWithDebInfo, MinSizeRel).

Projects with `CMakePresets.json` or kits use the commands under
[Less common CMake commands](#less-common-cmake-commands).

## Build

| Key          | Action                                                  |
| ------------ | ------------------------------------------------------- |
| `<leader>rb` | Build the selected target                               |
| `<leader>rB` | Clean, then build                                       |
| `<leader>rf` | Build the target(s) the current file belongs to         |
| `<leader>rc` | Clean                                                   |
| `<leader>rs` | Stop the running build                                  |

Builds run in the background, and a notification says when they finish.
Compiler output is turned into errors and warnings in three places:

- **Inline**: virtual text and signs in the affected files, even files that
  aren't open. These come from the build, so they're labelled `cmake`. This
  sets them apart from clangd's live diagnostics, which can repeat the same
  error on the same line.
- **Quickfix list**: it opens automatically when a build fails.
- **Trouble**: `<leader>lq` shows the quickfix list, and `<leader>ld` shows
  all diagnostics, from clangd and the build.

The build also catches problems clangd can't see: link errors such as
`undefined reference`, and errors in files you haven't opened.

A new build replaces the previous build's diagnostics. Once you've opened a
finished build in the task list, it's cleared 5 minutes later, along with its
diagnostics.

### Moving through errors

| Key                  | Action                                                |
| -------------------- | ----------------------------------------------------- |
| `]q` / `[q`          | Next / previous item (in Trouble if open, else quickfix) |
| `]e` / `[e`          | Next / previous error in the buffer                   |
| `]w` / `[w`          | Next / previous warning                               |
| `]d` / `[d`          | Next / previous diagnostic of any severity            |
| `<leader>cd`         | Show the diagnostic under the cursor in a float       |
| `<leader>ld`         | All diagnostics (Trouble)                             |
| `<leader>lD`         | Diagnostics for this buffer only (Trouble)            |
| `<leader>lq`         | Quickfix list (Trouble)                               |
| `<leader>sd` / `sD`  | Fuzzy-pick diagnostics, all files or this buffer      |
| `<leader>ud`         | Toggle diagnostics on/off                             |

### Task list (overseer)

`<leader>ro` toggles the task list, which holds builds and their full output.
Inside it:

| Key          | Action                                                  |
| ------------ | ------------------------------------------------------- |
| `<CR>`       | Action menu for the task: restart, stop, dispose, ...   |
| `o`          | Open the task's output                                  |
| `<C-v>` / `<C-s>` / `<C-f>` | Open output in a vsplit / split / float  |
| `p`          | Toggle an output preview                                |
| `{` / `}`    | Previous / next task                                    |
| `<C-k>` / `<C-j>` | Scroll the output                                  |
| `dd`         | Dispose (remove) the task                               |
| `q`          | Close the list                                          |
| `?`          | Help                                                    |

`<leader>rO` (`:OverseerRun`) runs other tasks found in the project, such as
make targets, npm scripts or `.vscode/tasks.json`. These show up in the
same list.

## Run

| Key          | Action                                                        |
| ------------ | ------------------------------------------------------------- |
| `<leader>rr` | Build, then run the launch target in a terminal split         |
| `<leader>ra` | Set command-line arguments for the launch target (remembered per target) |
| `<leader>rT` | Choose which executable to run                                |

To stop a running program, use `:CMakeStopRunner` or press `<C-c>` in its
terminal. `<C-;>` leaves terminal mode.

## Debug

`<leader>rd` builds the launch target and starts it under codelldb, with your
launch arguments. If the build type has no debug info, it asks you to pick a
new build type first.

| Key                    | Action                         |
| ---------------------- | ------------------------------ |
| `<F5>` / `<leader>dc`  | Start / continue               |
| `<F9>` / `<leader>dt`  | Toggle breakpoint              |
| `<F8>`                 | Conditional breakpoint         |
| `<F10>` / `<leader>do` | Step over                      |
| `<F11>` / `<leader>di` | Step into                      |
| `<F12>` / `<leader>du` | Step out                       |
| `<F6>`                 | Run to cursor                  |
| `<S-F5>` (`<F17>`)     | Re-run the last debug session  |
| `<F4>`                 | Terminate                      |
| `<leader>dh`           | Inspect the value under the cursor |
| `<leader>ds`           | Scopes (local variables) sidebar |
| `<leader>df`           | Call stack (frames) sidebar    |
| `<leader>dT`           | Threads sidebar                |
| `<leader>de`           | Watch-expressions sidebar      |
| `<leader>dr`           | REPL (in a new tab)            |

`<F5>` without `<leader>rd` also works, but it asks for the path to the
executable, because it doesn't know about CMake.

## Test

Tests run through CTest, so two things must be true:

- **Tests are registered with CMake**, e.g. with `gtest_discover_tests()` or
  `catch_discover_tests()`. Supported frameworks are GoogleTest, Catch2,
  doctest and CppUTest.
- **Test file names end in `_test`** with a `.cpp`, `.cc` or `.cxx` extension,
  e.g. `parser_test.cpp`. Other files aren't treated as test files.

neotest doesn't compile anything, so **build before running tests**
(`<leader>rb`). Otherwise you're testing the previous build.

| Key          | Action                                    |
| ------------ | ----------------------------------------- |
| `<leader>tn` | Run the nearest test                      |
| `<leader>tf` | Run all tests in the file                 |
| `<leader>td` | Debug the nearest test (codelldb)         |
| `<leader>ts` | Toggle the test summary tree              |
| `<leader>to` | Toggle the output panel                   |

Pass/fail shows in the sign column next to each test, and failure output
includes CTest's `--output-on-failure` log.

In the summary tree (`<leader>ts`):

| Key       | Action                      | Key       | Action                     |
| --------- | --------------------------- | --------- | -------------------------- |
| `<CR>`    | Expand / collapse           | `e`       | Expand all                 |
| `r`       | Run                         | `d`       | Debug                      |
| `m`       | Mark                        | `M`       | Clear marks                |
| `R`       | Run marked                  | `D`       | Debug marked               |
| `x`       | Stop                        | `a`       | Attach to running test     |
| `O`       | Full output                 | `s`       | Short output               |
| `o`       | Jump to the test's source   | `J` / `K` | Next / previous failure    |
| `w`       | Watch (re-run on change)    | `?`       | Help                       |

`:CMakeRunTest` runs plain `ctest` in the build directory, with no neotest
integration.

## Writing code

### Navigation

| Key                | Action                                        |
| ------------------ | --------------------------------------------- |
| `gd`               | Go to definition                              |
| `gD`               | Go to declaration                             |
| `gr`               | References                                    |
| `gI`               | Implementations (e.g. overrides of a virtual) |
| `gt`               | Type definition                               |
| `gai` / `gao`      | Incoming / outgoing calls                     |
| `<leader>ch`       | Switch between source and header              |
| `]]` / `[[`        | Next / previous use of the symbol under the cursor |
| `<leader>ss`       | Symbols in this file                          |
| `<leader>sS`       | Symbols in the workspace                      |
| `<leader>ls`       | Symbol outline (Trouble)                      |
| `<leader>ll`       | References/definitions panel (Trouble)        |
| `<C-o>` / `<C-i>`  | Jump back / forward                           |

### Editing and information

| Key                  | Action                                      |
| -------------------- | ------------------------------------------- |
| `K` / `<leader>cK`   | Hover documentation                         |
| `<leader>ck`         | Signature help (also appears while typing)  |
| `<leader>cI`         | Symbol info (clangd)                        |
| `<leader>ca`         | Code actions (quick fixes, clang-tidy fixes) |
| `<leader>cr`         | Rename symbol across the project            |
| `<leader>cf`         | Format the buffer or selection (clang-format) |
| `<leader>uh`         | Toggle inlay hints (parameter names, deduced types) |
| `<C-s>`              | Save                                        |

**Completion** pops up as you type: `<Tab>`/`<S-Tab>` move through items and
snippet fields, and `<CR>` accepts.

clangd runs **clang-tidy** checks inline. Add a `.clang-tidy` file to the
project to choose which checks run. clang-format reads `.clang-format`.

### CMake files

`CMakeLists.txt` and `*.cmake` files get their own language server
(neocmakelsp), with completion, hover and diagnostics, and `<leader>cf`
formats them with gersemi.

## Less common CMake commands

These have no keybind. Type them as commands.

| Command                       | Action                                               |
| ----------------------------- | ---------------------------------------------------- |
| `:CMakeGenerate!`             | Clean, then configure from scratch                   |
| `:CMakeQuickBuild [target]`   | Build a target without changing the selected one     |
| `:CMakeQuickRun [target]`     | Run a target without changing the selected one       |
| `:CMakeQuickDebug [target]`   | Debug a target without changing the selected one     |
| `:CMakeSelectBuildDir`        | Change the build directory                           |
| `:CMakeSelectKit`             | Choose a compiler kit (`cmake-kits.json`)            |
| `:CMakeSelectConfigurePreset` | Choose a configure preset (`CMakePresets.json`)      |
| `:CMakeSelectBuildPreset`     | Choose a build preset                                |
| `:CMakeInstall`               | Install targets                                      |
| `:CMakeOpenCache`             | Open `CMakeCache.txt`                                |
| `:CMakeSettings`              | Edit project settings (build dir, env, options)      |
| `:CMakeTargetSettings`        | Per-target settings (env, working directory, args)   |
| `:CMakeQuickStart`            | Create a new minimal C/C++ project                   |

## Troubleshooting

- **clangd reports missing headers or wrong errors**: generate (`<leader>rg`)
  so `compile_commands.json` exists, then `:LspRestart`.
- **The same error appears twice on a line**: one copy is from clangd and
  one from the last build (`cmake`). Rebuilding refreshes the build's copy.
- **A test isn't detected**: check that the file name ends in `_test.cpp` and
  that CMake registers the test. `ctest -N` in `build/` lists what CTest knows
  about.
- **A test result looks stale**: rebuild first. neotest runs whatever was last
  compiled.
- **You want to see full build output**: open the task list (`<leader>ro`)
  and press `o` on the task.
