Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VB1Bl-0002PE-Bj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Aug 2013 11:30:29 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VB1Bk-0006hI-8t for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Aug 2013 11:30:29 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 18 Aug 2013 13:30:08 +0200
Message-Id: <1376825409-18570-3-git-send-email-richard@nod.at>
In-Reply-To: <1376825409-18570-1-git-send-email-richard@nod.at>
References: <1376825409-18570-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 3/4] um: Cleanup SIGTERM handling
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

Richard reported that some UML processes survive if the UML
main process receives a SIGTERM.
This issue was caused by a wrongly placed signal(SIGTERM, SIG_DFL)
in init_new_thread_signals().
It disabled the UML exit handler accidently for some processes.
The correct solution is to disable the fatal handler for all
UML helper threads/processes.
Such that last_ditch_exit() does not get called multiple times
and all processes can exit due to SIGTERM.

Cc: rjones@redhat.com
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/ubd.h       |  1 -
 arch/um/drivers/ubd_kern.c  |  3 ++-
 arch/um/drivers/ubd_user.c  |  5 -----
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/aio.c      |  5 ++---
 arch/um/os-Linux/process.c  |  1 -
 arch/um/os-Linux/sigio.c    |  2 +-
 arch/um/os-Linux/util.c     | 10 ++++++++++
 8 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
index 3845051..3b48cd2 100644
--- a/arch/um/drivers/ubd.h
+++ b/arch/um/drivers/ubd.h
@@ -7,7 +7,6 @@
 #ifndef __UM_UBD_USER_H
 #define __UM_UBD_USER_H
 
-extern void ignore_sigwinch_sig(void);
 extern int start_io_thread(unsigned long sp, int *fds_out);
 extern int io_thread(void *arg);
 extern int kernel_fd;
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1812bc8..3716e69 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1476,7 +1476,8 @@ int io_thread(void *arg)
 	struct io_thread_req *req;
 	int n;
 
-	ignore_sigwinch_sig();
+	os_fix_helper_signals();
+
 	while(1){
 		n = os_read_file(kernel_fd, &req,
 				 sizeof(struct io_thread_req *));
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a703e45..e376f9b 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -21,11 +21,6 @@
 #include "ubd.h"
 #include <os.h>
 
-void ignore_sigwinch_sig(void)
-{
-	signal(SIGWINCH, SIG_IGN);
-}
-
 int start_io_thread(unsigned long sp, int *fd_out)
 {
 	int pid, fds[2], err;
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 04859b7..24d8077 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -234,6 +234,7 @@ extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(char *buf, int len);
 extern void os_dump_core(void) __attribute__ ((noreturn));
 extern void um_early_printk(const char *s, unsigned int n);
+extern void os_fix_helper_signals(void);
 
 /* time.c */
 extern void idle_sleep(unsigned long long nsecs);
diff --git a/arch/um/os-Linux/aio.c b/arch/um/os-Linux/aio.c
index 3a6bc2a..014eb35 100644
--- a/arch/um/os-Linux/aio.c
+++ b/arch/um/os-Linux/aio.c
@@ -104,8 +104,7 @@ static int aio_thread(void *arg)
 	struct io_event event;
 	int err, n, reply_fd;
 
-	signal(SIGWINCH, SIG_IGN);
-
+	os_fix_helper_signals();
 	while (1) {
 		n = io_getevents(ctx, 1, 1, &event, NULL);
 		if (n < 0) {
@@ -173,7 +172,7 @@ static int not_aio_thread(void *arg)
 	struct aio_thread_reply reply;
 	int err;
 
-	signal(SIGWINCH, SIG_IGN);
+	os_fix_helper_signals();
 	while (1) {
 		err = read(aio_req_fd_r, &req, sizeof(req));
 		if (err != sizeof(req)) {
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index b8f34c9..7cd61ea 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -242,5 +242,4 @@ void init_new_thread_signals(void)
 	signal(SIGHUP, SIG_IGN);
 	set_handler(SIGIO);
 	signal(SIGWINCH, SIG_IGN);
-	signal(SIGTERM, SIG_DFL);
 }
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 8b61cc0..46e762f 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -55,7 +55,7 @@ static int write_sigio_thread(void *unused)
 	int i, n, respond_fd;
 	char c;
 
-	signal(SIGWINCH, SIG_IGN);
+	os_fix_helper_signals();
 	fds = &current_poll;
 	while (1) {
 		n = poll(fds->poll, fds->used, -1);
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 492ef5e..faee55e 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -94,6 +94,16 @@ static inline void __attribute__ ((noreturn)) uml_abort(void)
 			exit(127);
 }
 
+/*
+ * UML helper threads must not handle SIGWINCH/INT/TERM
+ */
+void os_fix_helper_signals(void)
+{
+	signal(SIGWINCH, SIG_IGN);
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
+}
+
 void os_dump_core(void)
 {
 	int pid;
-- 
1.8.3.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

