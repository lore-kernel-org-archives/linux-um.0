Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZqeOH-0000dm-Sv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:33 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZqeOH-0002Gr-2L for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:33 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 10:48:14 +0100
Message-Id: <1445852897-13102-4-git-send-email-richard@nod.at>
In-Reply-To: <1445852897-13102-1-git-send-email-richard@nod.at>
References: <1445852897-13102-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 4/7] um: Remove dead code from x86_64 syscall
	stub
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

syscall_stub is dead code as um is using only
batch_syscall_stub.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/stub_64.S | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/um/stub_64.S b/arch/x86/um/stub_64.S
index 7160b20..a212445 100644
--- a/arch/x86/um/stub_64.S
+++ b/arch/x86/um/stub_64.S
@@ -1,19 +1,6 @@
 #include <as-layout.h>
 
-	.globl syscall_stub
 .section .__syscall_stub, "ax"
-syscall_stub:
-	syscall
-	/* We don't have 64-bit constants, so this constructs the address
-	 * we need.
-	 */
-	movq	$(STUB_DATA >> 32), %rbx
-	salq	$32, %rbx
-	movq	$(STUB_DATA & 0xffffffff), %rcx
-	or	%rcx, %rbx
-	movq	%rax, (%rbx)
-	int3
-
 	.globl batch_syscall_stub
 batch_syscall_stub:
 	mov	$(STUB_DATA >> 32), %rbx
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

