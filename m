Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUFVM-00070f-PP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 18:52:52 -0700
Received: from shell.blacknet.de ([80.254.131.106])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BUFVM-00062D-Ct
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 18:52:52 -0700
From: Goetz Bock <bock+uml@blacknet.de>
Message-ID: <20040530015300.GB450@shell.blacknet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] username support for jail_uml
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
Date: Sun, 30 May 2004 03:53:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I've written included patch to add support for usernames/groups and gids
to jail_uml. The default group/gid is hardcoded to 99 (=nobody on my
system).

Cu,
    Goetz.

diff -ur tools/jail/jail_uml.c tools-bn/jail/jail_uml.c
--- tools/jail/jail_uml.c	2003-01-22 18:46:36.000000000 +0100
+++ tools-bn/jail/jail_uml.c	2004-05-30 03:43:17.000000000 +0200
@@ -1,18 +1,32 @@
+/* jail a uml into a directory.
+ 
+*/
+
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
+#include <pwd.h>
+#include <grp.h>
+#include <sys/types.h>
 
 static void Usage(void)
 {
-  fprintf(stderr, "Usage : jail_uml jail-directory uid "
+  fprintf(stderr, "Usage : jail_uml jail-directory user "
 	  "uml-command-line ...\n");
+  fprintf(stderr, "    or: jail_uml jail-directory uid "
+	  "uml-command-line ...\n\n");
+  fprintf(stderr, "If the user is not found, it's assumed to be a uid.\n");
   exit(1);
 }
 
 int main(int argc, char **argv)
 {
   char *dir, *end;
-  int uid;
+  char *user;
+  struct passwd *pw;
+  int uid, gid=99;
+  gid_t gidset[1];
+  gidset[0]=gid;
 
   if(geteuid() != 0){
     fprintf(stderr, "jail_uml must be run as root\n");
@@ -21,8 +35,22 @@
 
   if(argc < 3) Usage();
   dir = argv[1];
-  uid = strtoul(argv[2], &end, 0);
-  if(*end != '\0') Usage();
+  user = argv[2];
+  
+  // get users password information
+  pw = getpwnam (user);
+  if (pw == 0){
+    uid = strtoul(argv[2], &end, 0);
+    if(*end != '\0') Usage();
+    setgroups(1, gidset);
+  } else {
+    // try to init groups
+    initgroups (pw->pw_name, pw->pw_gid); 
+    uid = pw->pw_uid;
+    gid = pw->pw_gid;
+  }
+
+  // if(*end != '\0') Usage();
   argc -= 3;
   argv += 3;
 
@@ -36,6 +64,10 @@
     exit(1);
   }
 
+  if(setgid(gid)){
+    perror("setgid");
+    exit(1);
+  }
   if(setuid(uid)){
     perror("setuid");
     exit(1);


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
