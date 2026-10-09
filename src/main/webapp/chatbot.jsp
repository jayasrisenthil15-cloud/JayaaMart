<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Floating Chatbot Widget -->
<div id="jayasri-chat-wrapper" style="position: fixed; bottom: 25px; right: 25px; z-index: 99999999; font-family: 'Plus Jakarta Sans', sans-serif;">
    
    <!-- Chat Window Box -->
    <div id="jayasri-chat-box" style="display: none; width: 340px; height: 430px; background: #ffffff; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.25); border: 1px solid #cbd5e1; flex-direction: column; overflow: hidden; margin-bottom: 12px;">
        <!-- Header -->
        <div style="background: #0f766e; color: #ffffff; padding: 14px 16px; font-weight: 700; font-size: 15px; display: flex; justify-content: space-between; align-items: center;">
            <span>🤖 JayasriMart Assistant</span>
            <span onclick="toggleJayasriChat()" style="color: #ccfbf1; cursor: pointer; font-weight: bold; font-size: 18px; padding: 0 4px;">✕</span>
        </div>
        
        <!-- Messages Area -->
        <div id="jayasri-chat-messages" style="flex: 1; padding: 14px; overflow-y: auto; font-size: 13.5px; background: #f8fafc; color: #334155;">
            <div style="margin-bottom: 10px; background: #e2e8f0; color: #0f172a; padding: 10px 12px; border-radius: 8px; line-height: 1.4;">
                Hello! 👋 Ask me about products, pricing, stock availability, shipping, or returns.
            </div>
        </div>
        
        <!-- Input Area -->
        <div style="padding: 10px; border-top: 1px solid #e2e8f0; display: flex; background: #ffffff;">
            <input type="text" id="jayasri-chat-input" placeholder="Ask a question..." style="flex: 1; padding: 10px 12px; border: 1.5px solid #cbd5e1; border-radius: 8px; outline: none; font-size: 13.5px; color: #0f172a;" onkeypress="if(event.key==='Enter') sendJayasriMessage()">
            <button type="button" onclick="sendJayasriMessage()" style="background: #0f766e; color: #ffffff; border: none; padding: 10px 14px; margin-left: 6px; border-radius: 8px; cursor: pointer; font-weight: 600; font-size: 13px;">Send</button>
        </div>
    </div>

    <!-- Toggle Trigger Button -->
    <div id="jayasri-chat-btn" onclick="toggleJayasriChat()" style="background-color: #0f766e; color: #ffffff; border-radius: 50px; padding: 12px 20px; cursor: pointer; box-shadow: 0 4px 15px rgba(0,0,0,0.3); font-weight: 600; font-size: 14px; display: flex; align-items: center; gap: 8px; user-select: none;">
        <span>💬 JayasriMart AI</span>
    </div>
</div>

<script>
    function toggleJayasriChat() {
        var box = document.getElementById('jayasri-chat-box');
        if (box.style.display === 'none' || box.style.display === '') {
            box.style.display = 'flex';
            document.getElementById('jayasri-chat-input').focus();
        } else {
            box.style.display = 'none';
        }
    }

    async function sendJayasriMessage() {
        var input = document.getElementById('jayasri-chat-input');
        var messages = document.getElementById('jayasri-chat-messages');
        var text = input.value.trim();
        if (!text) return;

        // User Message
        messages.innerHTML += '<div style="margin-bottom: 10px; text-align: right;"><span style="background: #0f766e; color: #ffffff; padding: 9px 12px; border-radius: 8px; display: inline-block; max-width: 82%; text-align: left; word-break: break-word;">' + escapeJayasriHtml(text) + '</span></div>';
        input.value = '';
        messages.scrollTop = messages.scrollHeight;

        // Typing Indicator
        var typingId = 'typing-' + Date.now();
        messages.innerHTML += '<div id="' + typingId + '" style="margin-bottom: 10px;"><span style="background: #e2e8f0; color: #64748b; padding: 8px 12px; border-radius: 8px; display: inline-block; font-style: italic;">Assistant is typing...</span></div>';
        messages.scrollTop = messages.scrollHeight;

        try {
            var ctxPath = "<%= request.getContextPath() %>";
            var response = await fetch(ctxPath + '/api/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message: text })
            });

            var typingElem = document.getElementById(typingId);
            if (typingElem) typingElem.remove();

            var result = await response.json();
            var reply = "Sorry, I couldn't process that right now.";
            if (result && result.success && result.data && result.data.reply) {
                reply = result.data.reply;
            }

            messages.innerHTML += '<div style="margin-bottom: 10px;"><span style="background: #e2e8f0; color: #0f172a; padding: 9px 12px; border-radius: 8px; display: inline-block; max-width: 82%; word-break: break-word; line-height: 1.4;">' + reply + '</span></div>';
        } catch (err) {
            var typingElem = document.getElementById(typingId);
            if (typingElem) typingElem.remove();

            messages.innerHTML += '<div style="margin-bottom: 10px;"><span style="background: #fef2f2; color: #dc2626; padding: 9px 12px; border-radius: 8px; display: inline-block; border: 1px solid #fecaca;">Unable to connect to AI server.</span></div>';
        }
        messages.scrollTop = messages.scrollHeight;
    }

    function escapeJayasriHtml(unsafe) {
        return unsafe.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#039;");
    }
</script>