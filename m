Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9RPM-0003UB-GF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:16 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9RPJ-0005jI-GL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:16 -0800
Message-Id: <200701231927.l0NJRmUb005368@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 23 Jan 2007 14:27:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/7] UML - fix style violations
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix a bunch of style violations in mem.c.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/os-Linux/mem.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/mem.c	2007-01-17 13:03:12.000000000 +1100
+++ linux-2.6.18-mm/arch/um/os-Linux/mem.c	2007-01-17 13:05:21.000000000 +1100
@@ -35,7 +35,8 @@ static void __init find_tempdir(void)
 	int i;
 	char *dir = NULL;
 
-	if(tempdir != NULL) return;	/* We've already been called */
+	if(tempdir != NULL) /* We've already been called */
+		return;
 	for(i = 0; dirs[i]; i++){
 		dir = getenv(dirs[i]);
 		if((dir != NULL) && (*dir != '\0'))
@@ -193,7 +194,7 @@ int make_tempfile(const char *template, 
 	} else {
 		free(tempname);
 	}
-	return(fd);
+	return fd;
 out:
 	free(tempname);
 	return -1;
@@ -238,7 +239,7 @@ int create_tmp_file(unsigned long long l
 		exit(1);
 	}
 
-	return(fd);
+	return fd;
 }
 
 int create_mem_file(unsigned long long len)
@@ -252,7 +253,7 @@ int create_mem_file(unsigned long long l
 		errno = -err;
 		perror("exec_close");
 	}
-	return(fd);
+	return fd;
 }
 
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
