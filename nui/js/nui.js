const doc = document
const resourceName = window.GetParentResourceName ? GetParentResourceName () : 'xz-shoplift'

$(function () {
    window.addEventListener('message', function (event) {
        const e = event.data
        if (e.part === "interaction") {
            doc.getElementById("interact").style.display = "block"
        } else if (e.prog === true) {
            doc.getElementById("progbar").style.display = "block"
            const start = new Date();
            const maxTime = e.time
            const timeoutValue = Math.floor(maxTime/100);
            animationUpdate();

            function updateProgress(percentage) {
                $("#progbarinner").css("width", percentage + "%")
            }

            function animationUpdate() {
                const now = new Date();
                const timeDifference = now.getTime() - start.getTime();
                const percentage = Math.round((timeDifference/maxTime)*100);
                if (percentage <= 100) {
                    updateProgress(percentage);
                    setTimeout(animationUpdate, timeoutValue);
                } else {
                    doc.getElementById("progbar").style.display = "none"
                }
            } // this code sucks lol

        } else {
            doc.getElementById("progbar").style.display = "none"
        }
    });
    
    doc.onkeyup = function (data) {
        if (data.which === 27) { // Escape toets
            hideBody();
            return
        }
    };

    $("#circle").click(function() {
        hideBody();
        $.post(`http://${resourceName}/steal`)
    })
});

function hideBody() {
    doc.getElementById("interact").style.display = "none"
    $.post(`http://${resourceName}/close`)
}