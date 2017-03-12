Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1cmzxP-0000Y2-M2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 09:38:31 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cmzxO-00049J-MT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Mar 2017 09:38:31 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Sun, 12 Mar 2017 10:38:20 +0100
Message-Id: <20170312093820.12044-1-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH] um: use KERN_CONT in stack dump
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
To: Richard Weinberger <richard@nod.at>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Without KERN_CONT, the symbol will appear on a new line, making stack
traces completely unreadable:

    Call Trace:
     [<6008e891>] ?
    printk+0x0/0x94
     [<6001cce6>]
    show_stack+0xfe/0x15b
     [<600666ec>] ?
    dump_stack_print_info+0xe1/0xea
     [<6008e891>] ?
    printk+0x0/0x94
     [<6023e826>] ?
    bust_spinlocks+0x0/0x4f
     [<602343b8>]
    dump_stack+0x2a/0x2c
     [<6008e662>]
    panic+0x170/0x31e
     [<6008e4f2>] ?
    panic+0x0/0x31e

This makes it readable again:

    Call Trace:
     [<6008e891>] ? printk+0x0/0x94
     [<6001cce6>] show_stack+0xfe/0x15b
     [<600666ec>] ? dump_stack_print_info+0xe1/0xea
     [<6008e891>] ? printk+0x0/0x94
     [<6023e826>] ? bust_spinlocks+0x0/0x4f
     [<602343b8>] dump_stack+0x2a/0x2c
     [<6008e662>] panic+0x170/0x31e

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/um/kernel/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index a76295f7ede9..edf1f80123e7 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -22,7 +22,7 @@ static void _print_addr(void *data, unsigned long address, int reliable)
 {
 	pr_info(" [<%08lx>]", address);
 	pr_cont(" %s", reliable ? "" : "? ");
-	print_symbol("%s", address);
+	print_symbol(KERN_CONT "%s", address);
 	pr_cont("\n");
 }
 
-- 
2.12.0.rc0


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

