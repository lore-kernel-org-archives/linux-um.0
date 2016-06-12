Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bCBbV-0007Y9-QE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:03:29 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bCBbV-0004uZ-49 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:03:29 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 12 Jun 2016 22:03:16 +0200
Message-Id: <1465761796-26950-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH] uml: Fix possible deadlock in
	sig_handler_common()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, aivanov@brocade.com, thomas@m3y3r.de

We are in atomic context and must not sleep.
Sleeping here is possible since malloc() maps
to kmalloc() with GFP_KERNEL.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 8acaf4e..a86d7cc 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -15,6 +15,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <sysdep/mcontext.h>
+#include <um_malloc.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
@@ -32,7 +33,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	struct uml_pt_regs *r;
 	int save_errno = errno;
 
-	r = malloc(sizeof(struct uml_pt_regs));
+	r = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
 	if (!r)
 		panic("out of memory");
 
@@ -91,7 +92,7 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 {
 	struct uml_pt_regs *regs;
 
-	regs = malloc(sizeof(struct uml_pt_regs));
+	regs = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
 	if (!regs)
 		panic("out of memory");
 
-- 
2.7.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

