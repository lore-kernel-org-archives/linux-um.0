Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA9ta-0005Wg-9H for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JA9tZ-0001aC-Kf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:58 -0800
Date: Wed, 2 Jan 2008 15:08:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102200853.GA7949@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/7] UML - Fix hostfs tv_usec calculations
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Dominique Quatravaux <dominique@quatravaux.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Dominique Quatravaux <dominique@quatravaux.org>

To convert from tv_nsec to tv_usec, one needs to divide by 1000, not
multiply.

Signed-off-by: Dominique Quatravaux <dominique@quatravaux.org>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 fs/hostfs/hostfs_user.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22/fs/hostfs/hostfs_user.c
===================================================================
--- linux-2.6.22.orig/fs/hostfs/hostfs_user.c	2007-11-21 12:04:56.000000000 -0500
+++ linux-2.6.22/fs/hostfs/hostfs_user.c	2007-11-21 13:01:28.000000000 -0500
@@ -285,17 +285,17 @@ int set_attr(const char *file, struct ho
 			return err;
 
 		times[0].tv_sec = atime_ts.tv_sec;
-		times[0].tv_usec = atime_ts.tv_nsec * 1000;
+		times[0].tv_usec = atime_ts.tv_nsec / 1000;
 		times[1].tv_sec = mtime_ts.tv_sec;
-		times[1].tv_usec = mtime_ts.tv_nsec * 1000;
+		times[1].tv_usec = mtime_ts.tv_nsec / 1000;
 
 		if (attrs->ia_valid & HOSTFS_ATTR_ATIME_SET) {
 			times[0].tv_sec = attrs->ia_atime.tv_sec;
-			times[0].tv_usec = attrs->ia_atime.tv_nsec * 1000;
+			times[0].tv_usec = attrs->ia_atime.tv_nsec / 1000;
 		}
 		if (attrs->ia_valid & HOSTFS_ATTR_MTIME_SET) {
 			times[1].tv_sec = attrs->ia_mtime.tv_sec;
-			times[1].tv_usec = attrs->ia_mtime.tv_nsec * 1000;
+			times[1].tv_usec = attrs->ia_mtime.tv_nsec / 1000;
 		}
 
 		if (fd >= 0) {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
