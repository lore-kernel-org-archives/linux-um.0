Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0o-0003HT-TU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:34 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0l-0003ZY-Dx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:34 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143122.19201.48879.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 14/17] uml: fix big stack user
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
Date: Fri, 07 Apr 2006 16:31:22 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Switch this proc from storing 4k of data (a whole path) on the stack to keeping
it on the heap.

Maybe it's not called in process context but only in early boot context (where
in UML you have a normal process stack on the host) but just to be safe, fix it.

While at it some little readability simplifications.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/mem.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 6ab372d..71bb90a 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -53,33 +53,36 @@ static void __init find_tempdir(void)
  */
 int make_tempfile(const char *template, char **out_tempname, int do_unlink)
 {
-	char tempname[MAXPATHLEN];
+	char *tempname;
 	int fd;
 
+	tempname = malloc(MAXPATHLEN);
+
 	find_tempdir();
-	if (*template != '/')
+	if (template[0] != '/')
 		strcpy(tempname, tempdir);
 	else
-		*tempname = 0;
+		tempname[0] = '\0';
 	strcat(tempname, template);
 	fd = mkstemp(tempname);
 	if(fd < 0){
 		fprintf(stderr, "open - cannot create %s: %s\n", tempname,
 			strerror(errno));
-		return -1;
+		goto out;
 	}
 	if(do_unlink && (unlink(tempname) < 0)){
 		perror("unlink");
-		return -1;
+		goto out;
 	}
 	if(out_tempname){
-		*out_tempname = strdup(tempname);
-		if(*out_tempname == NULL){
-			perror("strdup");
-			return -1;
-		}
+		*out_tempname = tempname;
+	} else {
+		free(tempname);
 	}
 	return(fd);
+out:
+	free(tempname);
+	return -1;
 }
 
 #define TEMPNAME_TEMPLATE "vm_file-XXXXXX"


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
