Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <artagnon@gmail.com>) id 1VPPYu-0005j5-Nx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Sep 2013 04:21:52 +0000
Received: from mail-pd0-f170.google.com ([209.85.192.170])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VPPYs-00050R-W2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Sep 2013 04:21:52 +0000
Received: by mail-pd0-f170.google.com with SMTP id x10so2070910pdj.15
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Sep 2013 21:21:45 -0700 (PDT)
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Fri, 27 Sep 2013 09:44:47 +0530
Message-Id: <1380255287-5818-3-git-send-email-artagnon@gmail.com>
In-Reply-To: <1380255287-5818-1-git-send-email-artagnon@gmail.com>
References: <1380255287-5818-1-git-send-email-artagnon@gmail.com>
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
Subject: [uml-devel] [PATCH 2/2] um/vdso: add .gitignore for a couple of
	targets
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 arch/x86/um/vdso/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/x86/um/vdso/.gitignore

diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
new file mode 100644
index 0000000..9cac6d0
--- /dev/null
+++ b/arch/x86/um/vdso/.gitignore
@@ -0,0 +1,2 @@
+vdso-syms.lds
+vdso.lds
-- 
1.8.4.299.gb3e7d24.dirty


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

