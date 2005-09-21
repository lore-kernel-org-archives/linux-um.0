Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8iG-00049O-Ql	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:56 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI8iF-0006I7-9W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:56 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921172815.10219.19512.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 02/10] strlcat: use for uml umid.c
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
Date: Wed, 21 Sep 2005 19:28:15 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Simplify the code by using strlcat() instead of strncat() and manual
appending.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/user.h |    4 +++-
 arch/um/kernel/umid.c  |   11 ++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/user.h b/arch/um/include/user.h
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -14,7 +14,9 @@ extern void *um_kmalloc_atomic(int size)
 extern void kfree(void *ptr);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
-extern int strlcpy(char *, const char *, int);
+/* These use size_t, however unsigned long is correct on both i386 and x86_64. */
+extern unsigned long strlcpy(char *, const char *, unsigned long);
+extern unsigned long strlcat(char *, const char *, unsigned long);
 extern void *um_vmalloc(int size);
 extern void vfree(void *ptr);
 
diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -237,16 +237,13 @@ static int __init make_uml_dir(void)
 		strlcpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
+	strlcat(dir, uml_dir, sizeof(dir));
 	len = strlen(dir);
-	strncat(dir, uml_dir, sizeof(dir) - len);
-	len = strlen(dir);
-	if((len > 0) && (len < sizeof(dir) - 1) && (dir[len - 1] != '/')){
-		dir[len] = '/';
-		dir[len + 1] = '\0';
-	}
+	if (len > 0 && dir[len - 1] != '/')
+		strlcat(dir, "/", sizeof(dir));
 
 	uml_dir = malloc(strlen(dir) + 1);
-	if(uml_dir == NULL){
+	if (uml_dir == NULL) {
 		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
 		exit(1);
 	}



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
