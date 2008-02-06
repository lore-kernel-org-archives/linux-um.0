Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMoKY-0004v4-JZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 09:45:06 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JMoKY-0005ob-2Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 09:45:06 -0800
Date: Wed, 6 Feb 2008 12:44:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080206174447.GA7861@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/5] UML - Improved error handling while
	locating temp dir
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
Cc: Jim Meyering <meyering@redhat.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Jim Meyering <meyering@redhat.com>

* arch/um/os-Linux/mem.c (make_tempfile): Don't deref NULL upon failed malloc.

* arch/um/os-Linux/mem.c (make_tempfile): Handle NULL tempdir.
Don't let a long tempdir (e.g., via TMPDIR) provoke heap corruption.

[ jdike - formatting cleanups, deleted obsolete comment ]

Signed-off-by: Jim Meyering <meyering@redhat.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/mem.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: linux-2.6-git/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/mem.c	2008-02-05 13:20:46.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/mem.c	2008-02-05 16:37:37.000000000 -0500
@@ -162,11 +162,6 @@ found:
 	goto out;
 }
 
-/*
- * This proc still used in tt-mode
- * (file: kernel/tt/ptproxy/proxy.c, proc: start_debugger).
- * So it isn't 'static' yet.
- */
 static int __init make_tempfile(const char *template, char **out_tempname,
 				int do_unlink)
 {
@@ -175,10 +170,13 @@ static int __init make_tempfile(const ch
 
 	which_tmpdir();
 	tempname = malloc(MAXPATHLEN);
-	if (!tempname)
-		goto out;
+	if (tempname == NULL)
+		return -1;
 
 	find_tempdir();
+	if ((tempdir == NULL) || (strlen(tempdir) >= MAXPATHLEN))
+		return -1;
+
 	if (template[0] != '/')
 		strcpy(tempname, tempdir);
 	else
@@ -196,9 +194,8 @@ static int __init make_tempfile(const ch
 	}
 	if (out_tempname) {
 		*out_tempname = tempname;
-	} else {
+	} else
 		free(tempname);
-	}
 	return fd;
 out:
 	free(tempname);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
