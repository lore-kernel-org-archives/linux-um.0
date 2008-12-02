Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L7e5K-0006wH-Lg
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Dec 2008 22:51:14 +0000
Received: from wa-out-1112.google.com ([209.85.146.178])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L7e5H-0002Ke-8x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Dec 2008 22:51:14 +0000
Received: by wa-out-1112.google.com with SMTP id m34so1851322wag.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 02 Dec 2008 14:51:09 -0800 (PST)
Message-ID: <2375c9f90812021451hfd77292yf2463ca99d07b88e@mail.gmail.com>
Date: Tue, 2 Dec 2008 22:51:09 +0000
From: "=?UTF-8?Q?Am=C3=A9rico_Wang?=" <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] uml: drop const qualifier for kernel_execve()
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
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

UML implementation of kernel_execve() should not have const qualifier,
because it will finally call do_execve() which doesn't have.

This also shuts up a gcc warning on this.

Signed-off-by: WANG Cong <wangcong@zeuux.org>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index c4df705..4fa62ee 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -120,7 +120,7 @@ long sys_olduname(struct oldold_utsname __user * name)
 	return error;
 }

-int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+int kernel_execve(char *filename, char * argv[], char * envp[])
 {
 	mm_segment_t fs;
 	int ret;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
