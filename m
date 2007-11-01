Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IndhA-0001DY-Nj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 10:19:05 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Indh9-0003F3-PB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 10:19:04 -0700
Received: by ug-out-1314.google.com with SMTP id m2so526945uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 01 Nov 2007 10:19:02 -0700 (PDT)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Date: Thu, 1 Nov 2007 19:18:34 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200711011918.36294.alon.barlev@gmail.com>
Subject: [uml-devel] [PATCH] tunctl add group support
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
To: user-mode-linux-devel@lists.sourceforge.net


Add support for -g (group) parameter to set permission of group
based.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp tools-20060323.org/tunctl/tunctl.c tools-20060323/tunctl/tunctl.c
--- tools-20060323.org/tunctl/tunctl.c	2002-09-11 01:18:06.000000000 +0300
+++ tools-20060323/tunctl/tunctl.c	2007-11-01 17:05:09.000000000 +0200
@@ -9,13 +9,14 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <pwd.h>
+#include <grp.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <linux/if_tun.h>
 
 static void Usage(char *name)
 {
-  fprintf(stderr, "Create: %s [-b] [-u owner] [-t device-name] "
+  fprintf(stderr, "Create: %s [-b] [ -g group ] [-u owner] [-t device-name] "
 	  "[-f tun-clone-device]\n", name);
   fprintf(stderr, "Delete: %s -d device-name [-f tun-clone-device]\n\n", 
 	  name);
@@ -29,11 +30,13 @@ int main(int argc, char **argv)
 {
   struct ifreq ifr;
   struct passwd *pw;
+  struct group *gr;
   long owner = geteuid();
+  long group = getegid();
   int tap_fd, opt, delete = 0, brief = 0;
   char *tun = "", *file = "/dev/net/tun", *name = argv[0], *end;
 
-  while((opt = getopt(argc, argv, "bd:f:t:u:")) > 0){
+  while((opt = getopt(argc, argv, "bd:f:t:u:g:")) > 0){
     switch(opt) {
       case 'b':
         brief = 1;
@@ -58,6 +61,19 @@ int main(int argc, char **argv)
 	  Usage(name);
 	}
         break;
+      case 'g':
+	gr = getgrnam(optarg);
+	if(gr != NULL){
+	  group = gr->gr_gid;
+	  break;
+	}
+        group = strtol(optarg, &end, 0);
+	if(*end != '\0'){
+	  fprintf(stderr, "'%s' is neither a groupname nor a numeric gid.\n",
+		  optarg);
+	  Usage(name);
+	}
+        break;
       case 't':
         tun = optarg;
         break;
@@ -104,10 +120,17 @@ int main(int argc, char **argv)
       perror("TUNSETPERSIST");
       exit(1);
     } 
+#ifndef TUNSETGROUP
+#define TUNSETGROUP   _IOW('T', 206, int)
+#endif
+    if(ioctl(tap_fd, TUNSETGROUP, group) < 0){
+      perror("TUNSETGROUP");
+      group=-1;
+    } 
     if(brief)
       printf("%s\n", ifr.ifr_name);
-    else printf("Set '%s' persistent and owned by uid %ld\n", ifr.ifr_name, 
-		owner);
+    else printf("Set '%s' persistent and owned by gid %ld uid %ld\n",
+		ifr.ifr_name, group, owner);
   }
   return(0);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
