Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCj7W-00055X-Di for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCj7U-0000uM-Ol
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m09M9oAt000387
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:51 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m09M9ocA009299
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:50 -0500
Date: Wed, 9 Jan 2008 17:09:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080109220950.GA9104@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 2/9] SKAS4 - Macroize stub system call
	execution loop
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Extract the system call execution loop in the stubs into a macro.

A later patch will need this loop, so this makes it available.

Index: linux-2.6-skas4/arch/um/sys-i386/stub.S
===================================================================
--- linux-2.6-skas4.orig/arch/um/sys-i386/stub.S	2008-01-08 12:08:07.000000000 -0500
+++ linux-2.6-skas4/arch/um/sys-i386/stub.S	2008-01-08 14:14:06.000000000 -0500
@@ -1,52 +1,45 @@
 #include "uml-config.h"
 #include "as-layout.h"
 
+#define PROCESS_LIST \
+	/* load pointer to first operation */ \
+	mov	$(ASM_STUB_DATA + 8), %esp; \
+1: \
+	/* load length of additional data */ \
+	mov	0x0(%esp), %eax; \
+	/* if(length == 0) : end of list */ \
+	/* write possible 0 to header */ \
+	mov	%eax, ASM_STUB_DATA + 4; \
+	cmpl	$0, %eax; \
+	jz	2f; \
+	/* save current pointer */ \
+	mov	%esp, ASM_STUB_DATA + 4; \
+	/* skip additional data */ \
+	add	%eax, %esp; \
+	/* load syscall-# */ \
+	pop	%eax; \
+	/* load syscall params */ \
+	pop	%ebx; \
+	pop	%ecx; \
+	pop	%edx; \
+	pop	%esi; \
+ 	pop	%edi; \
+	pop	%ebp; \
+	/* execute syscall */ \
+	int	$0x80; \
+	/* check return value */ \
+	pop	%ebx; \
+	cmp	%ebx, %eax; \
+	je	1b; \
+2: \
+	/* save return value */ \
+	mov	%eax, ASM_STUB_DATA;
+
 	.globl syscall_stub
 .section .__syscall_stub, "x"
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	/* load pointer to first operation */
-	mov	$(ASM_STUB_DATA+8), %esp
-
-again:
-	/* load length of additional data */
-	mov	0x0(%esp), %eax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%eax, ASM_STUB_DATA+4
-	cmpl	$0, %eax
-	jz	done
-
-	/* save current pointer */
-	mov	%esp, ASM_STUB_DATA+4
-
-	/* skip additional data */
-	add	%eax, %esp
-
-	/* load syscall-# */
-	pop	%eax
-
-	/* load syscall params */
-	pop	%ebx
-	pop	%ecx
-	pop	%edx
-	pop	%esi
- 	pop	%edi
-	pop	%ebp
-
-	/* execute syscall */
-	int	$0x80
-
-	/* check return value */
-	pop	%ebx
-	cmp	%ebx, %eax
-	je	again
-
-done:
-	/* save return value */
-	mov	%eax, ASM_STUB_DATA
-
+	PROCESS_LIST
 	/* stop */
 	int3
Index: linux-2.6-skas4/arch/um/sys-x86_64/stub.S
===================================================================
--- linux-2.6-skas4.orig/arch/um/sys-x86_64/stub.S	2008-01-08 12:08:07.000000000 -0500
+++ linux-2.6-skas4/arch/um/sys-x86_64/stub.S	2008-01-08 14:14:19.000000000 -0500
@@ -1,67 +1,48 @@
 #include "uml-config.h"
 #include "as-layout.h"
 
-	.globl syscall_stub
-.section .__syscall_stub, "x"
-syscall_stub:
-	syscall
-	/* We don't have 64-bit constants, so this constructs the address
-	 * we need.
-	 */
-	movq	$(ASM_STUB_DATA >> 32), %rbx
-	salq	$32, %rbx
-	movq	$(ASM_STUB_DATA & 0xffffffff), %rcx
-	or	%rcx, %rbx
-	movq	%rax, (%rbx)
-	int3
+#define PROCESS_LIST \
+	mov	$(ASM_STUB_DATA >> 32), %rbx; \
+	sal	$32, %rbx; \
+	mov	$(ASM_STUB_DATA & 0xffffffff), %rax; \
+	or	%rax, %rbx; \
+	/* load pointer to first operation */ \
+	mov	%rbx, %rsp; \
+	add	$0x10, %rsp; \
+1: \
+	/* load length of additional data */ \
+	mov	0x0(%rsp), %rax; \
+	/* if(length == 0) : end of list */ \
+	/* write possible 0 to header */ \
+	mov	%rax, 8(%rbx); \
+	cmp	$0, %rax; \
+	jz	2f; \
+	/* save current pointer */ \
+	mov	%rsp, 8(%rbx); \
+	/* skip additional data */ \
+	add	%rax, %rsp; \
+	/* load syscall-# */ \
+	pop	%rax; \
+	/* load syscall params */ \
+	pop	%rdi; \
+	pop	%rsi; \
+	pop	%rdx; \
+	pop	%r10; \
+ 	pop	%r8; \
+	pop	%r9; \
+	/* execute syscall */ \
+	syscall; \
+	/* check return value */ \
+	pop	%rcx; \
+	cmp	%rcx, %rax; \
+	je	1b; \
+2: \
+	/* save return value */ \
+	mov	%rax, (%rbx); \
 
+.section .__syscall_stub, "x"
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	mov	$(ASM_STUB_DATA >> 32), %rbx
-	sal	$32, %rbx
-	mov	$(ASM_STUB_DATA & 0xffffffff), %rax
-	or	%rax, %rbx
-	/* load pointer to first operation */
-	mov	%rbx, %rsp
-	add	$0x10, %rsp
-again:
-	/* load length of additional data */
-	mov	0x0(%rsp), %rax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%rax, 8(%rbx)
-	cmp	$0, %rax
-	jz	done
-
-	/* save current pointer */
-	mov	%rsp, 8(%rbx)
-
-	/* skip additional data */
-	add	%rax, %rsp
-
-	/* load syscall-# */
-	pop	%rax
-
-	/* load syscall params */
-	pop	%rdi
-	pop	%rsi
-	pop	%rdx
-	pop	%r10
- 	pop	%r8
-	pop	%r9
-
-	/* execute syscall */
-	syscall
-
-	/* check return value */
-	pop	%rcx
-	cmp	%rcx, %rax
-	je	again
-
-done:
-	/* save return value */
-	mov	%rax, (%rbx)
-
+	PROCESS_LIST
 	/* stop */
 	int3

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
