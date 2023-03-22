(function() {
    function DateTime() {
        var month = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        var s = new Date();
        var minute = (s.getMinutes() < 10? '0' : '') + s.getMinutes();
        document.getElementById('time').innerHTML = s.getHours() + ":" + minute;
        document.getElementById('date').innerHTML = s.getDate() + " " + month[s.getMonth()] + " " + s.getFullYear();
        setTimeout(function () {
            DateTime()
        }, 500);
    }
    DateTime();
})();