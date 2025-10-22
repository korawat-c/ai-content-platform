#!/bin/bash
echo "🚀 Setting up Ollama for Web Search Agent"
echo "=========================================="

# Check if Ollama is already installed
if command -v ollama &> /dev/null; then
    echo "✅ Ollama is already installed"
    ollama --version
else
    echo "📥 Installing Ollama..."

    # Try installation without sudo first
    if [ -d "$HOME/ollama_bin" ]; then
        echo "Using existing Ollama in ~/ollama_bin"
        export PATH="$HOME/ollama_bin/bin:$PATH"
    else
        echo "⚠️  Please run this command with sudo to install Ollama:"
        echo "curl -fsSL https://ollama.ai/install.sh | sh"
        echo ""
        echo "Or install manually by following instructions at:"
        echo "https://ollama.com/download"
        exit 1
    fi
fi

# Check if Ollama is running
if ! pgrep -f "ollama serve" > /dev/null; then
    echo "🔄 Starting Ollama server..."
    ollama serve &
    sleep 3
else
    echo "✅ Ollama server is already running"
fi

# Check if qwen3:4b model is available
echo "📋 Checking available models..."
if ollama list | grep -q "qwen3:4b"; then
    echo "✅ Model qwen3:4b is already available"
else
    echo "📥 Pulling qwen3:4b model (this may take a few minutes)..."
    ollama pull qwen3:4b
fi

echo ""
echo "✅ Setup complete! You can now run:"
echo "python3 ollama_search_agent.py"