Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <thomas.roth@leveldown.de>) id 1PxKjQ-0003WH-P7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2011 14:51:20 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PxKjO-0005wl-JO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2011 14:51:20 +0000
Received: by ywg8 with SMTP id 8so294242ywg.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 Mar 2011 06:51:13 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 9 Mar 2011 15:21:07 +0100
Message-ID: <AANLkTi=tCx=04dwqxyZ9DJioibMURzXbTMgoKpSg03jf@mail.gmail.com>
From: Thomas Roth <code@stacksmashing.net>
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
Subject: [uml-devel] [PATCH] make_tempfile: Fix potential memory leak.
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This patch removes a potential memory leak in make_tempfile (in
arch/um/os-Linux/mem.c).
If tempdir is NULL or as long as MAXPATHLEN, the function will return
without freeing the previously
malloced tempname, resulting in a memory leak. Another way to fix this
issue is to replace :
 	if ((tempdir == NULL) || (strlen(tempdir) >= MAXPATHLEN))
 		return -1;
with:
 	if ((tempdir == NULL) || (strlen(tempdir) >= MAXPATHLEN))
 		goto out;

But I think the way in the attached patch is cleaner, as it doesn't
malloc tempname at all if it's not necessary.

Cheers,

Thomas

---
 arch/um/os-Linux/mem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index e696144..e135422 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -170,14 +170,14 @@ static int __init make_tempfile(const char
*template, char **out_tempname,
 	int fd;

 	which_tmpdir();
-	tempname = malloc(MAXPATHLEN);
-	if (tempname == NULL)
-		return -1;
-
 	find_tempdir();
 	if ((tempdir == NULL) || (strlen(tempdir) >= MAXPATHLEN))
 		return -1;

+	tempname = malloc(MAXPATHLEN);
+	if (tempname == NULL)
+		return -1;
+
 	if (template[0] != '/')
 		strcpy(tempname, tempdir);
 	else
-- 
1.7.2.3

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

