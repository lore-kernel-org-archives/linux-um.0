Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <g2p.code@gmail.com>) id 1UxPgJ-0002L6-2T
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jul 2013 22:49:47 +0000
Received: from mail-wi0-f172.google.com ([209.85.212.172])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UxPgE-0007Mr-Uk
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jul 2013 22:49:47 +0000
Received: by mail-wi0-f172.google.com with SMTP id c10so47989wiw.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jul 2013 15:49:36 -0700 (PDT)
Message-ID: <51DF367C.5050307@gmail.com>
Date: Fri, 12 Jul 2013 00:49:32 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
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
Subject: [uml-devel] [PATCH] um: /run/shm has replaced /dev/shm
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Look at /run/shm instead of /dev/shm.

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
There's a TMPDIR fallback so I haven't complicated this change with a fallback to /dev/shm.

 arch/um/os-Linux/mem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index ba43980..11d1db7 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -92,18 +92,18 @@ static int next(int fd, char *buf, size_t size, char c)
 
 /* which_tmpdir is called only during early boot */
 static int checked_tmpdir = 0;
 
 /*
- * Look for a tmpfs mounted at /dev/shm.  I couldn't find a cleaner
+ * Look for a tmpfs mounted at /run/shm.  I couldn't find a cleaner
  * way to do this than to parse /proc/mounts.  statfs will return the
- * same filesystem magic number and fs id for both /dev and /dev/shm
+ * same filesystem magic number and fs id for both /run and /run/shm
  * when they are both tmpfs, so you can't tell if they are different
  * filesystems.  Also, there seems to be no other way of finding the
  * mount point of a filesystem from within it.
  *
- * If a /dev/shm tmpfs entry is found, then we switch to using it.
+ * If a /run/shm tmpfs entry is found, then we switch to using it.
  * Otherwise, we stay with the default /tmp.
  */
 static void which_tmpdir(void)
 {
 	int fd, found;
@@ -112,11 +112,11 @@ static void which_tmpdir(void)
 	if (checked_tmpdir)
 		return;
 
 	checked_tmpdir = 1;
 
-	printf("Checking for tmpfs mount on /dev/shm...");
+	printf("Checking for tmpfs mount on /run/shm...");
 
 	fd = open("/proc/mounts", O_RDONLY);
 	if (fd < 0) {
 		printf("failed to open /proc/mounts, errno = %d\n", errno);
 		return;
@@ -125,21 +125,21 @@ static void which_tmpdir(void)
 	while (1) {
 		found = next(fd, buf, ARRAY_SIZE(buf), ' ');
 		if (found != 1)
 			break;
 
-		if (!strncmp(buf, "/dev/shm", strlen("/dev/shm")))
+		if (!strncmp(buf, "/run/shm", strlen("/run/shm")))
 			goto found;
 
 		found = next(fd, buf, ARRAY_SIZE(buf), '\n');
 		if (found != 1)
 			break;
 	}
 
 err:
 	if (found == 0)
-		printf("nothing mounted on /dev/shm\n");
+		printf("nothing mounted on /run/shm\n");
 	else if (found < 0)
 		printf("read returned errno %d\n", -found);
 
 out:
 	close(fd);
@@ -155,11 +155,11 @@ found:
 		printf("not tmpfs\n");
 		goto out;
 	}
 
 	printf("OK\n");
-	default_tmpdir = "/dev/shm";
+	default_tmpdir = "/run/shm";
 	goto out;
 }
 
 static int __init make_tempfile(const char *template, char **out_tempname,
 				int do_unlink)
-- 
1.8.3.2.736.gf6be4c2.dirty


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

