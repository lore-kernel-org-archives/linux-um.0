Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1cn0Vg-0001nx-Ck
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 10:13:56 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1cn0Vf-0000jJ-5B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 10:13:56 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 12 Mar 2017 11:13:40 +0100
Message-Id: <20170312101340.21681-1-richard@nod.at>
Subject: [uml-devel] [PATCH] um: Fix _print_addr()
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
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Vegard Nossum <vegard.nossum@oracle.com>, stable@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Recent changes to printk() broke UML's stack trace
output. Kill the root of the problem by using a single
printk() statement.

Fixes: 4bcc595ccd80decb ("printk: reinstate KERN_CONT for printing
continuation lines")
Cc: stable@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Richard Weinberger <richard@nod.at>

---
 arch/um/kernel/sysrq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index a76295f7ede9..961be4a51511 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -20,10 +20,8 @@
 
 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-	pr_info(" [<%08lx>]", address);
-	pr_cont(" %s", reliable ? "" : "? ");
-	print_symbol("%s", address);
-	pr_cont("\n");
+	pr_info(" [<%08lx>] %s%pB\n", address, reliable ? "" : "? ",
+		(void *)address);
 }
 
 static const struct stacktrace_ops stackops = {
-- 
2.10.2


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

