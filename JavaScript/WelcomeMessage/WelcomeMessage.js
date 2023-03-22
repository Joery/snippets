(function() {
    function WelcomeMessage() {
        var e = new Date();
        if (e.getHours() >= 0 && e.getHours() <= 5) {
        document.getElementById('message').innerHTML="Good night";
        }
        if (e.getHours() >= 6 && e.getHours() <= 11) {
        document.getElementById('message').innerHTML="Good morning";
        }
        if (e.getHours() >= 12 && e.getHours() <= 17) {
        document.getElementById('message').innerHTML="Good afternoon";
        }
        if (e.getHours() >= 18 && e.getHours() <= 23) {
        document.getElementById('message').innerHTML="Good evening";
        }
        setTimeout(function () {
            WelcomeMessage()
        }, 500);
    }
    WelcomeMessage();
})();