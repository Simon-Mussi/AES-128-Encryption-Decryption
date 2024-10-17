# AES-128-Encryption-Decryption

This repository contains an implementation of AES-128 encryption and decryption using Verilog. This project demonstrates the functionality of AES-128, including the key expansion, encryption, and decryption processes. It was developed with assistance from ChatGPT.

## Overview

AES (Advanced Encryption Standard) is a symmetric block cipher standardized by NIST. AES-128 uses a 128-bit key to encrypt and decrypt 128-bit blocks of data. This implementation includes both the encryption and decryption modules, as well as the necessary transformations like SubBytes, ShiftRows, MixColumns, and their inverses.

## Features

- **Complete AES-128 Implementation**: Includes both encryption and decryption modules.
- **Key Expansion**: Generates a series of round keys from the initial 128-bit key.
- **Support for Encryption and Decryption**: Encrypts and decrypts 128-bit data blocks.
- **Testbenches**: Provides testbenches for validating the functionality of individual modules and the full AES process.

## Repository Structure

## Repository Structure
    ```bash
    AES-128-Encryption-Decryption
    │
    ├── AES-128/
    │    ├── aes_128.v                    # Top-level AES-128 encryption module
    │    ├── aes_128_decrypt.v            # Top-level AES-128 decryption module
    │    ├── aes_round_iteration.v        # Handles each round of AES encryption
    │    ├── aes_last_round.v             # Final round of AES encryption (no MixColumns)
    │    ├── aes_decryption_round.v       # Handles each round of AES decryption
    │    ├── aes_decryption_last_round.v  # Final round of AES decryption (no InvMixColumns)
    │    │
    │    ├── keygeneration.v              # Module for generating round keys from the initial key
    │    │
    │    ├── sub_bytes.v                  # SubBytes transformation (uses S-Box)
    │    ├── shift_rows.v                 # ShiftRows transformation for encryption
    │    ├── mix_columns.v                # MixColumns transformation for encryption
    │    ├── sbox.v                       # S-Box used for SubBytes transformation
    │    │
    │    ├── inv_sub_bytes.v              # InvSubBytes transformation (uses Inverse S-Box)
    │    ├── inv_shift_rows.v             # InvShiftRows transformation for decryption
    │    ├── inv_mix_columns.v            # InvMixColumns transformation for decryption
    │    ├── inv_sbox.v                   # Inverse S-Box used for InvSubBytes transformation
    │    │
    │    │
    │    ├── aes_128_TB.v             # Testbench for AES-128 encryption module
    │    ├── aes_128_decrypt_tb.v     # Testbench for AES-128 decryption module
    │    ├── sub_bytes_tb.v           # Testbench for the SubBytes module
    │    ├── inv_sub_bytes_tb.v       # Testbench for the InvSubBytes module
    │    ├── mix_columns_tb.v         # Testbench for the MixColumns module
    │    └── inv_mix_columns_tb.v     # Testbench for the InvMixColumns module
    │
    ├── docs/                        # Documentation and reference materials
    │   └── NIST.FIPS.197-upd1-9.pdf # Official AES specification document by NIST
    │
    └── README.md                    # Project description and instructions
    ```

## Getting Started

### Prerequisites

- Verilog simulator (e.g., Icarus Verilog, ModelSim)
- A basic understanding of AES-128 and Verilog is recommended for modifying or extending the code.

### Running the Simulation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/AES-128-Encryption-Decryption.git
   cd AES-128-Encryption-Decryption

2. **Compile and run the simulation using a Verilog simulator. For example, using Icarus Verilog**
    ```bash
    iverilog -o aes_sim aes_128.v aes_round_iteration.v keygeneration.v sub_bytes.v shift_rows.v mix_columns.v sbox.v
    vvp aes_sim
3. **To test decryption**
    ```bash
    iverilog -o aes_dec_sim aes_128_decrypt.v aes_decryption_round.v keygeneration.v inv_sub_bytes.v inv_shift_rows.v inv_mix_columns.v inv_sbox.v
    vvp aes_dec_sim

## How It Works

### Encryption Flow
- Key Expansion: Generates round keys from the initial 128-bit key.
- Initial Round: XORs the input data with the first round key.
- Rounds (9 rounds): Each round includes SubBytes, ShiftRows, MixColumns, and AddRoundKey.
- Final Round: SubBytes, ShiftRows, and AddRoundKey (without MixColumns).
### Decryption Flow
- Key Expansion: Uses the same round keys in reverse order.
- Initial Round: XORs the input data with the last round key.
- Rounds (9 rounds): Each round includes InvShiftRows, InvSubBytes, AddRoundKey, and InvMixColumns.
- Final Round: InvShiftRows, InvSubBytes, and AddRoundKey (without InvMixColumns).

## References
- NIST FIPS 197 AES Specification

## Acknowledgments
- Developed with guidance from ChatGPT by OpenAI.
- Special thanks to the authors of referenced papers and the open-source community.