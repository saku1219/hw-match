if (document.URL.match( /chats/ )) {
  window.addEventListener('load', function() {
    const messagesArea = document.getElementById('scroll-inner');
    messagesArea.scrollTop = messagesArea.scrollHeight;
  });
};