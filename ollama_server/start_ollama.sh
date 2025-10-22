#!/bin/bash
echo "🚀 Starting Ollama Server..."
echo "=================================="

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama not found. Please install it first:"
    echo "curl -fsSL https://ollama.ai/install.sh | sh"
    exit 1
fi

# Check if Ollama is already running
if pgrep -f "ollama serve" > /dev/null; then
    echo "✅ Ollama server is already running"
    echo "🔗 Server URL: http://127.0.0.1:11434"
    echo "📋 Status: Active"

    # Show running models
    echo ""
    echo "📦 Available models:"
    ollama list
else
    echo "🔄 Starting Ollama server..."

    # Start Ollama in background
    ollama serve > /dev/null 2>&1 &
    OLLAMA_PID=$!

    # Wait for server to start
    sleep 3

    # Check if server started successfully
    if pgrep -f "ollama serve" > /dev/null; then
        echo "✅ Ollama server started successfully!"
        echo "🔗 Server URL: http://127.0.0.1:11434"
        echo "📋 Process ID: $OLLAMA_PID"

        # Test connection
        echo ""
        echo "🧪 Testing connection..."
        if curl -s http://127.0.0.1:11434/api/tags > /dev/null; then
            echo "✅ Connection test successful"
        else
            echo "⚠️  Connection test failed - server may still be starting"
        fi

        echo ""
        echo "📦 Available models:"
        ollama list

        echo ""
        echo "🎯 Server is ready! You can now:"
        echo "   • Run search agent: python3 ollama_search_agent.py"
        echo "   • Stop server: pkill -f 'ollama serve'"

    else
        echo "❌ Failed to start Ollama server"
        exit 1
    fi
fi

echo ""
echo "📊 Server Information:"
echo "   • Host: 127.0.0.1"
echo "   • Port: 11434"
echo "   • API: http://127.0.0.1:11434/api"