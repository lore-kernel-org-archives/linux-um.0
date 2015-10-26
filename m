Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZqeOH-0000dk-S7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:33 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZqeOG-0004gh-Q6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:33 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 10:48:13 +0100
Message-Id: <1445852897-13102-3-git-send-email-richard@nod.at>
In-Reply-To: <1445852897-13102-1-git-send-email-richard@nod.at>
References: <1445852897-13102-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 3/7] um: Get rid of open coded NR_SYSCALLS
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

We can use __NR_syscall_max.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/skas/syscall.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 64a8fe5..1683b8e 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -10,9 +10,6 @@
 #include <sysdep/syscalls.h>
 #include <os.h>
 
-extern int syscall_table_size;
-#define NR_SYSCALLS (syscall_table_size / sizeof(void *))
-
 void handle_syscall(struct uml_pt_regs *r)
 {
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
@@ -26,9 +23,10 @@ void handle_syscall(struct uml_pt_regs *r)
 
 	syscall = get_syscall(r);
 
-	if ((syscall >= NR_SYSCALLS) || (syscall < 0))
+	if ((syscall > __NR_syscall_max) || syscall < 0)
 		result = -ENOSYS;
-	else result = EXECUTE_SYSCALL(syscall, regs);
+	else
+		result = EXECUTE_SYSCALL(syscall, regs);
 
 out:
 	PT_REGS_SET_SYSCALL_RETURN(regs, result);
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

