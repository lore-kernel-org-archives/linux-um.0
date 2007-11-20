Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuUTS-0005wV-Aw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Nov 2007 06:53:14 -0800
Received: from kilimandjaro.dyndns.org ([212.85.147.17])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IuUTQ-0005XH-NO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Nov 2007 06:53:14 -0800
Message-ID: <4742F40B.1030508@quatravaux.org>
Date: Tue, 20 Nov 2007 15:49:47 +0100
From: Dominique Quatravaux <dominique@quatravaux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060908050509030109010902"
Subject: [uml-devel] [PATCH] Fixed hostfs tv_usec / tv_nsec conversion in
	2.6.22.9
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060908050509030109010902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear UML developpers and users,

The attached patch against Linux 2.6.22.9 fixes an issue with
emulating the utimes() and futimes() system calls, that used to cause
- -EINVAL to be returned from such.

Regards,

- --
<< Tout n'y est pas parfait, mais on y honore certainement les
jardiniers >>

            Dominique Quatravaux <dominique@quatravaux.org>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQCVAwUBR0L0CvTYH7KfeIIFAQJYuAP/a6gUhIS8rTd6daU55XZa+j4B7cnGFxvX
lVXUZYzznsgWP77TZBDkhiisBJPiUJ67Lvnsaq883xjebOteaZ6QjxRMszV7N16o
WOxq9Qu0+bLZjiYuQWuGvw/4j2NJ6BSO9dA+8Lu6siSIxuH8FgNvPnZgXXV0npNg
KgAzwvEmmDE=
=yC7D
-----END PGP SIGNATURE-----


--------------060908050509030109010902
Content-Type: text/x-patch;
 name="UML-usec-nsec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="UML-usec-nsec.diff"

diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -262,17 +262,17 @@ int set_attr(const char *file, struct ho
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

--------------060908050509030109010902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------060908050509030109010902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------060908050509030109010902--


