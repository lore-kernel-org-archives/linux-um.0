Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miklos@szeredi.hu>) id 1LoMW4-0005qX-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 18:47:24 +0000
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LoMVr-000065-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 18:47:24 +0000
In-reply-to: <E1LoMQ2-0007bB-By@pomaz-ex.szeredi.hu> (message from Miklos
	Szeredi on Mon, 30 Mar 2009 20:41:10 +0200)
References: <E1LoMQ2-0007bB-By@pomaz-ex.szeredi.hu>
Message-Id: <E1LoMVs-0007dg-D3@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Mar 2009 20:47:12 +0200
Subject: [uml-devel] [patch 2/3] uml: fix link error from prefixing of i386
	syscalls with ptregs_
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
Cc: jdike@addtoit.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@suse.cz>

Fix the following link error:

arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x11c): undefined reference to `ptregs_fork'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x140): undefined reference to `ptregs_execve'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x2cc): undefined reference to `ptregs_iopl'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x2d8): undefined reference to `ptregs_vm86old'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x2f0): undefined reference to `ptregs_sigreturn'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x2f4): undefined reference to `ptregs_clone'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x3ac): undefined reference to `ptregs_vm86'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x3c8): undefined reference to `ptregs_rt_sigreturn'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x3fc): undefined reference to `ptregs_sigaltstack'
arch/um/sys-i386/built-in.o: In function `sys_call_table':
(.rodata+0x40c): undefined reference to `ptregs_vfork'

This was introduced by commit 253f29a4, "x86: pass in pt_regs pointer
for syscalls that need it"

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
---
 arch/um/sys-i386/sys_call_table.S |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6/arch/um/sys-i386/sys_call_table.S
===================================================================
--- linux-2.6.orig/arch/um/sys-i386/sys_call_table.S	2009-03-27 10:57:38.000000000 +0100
+++ linux-2.6/arch/um/sys-i386/sys_call_table.S	2009-03-30 19:53:14.000000000 +0200
@@ -9,6 +9,17 @@
 
 #define old_mmap old_mmap_i386
 
+#define ptregs_fork sys_fork
+#define ptregs_execve sys_execve
+#define ptregs_iopl sys_iopl
+#define ptregs_vm86old sys_vm86old
+#define ptregs_sigreturn sys_sigreturn
+#define ptregs_clone sys_clone
+#define ptregs_vm86 sys_vm86
+#define ptregs_rt_sigreturn sys_rt_sigreturn
+#define ptregs_sigaltstack sys_sigaltstack
+#define ptregs_vfork sys_vfork
+
 .section .rodata,"a"
 
 #include "../../x86/kernel/syscall_table_32.S"

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

