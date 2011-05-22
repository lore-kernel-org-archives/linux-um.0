Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QO9zl-0005tp-EQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2011 14:51:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QO9zj-00068R-NC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2011 14:51:05 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 22 May 2011 16:48:36 +0200
Message-Id: <1306075716-20042-7-git-send-email-richard@nod.at>
In-Reply-To: <1306075716-20042-1-git-send-email-richard@nod.at>
References: <1306075716-20042-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 7/7] um: fix crash while os_dump_core()
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

os_dump_core() emits SIGTERM to terminate all UML processes.
Kernel threads have to exit on SIGTERM instead of calling
last_ditch_exit().
Multiple calls to last_ditch_exit() can cause a crash.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/process.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index e0477c3..0c45dc8 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -253,6 +253,7 @@ void init_new_thread_signals(void)
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGALRM,
 		    SIGVTALRM, -1);
 	signal(SIGWINCH, SIG_IGN);
+	signal(SIGTERM, SIG_DFL);
 }
 
 int run_kernel_thread(int (*fn)(void *), void *arg, jmp_buf **jmp_ptr)
-- 
1.7.4.2


------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

