Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgpC-0001ME-Pl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:22 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbgpB-0001H0-2u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:22 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041207143711.GA23612@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] uml: fix umldir init order
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
Date: Tue, 7 Dec 2004 15:37:11 +0100
To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>

Fixup initialization order when creating the $HOME/.uml/<umid>
directory and the files therein, also make the error messages
more useful.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/kernel/umid.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

Index: uml-2.6.9-rc2/arch/um/kernel/umid.c
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/kernel/umid.c	2004-09-16 16:34:52.644479658 +0200
+++ uml-2.6.9-rc2/arch/um/kernel/umid.c	2004-09-16 16:37:09.347268895 +0200
@@ -92,8 +92,8 @@ static int __init create_pid_file(void)
 	fd = os_open_file(file, of_create(of_excl(of_rdwr(OPENFLAGS()))), 
 			  0644);
 	if(fd < 0){
-		printf("Open of machine pid file \"%s\" failed - "
-		       "err = %d\n", file, -fd);
+		printf("Open of machine pid file \"%s\" failed: %s\n",
+		       file, strerror(-fd));
 		return 0;
 	}
 
@@ -247,7 +247,7 @@ static int __init make_uml_dir(void)
 	strcpy(uml_dir, dir);
 	
 	if((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)){
-	        printf("Failed to mkdir %s - errno = %i\n", uml_dir, errno);
+	        printf("Failed to mkdir %s: %s\n", uml_dir, strerror(errno));
 		return(-1);
 	}
 	return 0;
@@ -264,8 +264,8 @@ static int __init make_umid(int (*printe
 		strcat(tmp, "XXXXXX");
 		fd = mkstemp(tmp);
 		if(fd < 0){
-			(*printer)("make_umid - mkstemp failed, errno = %d\n",
-				   errno);
+			(*printer)("make_umid - mkstemp(%s) failed: %s\n",
+				   tmp,strerror(errno));
 			return(1);
 		}
 
@@ -303,15 +303,14 @@ __uml_setup("uml_dir=", set_uml_dir,
 "    The location to place the pid and umid files.\n\n"
 );
 
-__uml_postsetup(make_uml_dir);
-
 static int __init make_umid_setup(void)
 {
-	return(make_umid(printf));
+	/* one function with the ordering we need ... */
+	make_uml_dir();
+	make_umid(printf);
+	return create_pid_file();
 }
-
 __uml_postsetup(make_umid_setup);
-__uml_postsetup(create_pid_file);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
