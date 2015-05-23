STRIP=strip
OBJCOPY=objcopy
OBJDUMP=objdump
EXAMPLE_NAME=blink
TARGET=lpc17xx

CARGO_ROOT=.
MCU=lpc17xx

# Output directory
OUT_DIR=$(CARGO_ROOT)/target/$(TARGET)/release
EXAMPLE_DIR=$(OUT_DIR)/examples

BIN_FILE=$(EXAMPLE_DIR)/$(EXAMPLE_NAME).bin
HEX_FILE=$(EXAMPLE_DIR)/$(EXAMPLE_NAME).hex
LST_FILE=$(EXAMPLE_DIR)/$(EXAMPLE_NAME).lst
EXAMPLE_FILE=$(EXAMPLE_DIR)/$(EXAMPLE_NAME)

RUSTC_FLAGS=--target=$(TARGET) --out-dir=$(OUT_DIR) --cfg feature=\"$(MCU)\" -C opt-level=2

.PHONY: build clean listing $(EXAMPLE_FILE)

all: build

build: $(BIN_FILE)

clean:
	cargo clean

listing: $(LST_FILE)

# Target is PHONY so cargo can deal with dependencies
$(EXAMPLE_FILE):
	cd $(CARGO_ROOT)
	cargo build --example $(EXAMPLE_NAME) --release --target=$(TARGET) --verbose

$(BIN_FILE): $(EXAMPLE_FILE)
	$(OBJCOPY) -O binary $< $@

$(LST_FILE): $(EXAMPLE_FILE)
	$(OBJDUMP) -D $< > $@

$(OUT_DIR):
	mkdir -p $@
