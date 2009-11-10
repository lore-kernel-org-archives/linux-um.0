Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tobias@strongswan.org>) id 1N7rc9-00059E-Qw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Nov 2009 14:22:33 +0000
Received: from sidv0150.hsr.ch ([152.96.52.150] helo=strongswan.org)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7rc2-0000OU-56
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Nov 2009 14:22:33 +0000
Received: from [152.96.15.216] (unknown [152.96.15.216])
	by strongswan.org (Postfix) with ESMTP id 138A1EF92A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Nov 2009 14:50:30 +0100 (CET)
Message-ID: <4AF96F9D.80107@strongswan.org>
Date: Tue, 10 Nov 2009 14:50:21 +0100
From: Tobias Brunner <tobias@strongswan.org>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] hostfs: fix setting the timestamps of files
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

When setting the timestamps of a file using e.g. futimens the flag
HOSTFS_ATTR_(A|M)TIME_SET is set only if explicit timestamps were
specified. If futimens is called without timestamps (i.e. parameter
times is set to NULL), only HOSTFS_ATTR_(A|M)TIME is set. On the other
hand, the latter flag is also set if the timestamps were explicitly
specified.

Signed-off-by: Tobias Brunner <tobias@strongswan.org>
---
 fs/hostfs/hostfs_user.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index b79424f..3da7cdd 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -277,7 +277,8 @@ int set_attr(const char *file, struct hostfs_iattr
*attrs, int fd)
 	 * times according to the changes to perform, and then call futimes()
 	 * or utimes() to apply them.
 	 */
-	ma = (HOSTFS_ATTR_ATIME_SET | HOSTFS_ATTR_MTIME_SET);
+	/* Note: ctime is not handled */
+	ma = (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME);
 	if (attrs->ia_valid & ma) {
 		err = stat_file(file, NULL, NULL, NULL, NULL, NULL, NULL,
 				&atime_ts, &mtime_ts, NULL, NULL, NULL, fd);
@@ -289,11 +290,11 @@ int set_attr(const char *file, struct hostfs_iattr
*attrs, int fd)
 		times[1].tv_sec = mtime_ts.tv_sec;
 		times[1].tv_usec = mtime_ts.tv_nsec / 1000;

-		if (attrs->ia_valid & HOSTFS_ATTR_ATIME_SET) {
+		if (attrs->ia_valid & HOSTFS_ATTR_ATIME) {
 			times[0].tv_sec = attrs->ia_atime.tv_sec;
 			times[0].tv_usec = attrs->ia_atime.tv_nsec / 1000;
 		}
-		if (attrs->ia_valid & HOSTFS_ATTR_MTIME_SET) {
+		if (attrs->ia_valid & HOSTFS_ATTR_MTIME) {
 			times[1].tv_sec = attrs->ia_mtime.tv_sec;
 			times[1].tv_usec = attrs->ia_mtime.tv_nsec / 1000;
 		}
@@ -306,14 +307,6 @@ int set_attr(const char *file, struct hostfs_iattr
*attrs, int fd)
 		}
 	}

-	/* Note: ctime is not handled */
-	if (attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)) {
-		err = stat_file(file, NULL, NULL, NULL, NULL, NULL, NULL,
-				&attrs->ia_atime, &attrs->ia_mtime, NULL,
-				NULL, NULL, fd);
-		if (err != 0)
-			return err;
-	}
 	return 0;
 }


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

