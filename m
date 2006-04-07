Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0j-0003Ga-QS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:29 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0j-0003Zb-0n
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:29 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143059.19201.58265.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 05/17] uml: fix format errors
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 07 Apr 2006 16:31:00 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Now that GCC warns about format errors, fix them. Nothing able to cause a crash,
however.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/slirp_user.c             |    2 +-
 arch/um/os-Linux/drivers/ethertap_user.c |    2 +-
 arch/um/os-Linux/skas/mem.c              |    4 ++--
 arch/um/os-Linux/skas/process.c          |    4 ++--
 arch/um/sys-i386/ptrace_user.c           |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index b94c661..33c5f6e 100644
--- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -104,7 +104,7 @@ static void slirp_close(int fd, void *da
 	}
 
 	if(err == 0) {
-		printk("slirp_close: process %d has not exited\n");
+		printk("slirp_close: process %d has not exited\n", pri->pid);
 		return;
 	}
 
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index 901b85e..8f49507 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -40,7 +40,7 @@ static void etap_change(int op, unsigned
 			int fd)
 {
 	struct addr_change change;
-	void *output;
+	char *output;
 	int n;
 
 	change.what = op;
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index fbb080c..b3c11cf 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -82,8 +82,8 @@ static inline long do_syscall_stub(struc
 	if (offset) {
 		data = (unsigned long *)(mm_idp->stack +
 					 offset - UML_CONFIG_STUB_DATA);
-		printk("do_syscall_stub : ret = %d, offset = %d, "
-		       "data = 0x%x\n", ret, offset, data);
+		printk("do_syscall_stub : ret = %ld, offset = %ld, "
+		       "data = %p\n", ret, offset, data);
 		syscall = (unsigned long *)((unsigned long)data + data[0]);
 		printk("do_syscall_stub: syscall %ld failed, return value = "
 		       "0x%lx, expected return value = 0x%lx\n",
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index bbf34cb..045ae00 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -265,7 +265,7 @@ void userspace(union uml_pt_regs *regs)
 		if(err)
 			panic("userspace - could not resume userspace process, "
 			      "pid=%d, ptrace operation = %d, errno = %d\n",
-			      op, errno);
+			      pid, op, errno);
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if(err < 0)
@@ -369,7 +369,7 @@ int copy_context_skas0(unsigned long new
 	 */
 	wait_stub_done(pid, -1, "copy_context_skas0");
 	if (child_data->err != UML_CONFIG_STUB_DATA)
-		panic("copy_context_skas0 - stub-child reports error %d\n",
+		panic("copy_context_skas0 - stub-child reports error %ld\n",
 		      child_data->err);
 
 	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
diff --git a/arch/um/sys-i386/ptrace_user.c b/arch/um/sys-i386/ptrace_user.c
index 9f3bd8e..40aa885 100644
--- a/arch/um/sys-i386/ptrace_user.c
+++ b/arch/um/sys-i386/ptrace_user.c
@@ -57,7 +57,7 @@ static void write_debugregs(int pid, uns
 		if(ptrace(PTRACE_POKEUSR, pid, &dummy->u_debugreg[i],
 			  regs[i]) < 0)
 			printk("write_debugregs - ptrace failed on "
-			       "register %d, value = 0x%x, errno = %d\n", i,
+			       "register %d, value = 0x%lx, errno = %d\n", i,
 			       regs[i], errno);
 	}
 }


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
