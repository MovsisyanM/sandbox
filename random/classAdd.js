function AddClass3(id) {
    AJAX.Post({
        url: _AppRoot + "/Student/StudentClassRegister/",
        data: { courseClassID: id },
        lockAjax: false,
        success: function (response) {
            if (response.HasError) {
                console.log(response.Message);
            } else {
                console.log(response.Message);
                var trs = $(".avClasses tr[classID='" + id + "']").removeClass("odd even").addClass("selected");
                //                            trs.filter(\":even\").addClass(\"even\");
                //                            trs.filter(\":odd\").addClass(\"odd\");
            }
        },
        error: function () {
            console.log("Unable to add " + id + ".Please try later.");
        }
    })
};

bubble = false

function lop() {
    // setInterval(() => {
    //     AddClass3(7184, 818) // linear ode c
    //     AddClass3(7122, 651) // Prob b
    //     AddClass3(6956, 329) // armenian G
    //     AddClass3(7072, 450) // Topics in cinema
    // }, 1000)
    while (bubble) {
        AddClass3(8659) // armenian hist 2 J
        AddClass3(8790) // ML B
        AddClass3(8846) // TSF
        AddClass3(8837) // BI
        AddClass3(8971) // MLOps

    }
    if (!bubble) {
        console.log("Poop")
        AddClass3(8659) // armenian hist 2 J
        AddClass3(8790) // ML B
        AddClass3(8846) // TSF
        AddClass3(8837) // BI
        AddClass3(8971) // MLOps
    }
}

bubble = false
lop()