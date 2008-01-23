Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 23 Jan 2008 12:12:26 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080123171226.GA7609@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [SPAM] [uml-devel] [RFC PATCH 2/10] SKAS4 - Macroize stub system call
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
To: UML-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Extract the system call execution loop in the stubs into a macro
    
A later patch will need this loop, so this makes it available.

diff --git a/arch/um/sys-i386/stub.S b/arch/um/sys-i386/stub.S
index e730772..890dc50 100644
--- a/arch/um/sys-i386/stub.S
+++ b/arch/um/sys-i386/stub.S
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
diff --git a/arch/um/sys-x86_64/stub.S b/arch/um/sys-x86_64/stub.S
index 4afe204..143a16c 100644
--- a/arch/um/sys-x86_64/stub.S
+++ b/arch/um/sys-x86_64/stub.S
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
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
