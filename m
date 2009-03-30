Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miklos@szeredi.hu>) id 1LoMUA-0001Vr-2O
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 18:45:26 +0000
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LoMU6-0005mo-FB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 18:45:25 +0000
In-reply-to: <E1LoMQ2-0007bB-By@pomaz-ex.szeredi.hu> (message from Miklos
	Szeredi on Mon, 30 Mar 2009 20:41:10 +0200)
References: <E1LoMQ2-0007bB-By@pomaz-ex.szeredi.hu>
Message-Id: <E1LoMTw-0007d2-AI@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Mar 2009 20:45:12 +0200
Subject: [uml-devel] [patch 3/3] uml: fix warnings in kernel_execve
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

Fix the following warnings:

arch/um/kernel/syscall.c: In function 'kernel_execve':
arch/um/kernel/syscall.c:130: warning: passing argument 1 of 'um_execve' discards qualifiers from pointer target type
arch/um/kernel/syscall.c:130: warning: passing argument 2 of 'um_execve' discards qualifiers from pointer target type
arch/um/kernel/syscall.c:130: warning: passing argument 3 of 'um_execve' discards qualifiers from pointer target type

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
---
 arch/um/kernel/syscall.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/syscall.c	2009-03-30 20:25:17.000000000 +0200
+++ linux-2.6/arch/um/kernel/syscall.c	2009-03-30 20:36:20.000000000 +0200
@@ -127,7 +127,8 @@ int kernel_execve(const char *filename,
 
 	fs = get_fs();
 	set_fs(KERNEL_DS);
-	ret = um_execve(filename, argv, envp);
+	ret = um_execve((char *)filename, (char __user *__user *)argv,
+			(char __user *__user *) envp);
 	set_fs(fs);
 
 	return ret;

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

