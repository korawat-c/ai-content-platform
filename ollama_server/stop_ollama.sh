#!/bin/bash
echo "🛑 Stopping Ollama Server..."
echo "================================="

# Check if Ollama is running
if pgrep -f "ollama serve" > /dev/null; then
    echo "🔄 Stopping Ollama server..."
    pkill -f "ollama serve"

    # Wait for processes to stop
    sleep 2

    # Verify server stopped
    if pgrep -f "ollama serve" > /dev/null; then
        echo "⚠️  Some Ollama processes may still be running"
        echo "   To force stop: pkill -9 -f 'ollama serve'"
    else
        echo "✅ Ollama server stopped successfully"
    fi
else
    echo "ℹ️  Ollama server is not running"
fi

echo ""
echo "📊 Server Status: Stopped"