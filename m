Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL49M-0008Hm-EJ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:33:00 -0700
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EL49L-0006Pj-47	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:33:00 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050929193053.14528.77465.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 4/5] uml: revert "run mconsole "sysrq" in process
	context"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 29 Sep 2005 21:30:53 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Revert commit 12ebcd73e40e09f0dfddf89e465cc0541e0ff8b1, i.e. 
[PATCH] uml: run mconsole "sysrq" in process context
on request from Jeff Dike.

a) sysrq may be run when the scheduler is non-functioning

b) the warning I wanted to fix actually came from the fault handler run in
atomic context. But I fixed that not to take the semaphore in a separate patch.

c) the fault handler is run because of a fault, and that fault was unaffected by
this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/mconsole_user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -23,7 +23,7 @@ static struct mconsole_command commands[
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },
 	{ "remove", mconsole_remove, MCONSOLE_PROC },
-	{ "sysrq", mconsole_sysrq, MCONSOLE_PROC },
+	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
 	{ "help", mconsole_help, MCONSOLE_INTR },
 	{ "cad", mconsole_cad, MCONSOLE_INTR },
 	{ "stop", mconsole_stop, MCONSOLE_PROC },



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
