Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZqeOO-0000em-1C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZqeON-0002HM-9i for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 10:48:16 +0100
Message-Id: <1445852897-13102-6-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 6/7] um: Simplify STUB_DATA loading
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

As long STUB_DATA fits into 32bits we can use a plain mov.
If it will grow at some point in future we will switch to movabsq.
In any case the code is smaller and more easy to read
than the current one

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/stub_64.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/um/stub_64.S b/arch/x86/um/stub_64.S
index a212445..ba914b3 100644
--- a/arch/x86/um/stub_64.S
+++ b/arch/x86/um/stub_64.S
@@ -3,10 +3,7 @@
 .section .__syscall_stub, "ax"
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	mov	$(STUB_DATA >> 32), %rbx
-	sal	$32, %rbx
-	mov	$(STUB_DATA & 0xffffffff), %rax
-	or	%rax, %rbx
+	mov	$(STUB_DATA), %rbx
 	/* load pointer to first operation */
 	mov	%rbx, %rsp
 	add	$0x10, %rsp
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

