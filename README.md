# allora-wallet-generator

A script for generating wallets for the Allora blockchain.

## Prerequisites

1. **Install the Allora wallet:**

   ```bash
   curl -sSL https://raw.githubusercontent.com/allora-network/allora-chain/main/install.sh | bash -s -- v0.6.0
   ```

   **Verify the wallet installation:**

   ```bash
   allorad version
   ```

2. **Source your shell configuration file:**

   ```bash
   source ~/.bashrc
   ```

## Installation and Setup

1. **Clone the repository and set permissions:**

   ```bash
   git clone https://github.com/igotstatik/allora-wallet-generator
   cd allora-wallet-generator
   chmod +x generate_wallets.sh
   ```

2. **Configure the password:**

   Open the `generate_wallets.sh` script in a text editor and replace the placeholder password with your desired password.

## Usage

1. **Run the wallet generator script:**

   ```bash
   ./generate_wallets.sh
   ```

   Wait for the script to complete.

2. **Split mnemonic phrases and addresses:**

   Use the `extract.py` script to separate mnemonic phrases and wallet addresses into separate files:

   ```bash
   python3 extract.py
   ```

   **Output:**  
   - `address.txt`: Contains wallet addresses.  
   - `mnemonics.txt`: Contains corresponding mnemonic phrases.

## Notes

- Ensure Python 3 is installed for running the `extract.py` script.
- Keep your mnemonic phrases secure, as they provide access to your wallets.


