Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZOXG4-00088S-0r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 20:31:52 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOXG1-00086h-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 20:31:52 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun,  9 Aug 2015 22:31:37 +0200
Message-Id: <1439152297-13750-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH] um: Fix kernel mode fault condition
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

We have to exclude memory locations <= PAGE_SIZE from
the condition and let the kernel mode fault path catch it.
Otherwise a kernel NULL pointer exception will be reported
as a kernel user space access.

Fixes: d2313084e2c (um: Catch unprotected user memory access)
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 557232f..5610b18 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -220,7 +220,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		show_regs(container_of(regs, struct pt_regs, regs));
 		panic("Segfault with no mm");
 	}
-	else if (!is_user && address < TASK_SIZE) {
+	else if (!is_user && address > PAGE_SIZE && address < TASK_SIZE) {
 		show_regs(container_of(regs, struct pt_regs, regs));
 		panic("Kernel tried to access user memory at addr 0x%lx, ip 0x%lx",
 		       address, ip);
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

