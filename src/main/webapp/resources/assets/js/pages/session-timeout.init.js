$.sessionTimeout({keepAliveUrl:"/pages/starter-page",logoutButton:"Logout",logoutUrl:"/account/logout/",redirUrl:"/pages/authentication/lock-screen",warnAfter:3e3,redirAfter:3e4,countdownMessage:"Redirecting in {timer} seconds."}),$("#session-timeout-dialog [data-dismiss=modal]").attr("data-bs-dismiss","modal"),$("#session-timeout-dialog [data-dismiss=modal]").removeAttr("data-dismiss");