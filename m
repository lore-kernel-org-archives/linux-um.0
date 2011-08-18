Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7pA-0002XG-9A
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:16 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7p9-000239-Kd
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:00:16 +0000
Date: Thu, 18 Aug 2011 20:00:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7p3-0007Sp-6F@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4574424575924593202=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 07/91] um: use subarch-obj instead of
	copying...
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

--===============4574424575924593202==
Content-Type: application/octet-stream
Content-Transfer-Encoding: 8bit


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-i386/Makefile          |    4 +-
 arch/um/sys-i386/atomic64_cx8_32.S |  225 ------------------------------------
 2 files changed, 2 insertions(+), 227 deletions(-)
 delete mode 100644 arch/um/sys-i386/atomic64_cx8_32.S

diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index 3923cfb..e5e56d7 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -4,11 +4,11 @@
 
 obj-y = bug.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o setjmp.o signal.o stub.o stub_segv.o syscalls.o sysrq.o \
-	sys_call_table.o tls.o atomic64_cx8_32.o mem.o
+	sys_call_table.o tls.o mem.o
 
 obj-$(CONFIG_BINFMT_ELF) += elfcore.o
 
-subarch-obj-y = lib/string_32.o
+subarch-obj-y = lib/string_32.o lib/atomic64_32.o lib/atomic64_cx8_32.o
 subarch-obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += lib/rwsem.o
 subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem_32.o
 subarch-obj-$(CONFIG_MODULES) += kernel/module.o
diff --git a/arch/um/sys-i386/atomic64_cx8_32.S b/arch/um/sys-i386/atomic64_cx8_32.S
deleted file mode 100644
index 1e901d3..0000000
--- a/arch/um/sys-i386/atomic64_cx8_32.S
+++ /dev/null
@@ -1,225 +0,0 @@
-/*
- * atomic64_t for 586+
- *
- * Copied from arch/x86/lib/atomic64_cx8_32.S
- *
- * Copyright �� 2010  Luca Barbieri
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#include <linux/linkage.h>
-#include <asm/alternative-asm.h>
-#include <asm/dwarf2.h>
-
-.macro SAVE reg
-	pushl_cfi %\reg
-	CFI_REL_OFFSET \reg, 0
-.endm
-
-.macro RESTORE reg
-	popl_cfi %\reg
-	CFI_RESTORE \reg
-.endm
-
-.macro read64 reg
-	movl %ebx, %eax
-	movl %ecx, %edx
-/* we need LOCK_PREFIX since otherwise cmpxchg8b always does the write */
-	LOCK_PREFIX
-	cmpxchg8b (\reg)
-.endm
-
-ENTRY(atomic64_read_cx8)
-	CFI_STARTPROC
-
-	read64 %ecx
-	ret
-	CFI_ENDPROC
-ENDPROC(atomic64_read_cx8)
-
-ENTRY(atomic64_set_cx8)
-	CFI_STARTPROC
-
-1:
-/* we don't need LOCK_PREFIX since aligned 64-bit writes
- * are atomic on 586 and newer */
-	cmpxchg8b (%esi)
-	jne 1b
-
-	ret
-	CFI_ENDPROC
-ENDPROC(atomic64_set_cx8)
-
-ENTRY(atomic64_xchg_cx8)
-	CFI_STARTPROC
-
-	movl %ebx, %eax
-	movl %ecx, %edx
-1:
-	LOCK_PREFIX
-	cmpxchg8b (%esi)
-	jne 1b
-
-	ret
-	CFI_ENDPROC
-ENDPROC(atomic64_xchg_cx8)
-
-.macro addsub_return func ins insc
-ENTRY(atomic64_\func\()_return_cx8)
-	CFI_STARTPROC
-	SAVE ebp
-	SAVE ebx
-	SAVE esi
-	SAVE edi
-
-	movl %eax, %esi
-	movl %edx, %edi
-	movl %ecx, %ebp
-
-	read64 %ebp
-1:
-	movl %eax, %ebx
-	movl %edx, %ecx
-	\ins\()l %esi, %ebx
-	\insc\()l %edi, %ecx
-	LOCK_PREFIX
-	cmpxchg8b (%ebp)
-	jne 1b
-
-10:
-	movl %ebx, %eax
-	movl %ecx, %edx
-	RESTORE edi
-	RESTORE esi
-	RESTORE ebx
-	RESTORE ebp
-	ret
-	CFI_ENDPROC
-ENDPROC(atomic64_\func\()_return_cx8)
-.endm
-
-addsub_return add add adc
-addsub_return sub sub sbb
-
-.macro incdec_return func ins insc
-ENTRY(atomic64_\func\()_return_cx8)
-	CFI_STARTPROC
-	SAVE ebx
-
-	read64 %esi
-1:
-	movl %eax, %ebx
-	movl %edx, %ecx
-	\ins\()l $1, %ebx
-	\insc\()l $0, %ecx
-	LOCK_PREFIX
-	cmpxchg8b (%esi)
-	jne 1b
-
-10:
-	movl %ebx, %eax
-	movl %ecx, %edx
-	RESTORE ebx
-	ret
-	CFI_ENDPROC
-ENDPROC(atomic64_\func\()_return_cx8)
-.endm
-
-incdec_return inc add adc
-incdec_return dec sub sbb
-
-ENTRY(atomic64_dec_if_positive_cx8)
-	CFI_STARTPROC
-	SAVE ebx
-
-	read64 %esi
-1:
-	movl %eax, %ebx
-	movl %edx, %ecx
-	subl $1, %ebx
-	sbb $0, %ecx
-	js 2f
-	LOCK_PREFIX
-	cmpxchg8b (%esi)
-	jne 1b
-
-2:
-	movl %ebx, %eax
-	movl %ecx, %edx
-	RESTORE ebx
-	ret
-	CFI_ENDPROC
-ENDPROC(atomic64_dec_if_positive_cx8)
-
-ENTRY(atomic64_add_unless_cx8)
-	CFI_STARTPROC
-	SAVE ebp
-	SAVE ebx
-/* these just push these two parameters on the stack */
-	SAVE edi
-	SAVE esi
-
-	movl %ecx, %ebp
-	movl %eax, %esi
-	movl %edx, %edi
-
-	read64 %ebp
-1:
-	cmpl %eax, 0(%esp)
-	je 4f
-2:
-	movl %eax, %ebx
-	movl %edx, %ecx
-	addl %esi, %ebx
-	adcl %edi, %ecx
-	LOCK_PREFIX
-	cmpxchg8b (%ebp)
-	jne 1b
-
-	movl $1, %eax
-3:
-	addl $8, %esp
-	CFI_ADJUST_CFA_OFFSET -8
-	RESTORE ebx
-	RESTORE ebp
-	ret
-4:
-	cmpl %edx, 4(%esp)
-	jne 2b
-	xorl %eax, %eax
-	jmp 3b
-	CFI_ENDPROC
-ENDPROC(atomic64_add_unless_cx8)
-
-ENTRY(atomic64_inc_not_zero_cx8)
-	CFI_STARTPROC
-	SAVE ebx
-
-	read64 %esi
-1:
-	testl %eax, %eax
-	je 4f
-2:
-	movl %eax, %ebx
-	movl %edx, %ecx
-	addl $1, %ebx
-	adcl $0, %ecx
-	LOCK_PREFIX
-	cmpxchg8b (%esi)
-	jne 1b
-
-	movl $1, %eax
-3:
-	RESTORE ebx
-	ret
-4:
-	testl %edx, %edx
-	jne 2b
-	jmp 3b
-	CFI_ENDPROC
-ENDPROC(atomic64_inc_not_zero_cx8)
-- 
1.7.2.5




--===============4574424575924593202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
--===============4574424575924593202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4574424575924593202==--

