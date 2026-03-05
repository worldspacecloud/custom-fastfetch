#!/bin/bash

# 1. הוספת מאגר והתקנת Fastfetch
echo "Installing Fastfetch..."
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo apt update
sudo apt install fastfetch -y

# 2. יצירת תיקיות קונפיגורציה
mkdir -p /root/.config/fastfetch/

# 3. הורדת קובץ הלוגו מה-GitHub שלך
echo "Downloading logo from WorldSpace GitHub..."
curl -s https://raw.githubusercontent.com/worldspacecloud/custom-fastfetch/refs/heads/main/logo.txt -o /root/.config/fastfetch/logo.txt

# 4. יצירת קובץ הקונפיגורציה (JSONC)
echo "Creating Fastfetch configuration..."
cat << 'EOF' > /root/.config/fastfetch/config.jsonc
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "file",
    "source": "/root/.config/fastfetch/logo.txt",
    "width": 4,
    "height": 12,
    "padding": {
      "top": 0,
      "left": 0,
      "right": 0
    }
  },
  "display": {
    "color": "38;5;123",
    "separator": ": "
  },
  "modules": [
    "title",
    "separator",
    "os",
    "host",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "display",
    "terminal",
    "cpu",
    "gpu",
    "memory",
    "colors"
  ]
}
EOF

# 5. ניקוי רווחים מיותרים מהלוגו ליתר ביטחון
sed -i 's/[[:space:]]*$//' /root/.config/fastfetch/logo.txt

# 6. הגדרת הרצה אוטומטית בכניסה לשרת (אם לא קיים כבר)
if ! grep -q "fastfetch" /root/.bashrc; then
    echo "fastfetch" >> /root/.bashrc
fi

echo "Done! Run 'fastfetch' to see your new logo."
