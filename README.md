Using Zinc Externally
----------------------

This project is an example of how you can setup an external project
using zinc to target any number of the micros supported by Zinc.  The
actual example used here is one taken from the Zinc examples, but with
this infrastructure in place, you can create whatever you want.

Building the Example
--------------------

The code can be built with cargo.

```
$ cargo build --release --target=thumbv7m-none-eabi
```

This will generate an object file, to turn this into a bin file or hex
file you will need to run objdump on the resultant binary.  E.g.

```
$ objdump -O binary ./target/thumbv7m-none-eabi/release/blink blink.bin
```

Since you are like to need to type this quite frequently, you may want
to create a [Makefile like this one](Makefile) to reduce the number
of commands you need to type.

Creating Your Own Poject Using Zinc
-----------------------------------

### Step 1: Create a new rust project

```
$ rust new --bin --vcs git rust-lpc1768-blink
$ cd rust-lpc1768-blink
```

### Step 2: Set up your Cargo.toml

Add the following to Cargo.toml, replacing the information preset here
with information that makes sense for your MCU, binary, etc.

```toml
[package]
name = "rust-lpc1768-blink"
version = "0.1.0"
authors = ["Paul Osborne <osbpau@gmail.com>"]

[dependencies.zinc]
git = "https://github.com/hackndev/zinc.git"
features = ["mcu_lpc17xx"]

[dependencies.macro_platformtree]
git = "https://github.com/hackndev/zinc.git"
path = "macro_platformtree"

[dependencies.ioreg]
git = "https://github.com/hackndev/zinc.git"
path = "ioreg"

[dependencies.platformtree]
git = "https://github.com/hackndev/zinc.git"
path = "platformtree"

[dependencies.core]
git = "https://github.com/hackndev/rust-libcore"

[[bin]]
name = "blink"
path = "blink.rs"
```

### Step 3: Grab a target specification

Grab a suitable target specification from those available in the root
of the Zinc repository.

### Step 4: Tell rust about your toolchain

This usually requires putting a couple lines like this in your
`.cargo/config` so that Rust knows to use a proper cross-linker for
your target:

```toml
[target.thumbv7em-none-eabi]
linker = "arm-none-eabi-gcc"
ar = "arm-none-eabi-ar"

[target.thumbv7m-none-eabi]
linker = "arm-none-eabi-gcc"
ar = "arm-none-eabi-ar"
```

### Step 4: Automate artifact generation

You can start with the [Makefile from the example](Makefile) and go
from there.

### Step 5: Create!

Write your code using Zinc!
