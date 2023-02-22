$(document).ready(function(){
    $("#basic-pills-wizard").bootstrapWizard(
    {
        tabClass:"nav nav-pills nav-justified",
        onNext: function (tab, navigation, index) {
            alert(index);
            $("idForm"+index).validate();
            $("idForm"+index).submit();
            alert("done");
        }
    }),
    $("#progrss-wizard").bootstrapWizard({onTabShow:function(a,r,i){r=(i+1)/r.find("li").length*100;$("#progrss-wizard").find(".progress-bar").css({width:r+"%"})}})});var triggerTabList=[].slice.call(document.querySelectorAll(".twitter-bs-wizard-nav .nav-link"));triggerTabList.forEach(function(a){var r=new bootstrap.Tab(a);a.addEventListener("click",function(a){a.preventDefault(),r.show()})});
