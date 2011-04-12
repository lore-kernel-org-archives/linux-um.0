Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard@nod.at>) id 1Q9eIE-00039b-Mg
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2011 14:10:10 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Q9eID-0005cD-0U
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2011 14:10:10 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 Apr 2011 16:09:56 +0200
MIME-Version: 1.0
Message-Id: <201104121609.56901.richard@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] um: this_cpu_cmpxchg16b_emu
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: penberg@kernel.org, cl@linux.com, hpa@zytor.com

Hi,

This patch implements this_cpu_cmpxchg16b_emu() for UML.
As I'm not an amd64 assembly guru I'm not sure whether the assembly part is
correct.
Can someone please review it?

Especially I'm unsure which register have to be saved before each 
call to C functions.

Thanks,
//richard

>>From 202b0efe024d7c0500e7c11f0aa105f7a1fafb9b Mon Sep 17 00:00:00 2001
From: Richard Weinberger <richard@nod.at>
Date: Mon, 11 Apr 2011 19:22:38 +0200
Subject: [PATCH] um: Implement this_cpu_cmpxchg16b_emu()

Commit 8a5ec0ba "Lockless (and preemptless) fastpaths for slub"
makes use of this_cpu_cmpxchg_double() which needs
this_cpu_cmpxchg16b_emu() on x86_64.
User Mode Linux has to serve this function too.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/sys-x86_64/Makefile            |    2 +-
 arch/um/sys-x86_64/cmpxchg16b_emu.S    |   72 ++++++++++++++++++++++++++++++++
 arch/um/sys-x86_64/cmpxchg16b_helper.c |   22 ++++++++++
 3 files changed, 95 insertions(+), 1 deletions(-)
 create mode 100644 arch/um/sys-x86_64/cmpxchg16b_emu.S
 create mode 100644 arch/um/sys-x86_64/cmpxchg16b_helper.c

diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index c1ea9eb..9a66afe 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -6,7 +6,7 @@
 
 obj-y = bug.o bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
 	setjmp.o signal.o stub.o stub_segv.o syscalls.o syscall_table.o \
-	sysrq.o ksyms.o tls.o
+	sysrq.o ksyms.o tls.o cmpxchg16b_emu.o cmpxchg16b_helper.o
 
 subarch-obj-y = lib/csum-partial_64.o lib/memcpy_64.o lib/thunk_64.o \
 		lib/rwsem_64.o
diff --git a/arch/um/sys-x86_64/cmpxchg16b_emu.S b/arch/um/sys-x86_64/cmpxchg16b_emu.S
new file mode 100644
index 0000000..170b6fa
--- /dev/null
+++ b/arch/um/sys-x86_64/cmpxchg16b_emu.S
@@ -0,0 +1,72 @@
+/*
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; version 2
+ *	of the License.
+ *
+ *	Copyright 2011 Richard Weinberger <richard@nod.at>
+ *	Mostly copied from arch/x86/lib/cmpxchg16b_emu.S
+ *
+ */
+#include <linux/linkage.h>
+#include <asm/alternative-asm.h>
+#include <asm/frame.h>
+#include <asm/dwarf2.h>
+
+.text
+
+/*
+ * Inputs:
+ * %rsi : memory location to compare
+ * %rax : low 64 bits of old value
+ * %rdx : high 64 bits of old value
+ * %rbx : low 64 bits of new value
+ * %rcx : high 64 bits of new value
+ * %al  : Operation successful
+ */
+ENTRY(this_cpu_cmpxchg16b_emu)
+CFI_STARTPROC
+
+#
+# Emulate 'cmpxchg16b %gs:(%rsi)' except we return the result in %al not
+# via the ZF.  Caller will access %al to get result.
+#
+# Note that this is only useful for a cpuops operation.  Meaning that we
+# do *not* have a fully atomic operation but just an operation that is
+# *atomic* on a single cpu (as provided by the this_cpu_xx class of
+# macros).
+#
+this_cpu_cmpxchg16b_emu:
+	pushq %rdi
+	pushq %rax
+	pushq %rdx
+	call arch_local_irq_save_asm
+	movq %rax, %rdi
+	popq %rdx
+	popq %rax
+
+	cmpq (%rsi), %rax
+	jne not_same
+	cmpq 8(%rsi), %rdx
+	jne not_same
+
+	movq %rbx, (%rsi)
+	movq %rcx, 8(%rsi)
+
+	mov $1, %al
+	jmp out
+
+ not_same:
+	xor %al,%al
+
+ out:
+	pushq %rax
+	pushq %rdx
+	call arch_local_irq_restore_asm
+	popq %rdx
+	popq %rax
+	popq %rdi
+	ret
+CFI_ENDPROC
+
+ENDPROC(this_cpu_cmpxchg16b_emu)
diff --git a/arch/um/sys-x86_64/cmpxchg16b_helper.c b/arch/um/sys-x86_64/cmpxchg16b_helper.c
new file mode 100644
index 0000000..b7e665c
--- /dev/null
+++ b/arch/um/sys-x86_64/cmpxchg16b_helper.c
@@ -0,0 +1,22 @@
+/*
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; version 2
+ *	of the License.
+ *
+ *	Copyright 2011 Richard Weinberger <richard@nod.at>
+ *
+ */
+
+#include <linux/linkage.h>
+#include <asm/system.h>
+
+asmlinkage unsigned long arch_local_irq_save_asm(void)
+{
+	return arch_local_irq_save();
+}
+
+asmlinkage void arch_local_irq_restore_asm(unsigned long flags)
+{
+	arch_local_irq_restore(flags);
+}
-- 
1.7.4.2


------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

