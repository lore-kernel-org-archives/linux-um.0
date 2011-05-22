Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QO9zd-0005tK-Pq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2011 14:50:57 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QO9zd-00032V-0y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2011 14:50:57 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 22 May 2011 16:48:34 +0200
Message-Id: <1306075716-20042-5-git-send-email-richard@nod.at>
In-Reply-To: <1306075716-20042-1-git-send-email-richard@nod.at>
References: <1306075716-20042-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 5/7] um: print info about fatal segfaults
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Print a short info about fatal segfaults like other archs do.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/trap.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 637c650..8c7b882 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -113,6 +113,27 @@ out_of_memory:
 	return 0;
 }
 
+static void show_segv_info(struct uml_pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+	if (!unhandled_signal(tsk, SIGSEGV))
+		return;
+
+	if (!printk_ratelimit())
+		return;
+
+	printk("%s%s[%d]: segfault at %lx ip %p sp %p error %x",
+		task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+		tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
+		(void *)UPT_IP(regs), (void *)UPT_SP(regs),
+		fi->error_code);
+
+	print_vma_addr(KERN_CONT " in ", UPT_IP(regs));
+	printk(KERN_CONT "\n");
+}
+
 static void bad_segv(struct faultinfo fi, unsigned long ip)
 {
 	struct siginfo si;
@@ -141,6 +162,7 @@ void segv_handler(int sig, struct uml_pt_regs *regs)
 	struct faultinfo * fi = UPT_FAULTINFO(regs);
 
 	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
+		show_segv_info(regs);
 		bad_segv(*fi, UPT_IP(regs));
 		return;
 	}
@@ -202,6 +224,8 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		      address, ip);
 	}
 
+	show_segv_info(regs);
+
 	if (err == -EACCES) {
 		si.si_signo = SIGBUS;
 		si.si_errno = 0;
-- 
1.7.4.2


------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

