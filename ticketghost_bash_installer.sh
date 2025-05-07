#!/bin/bash
# ========================================
# 👻 TicketGhost Bash Installer (WSL Safe)
# ========================================
INSTALL_DIR="$HOME/scripts"
ZIP_NAME="ticketghost_full_bundle.zip"

# === Step 1: Ensure ~/scripts exists ===
if [ ! -d "$INSTALL_DIR" ]; then
  mkdir -p "$INSTALL_DIR"
  echo "📁 Created $INSTALL_DIR"
else
  echo "📁 $INSTALL_DIR already exists"
fi

# === Step 2: Unzip into ~/scripts ===
if [ ! -f "$ZIP_NAME" ]; then
  echo "❌ Missing $ZIP_NAME in current directory."
  echo "Please place the zip file next to this installer and rerun."
  exit 1
fi

unzip -o "$ZIP_NAME" -d "$INSTALL_DIR"
echo "✅ Extracted bundle to $INSTALL_DIR"

# === Step 3: Prompt for API key and insert it ===
read -p "🔑 Enter your ServiceDesk API Key: " api_key
sed -i "s|API_KEY="your_api_key_here"|API_KEY="$api_key"|g" "$INSTALL_DIR/ticketghost.sh"
echo "✅ API Key applied to ticketghost.sh"

# === Step 4: Make the script executable ===
chmod +x "$INSTALL_DIR/ticketghost.sh"

# === Step 5: (Optional) Offer test run ===
read -p "🚀 Run TicketGhost now? (y/n): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  bash "$INSTALL_DIR/ticketghost.sh"
else
  echo "✅ Setup complete. You can run it anytime with:"
  echo "bash $INSTALL_DIR/ticketghost.sh"
fi
