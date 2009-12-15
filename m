Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rob@landley.net>) id 1NKPwP-0000pu-8r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Dec 2009 05:27:21 +0000
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKPwH-00018V-DV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Dec 2009 05:27:21 +0000
From: Rob Landley <rob@landley.net>
Date: Mon, 14 Dec 2009 23:07:42 -0600
References: <4AF96F9D.80107@strongswan.org>
In-Reply-To: <4AF96F9D.80107@strongswan.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200912142307.43589.rob@landley.net>
Subject: Re: [uml-devel] [PATCH] hostfs: fix setting the timestamps of files
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
To: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 10 November 2009 07:50:21 Tobias Brunner wrote:
> When setting the timestamps of a file using e.g. futimens the flag
> HOSTFS_ATTR_(A|M)TIME_SET is set only if explicit timestamps were
> specified. If futimens is called without timestamps (i.e. parameter
> times is set to NULL), only HOSTFS_ATTR_(A|M)TIME is set. On the other
> hand, the latter flag is also set if the timestamps were explicitly
> specified.
>
> Signed-off-by: Tobias Brunner <tobias@strongswan.org>

I hit this bug too, and this patch fixed it for me, so:

Acked-by: Rob Landley <rob@landley.net>

Speaking of which, here's a pending patch of my own reparented on top of this
one:

From: Rob Landley <rob@landley.net>

Switch futimes() usage to Posix 2008 futimens(), and while I'm at migrate
utimes() to utimensat() and eliminate use of timeval.

This is required to build UML against uClibc.

Signed-off-by: Rob Landley <rob@landley.net>
---

 fs/hostfs/hostfs_user.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

--- temp2/fs/hostfs/hostfs_user.c	2009-11-22 17:52:21.000000000 -0600
+++ temp/fs/hostfs/hostfs_user.c	2009-11-29 05:51:57.000000000 -0600
@@ -3,6 +3,12 @@
  * Licensed under the GPL
  */
 
+/* These two #defines are needed for futimens and utimensat until glibc
+   catches up with posix 2008. */
+
+#define __USE_ATFILE
+#define __USE_GNU
+
 #include <stdio.h>
 #include <stddef.h>
 #include <unistd.h>
@@ -235,8 +241,7 @@
 
 int set_attr(const char *file, struct hostfs_iattr *attrs, int fd)
 {
-	struct timeval times[2];
-	struct timespec atime_ts, mtime_ts;
+	struct timespec time_ts[2];
 	int err, ma;
 
 	if (attrs->ia_valid & HOSTFS_ATTR_MODE) {
@@ -280,29 +285,26 @@
 	ma = (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME);
 	if (attrs->ia_valid & ma) {
 		err = stat_file(file, NULL, NULL, NULL, NULL, NULL, NULL,
-				&atime_ts, &mtime_ts, NULL, NULL, NULL, fd);
+				time_ts, time_ts+1, NULL, NULL, NULL, fd);
 		if (err != 0)
 			return err;
 
-		times[0].tv_sec = atime_ts.tv_sec;
-		times[0].tv_usec = atime_ts.tv_nsec / 1000;
-		times[1].tv_sec = mtime_ts.tv_sec;
-		times[1].tv_usec = mtime_ts.tv_nsec / 1000;
-
 		if (attrs->ia_valid & HOSTFS_ATTR_ATIME) {
-			times[0].tv_sec = attrs->ia_atime.tv_sec;
-			times[0].tv_usec = attrs->ia_atime.tv_nsec / 1000;
+			time_ts[0].tv_sec = attrs->ia_atime.tv_sec;
+			time_ts[0].tv_nsec = attrs->ia_atime.tv_nsec;
 		}
 		if (attrs->ia_valid & HOSTFS_ATTR_MTIME) {
-			times[1].tv_sec = attrs->ia_mtime.tv_sec;
-			times[1].tv_usec = attrs->ia_mtime.tv_nsec / 1000;
+			time_ts[1].tv_sec = attrs->ia_mtime.tv_sec;
+			time_ts[1].tv_nsec = attrs->ia_mtime.tv_nsec;
 		}
 
 		if (fd >= 0) {
-			if (futimes(fd, times) != 0)
+			if (futimens(fd, time_ts) != 0)
 				return -errno;
-		} else if (utimes(file, times) != 0) {
-			return -errno;
+		} else {
+			if (utimensat(AT_FDCWD, file, time_ts, 0) != 0) {
+				return -errno;
+			}
 		}
 	}
 

-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

