Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HzDpJ-0006Q4-KT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 08:35:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HzDpG-0000uk-ML
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 08:35:05 -0700
Date: Fri, 15 Jun 2007 11:34:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070615153449.GA7720@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Use generic BUG
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Nick Piggin <npiggin@suse.de>

Get UML to use the generic bug support rather than arch specific one.

If I insert an artificial bug right before loading init, I get this:

 Kernel panic - not syncing: Kernel mode signal 4

 EIP: 0023:[<0819d501>] CPU: 0 Not tainted ESP: 002b:f7fd4fbc EFLAGS: 00000246
    Not tainted
    EAX: 00000000 EBX: 00007870 ECX: 00000013 EDX: 00007870
    ESI: 0000786d EDI: 00000011 EBP: f7fd4fd8 DS: 002b ES: 002b
    08273bec:  [<0806e814>] show_regs+0x104/0x106
    08273c08:  [<08058927>] panic_exit+0x2c/0x4b
    08273c18:  [<08080ee7>] notifier_call_chain+0x32/0x5b
    08273c38:  [<08080fbd>] __atomic_notifier_call_chain+0x30/0x32
    08273c54:  [<08080fee>] atomic_notifier_call_chain+0x2f/0x31
    08273c70:  [<08073b88>] panic+0x75/0x131
    08273c94:  [<080586c7>] relay_signal+0x87/0x95
    08273cb0:  [<0806b9ee>] sig_handler_common_skas+0x9e/0x120
    08273cd8:  [<08067738>] sig_handler+0x28/0x4f
    08273cec:  [<0806792e>] handle_signal+0x53/0x89
    08273d0c:  [<08069f60>] hard_handler+0x18/0x28
    08273d1c:  [<ffffe500>] transitions+0xf7d598b8/0xfffffff0


With this patch in place, this is how it looks:
    
 BUG: failure at init/main.c:779/init_post()!
 Kernel panic - not syncing: BUG!

 EIP: 0023:[<081a65d1>] CPU: 0 Not tainted ESP: 002b:f7f0dfbc EFLAGS: 00000246
    Not tainted
    EAX: 00000000 EBX: 000069db ECX: 00000013 EDX: 000069db
    ESI: 000069d8 EDI: 00000011 EBP: f7f0dfd8 DS: 002b ES: 002b
    098efedc:  [<0806e9a4>] show_regs+0x104/0x106
    098efef8:  [<080589c7>] panic_exit+0x2c/0x4b
    098eff08:  [<080818d7>] notifier_call_chain+0x32/0x5b
    098eff28:  [<080819ad>] __atomic_notifier_call_chain+0x30/0x32
    098eff44:  [<080819de>] atomic_notifier_call_chain+0x2f/0x31
    098eff60:  [<08073f28>] panic+0x75/0x131
    098eff84:  [<080541d5>] init_post+0xcd/0xe8
    098eff9c:  [<08048ad4>] kernel_init+0x8e/0x9a
    098effb4:  [<08066dee>] run_kernel_thread+0x41/0x53
    098effe0:  [<08058e75>] new_thread_handler+0x62/0x8b
    098efffc:  [<a55a5a5a>] 0xa55a5a5a

[ jdike - added BUG_TABLE to linker script ]

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-um/bug.h        |    2 +-
 include/asm-um/common.lds.S |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.21-mm/include/asm-um/bug.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-um/bug.h	2007-06-14 15:28:21.000000000 -0400
+++ linux-2.6.21-mm/include/asm-um/bug.h	2007-06-14 16:10:07.000000000 -0400
@@ -1,6 +1,6 @@
 #ifndef __UM_BUG_H
 #define __UM_BUG_H
 
-#include <asm/arch/bug.h>
+#include <asm-generic/bug.h>
 
 #endif
Index: linux-2.6.21-mm/include/asm-um/common.lds.S
===================================================================
--- linux-2.6.21-mm.orig/include/asm-um/common.lds.S	2007-05-07 10:24:48.000000000 -0400
+++ linux-2.6.21-mm/include/asm-um/common.lds.S	2007-06-15 11:00:48.000000000 -0400
@@ -20,6 +20,8 @@
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
 
+  BUG_TABLE
+
   __uml_setup_start = .;
   .uml.setup.init : { *(.uml.setup.init) }
   __uml_setup_end = .;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
