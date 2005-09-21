Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8iI-00049U-Rp	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:58 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI8iH-0001IV-Do
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:59 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921172857.10219.71071.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process
	context
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
Date: Wed, 21 Sep 2005 19:28:57 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Things are breaking horribly with sysrq called in interrupt context. I want to
try to fix it, but probably this is simpler. To tell the truth, sysrq is
normally run in interrupt context, so there shouldn't be any problem.

There's also a warning from the fault handler because it's run in atomic
context (I have a patch for that, only I deferred it). This is why I'm doing
this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
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
-	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
+	{ "sysrq", mconsole_sysrq, MCONSOLE_PROC },
 	{ "help", mconsole_help, MCONSOLE_INTR },
 	{ "cad", mconsole_cad, MCONSOLE_INTR },
 	{ "stop", mconsole_stop, MCONSOLE_PROC },



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
