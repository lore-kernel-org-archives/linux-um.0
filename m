Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d3-0004Vh-00 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:33 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d0-0000yN-RP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:32 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183546.4980F310B8@zion>
Subject: [uml-devel] [patch 3/8] uml: Fix SKAS sig-handler reentrancy [before
	2.6.11]
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
Date: Fri, 04 Feb 2005 19:35:46 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This adds code which enables SIGSEGV reception to the SKAS sig_handler_common,
which matches the tt code.

I still need to figure out why the SA_NODEFER flag was backed out in favor of this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/skas/trap_user.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN arch/um/kernel/skas/trap_user.c~uml-no-defer arch/um/kernel/skas/trap_user.c
--- linux-2.6.11/arch/um/kernel/skas/trap_user.c~uml-no-defer	2005-02-04 06:14:11.966064760 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/skas/trap_user.c	2005-02-04 06:14:11.969064304 +0100
@@ -20,6 +20,14 @@ void sig_handler_common_skas(int sig, vo
 	int save_errno = errno;
 	int save_user;
 
+	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 * XXX Figure out why this is better than SA_NODEFER
+	 */
+	if(sig == SIGSEGV)
+		change_sig(SIGSEGV, 1);
+
 	r = &TASK_REGS(get_current())->skas;
 	save_user = r->is_user;
 	r->is_user = 0;
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
