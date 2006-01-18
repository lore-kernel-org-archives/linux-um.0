Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNDF-0000yN-UO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:37 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzNDF-0002Yj-E6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118235510.4626.86544.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 5/8] uml: TT - SYSCALL_DEBUG - fix buglet
	introduced in cleanup
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
Date: Thu, 19 Jan 2006 00:55:12 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Fixes a bug introduced in commit e32dacb9f481fd6decb41adb28e720c923d34f54 -
index is initialized based on syscall before syscall is calculated.

I'm bothering with this mainly because it gives a correct warning when the config
option is enabled, even if the code is for a almost unused debugging option.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/tt/syscall_kern.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/tt/syscall_kern.c b/arch/um/kernel/tt/syscall_kern.c
index 3d29c90..3fda9a0 100644
--- a/arch/um/kernel/tt/syscall_kern.c
+++ b/arch/um/kernel/tt/syscall_kern.c
@@ -23,16 +23,20 @@ void syscall_handler_tt(int sig, struct 
 	int syscall;
 #ifdef CONFIG_SYSCALL_DEBUG
 	int index;
-  	index = record_syscall_start(syscall);
 #endif
 	sc = UPT_SC(&regs->regs);
 	SC_START_SYSCALL(sc);
 
+	syscall = UPT_SYSCALL_NR(&regs->regs);
+
+#ifdef CONFIG_SYSCALL_DEBUG
+	index = record_syscall_start(syscall);
+#endif
+
 	syscall_trace(&regs->regs, 0);
 
 	current->thread.nsyscalls++;
 	nsyscalls++;
-	syscall = UPT_SYSCALL_NR(&regs->regs);
 
 	if((syscall >= NR_syscalls) || (syscall < 0))
 		result = -ENOSYS;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
