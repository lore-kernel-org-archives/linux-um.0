Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YzAwK-0003bz-3E
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YzAwI-0005q9-S2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 31 May 2015 23:38:21 +0200
Message-Id: <1433108305-9255-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 1/5] um: Catch unprotected user memory access
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

If the kernel tries to access user memory without copy_from_user()
a trap will happen as kernel and userspace run in different processes
on the host side. Currently this special page fault cannot be resolved
and will happen over and over again. As result UML will lockup.
This patch allows the page fault code to detect that situation and
causes a panic() such that the root cause of the unprotected memory
access can be found and fixed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/trap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 8e4daf4..34b633e 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -219,6 +219,11 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		show_regs(container_of(regs, struct pt_regs, regs));
 		panic("Segfault with no mm");
 	}
+	else if (!is_user && address < TASK_SIZE) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel tried to access user memory at addr 0x%lx, ip 0x%lx",
+		       address, ip);
+	}
 
 	if (SEGV_IS_FIXABLE(&fi))
 		err = handle_page_fault(address, ip, is_write, is_user,
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

