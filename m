Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <alexey.zaytsev@gmail.com>) id 1Q3nAP-00061t-Q6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Mar 2011 10:25:53 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q3nAO-0002vb-FO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Mar 2011 10:25:53 +0000
Received: by eye27 with SMTP id 27so1174164eye.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 27 Mar 2011 03:25:46 -0700 (PDT)
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Date: Sun, 27 Mar 2011 14:28:20 +0400
Message-ID: <20110327102305.7569.86213.stgit@zaytsev.su>
MIME-Version: 1.0
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
Subject: [uml-devel] [PATCH] tunctl: Allow non-persitent interfaces
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@karaya.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---

Hello, uml people. Does someone still maintain the uml utilities? You've been
a bit quiet for the last 4 years, but now I've got a patch for you to apply. It's
handy when you run qemu (or anything else that wants persistent tunnels)
inside openvz containers:
http://wiki.openvz.org/VPN_via_the_TUN/TAP_device#The_tunctl_problem


 tunctl/tunctl.c |   39 +++++++++++++++++++++++++++++++--------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tunctl/tunctl.c b/tunctl/tunctl.c
index 16e24a2..0eca752 100644
--- a/tunctl/tunctl.c
+++ b/tunctl/tunctl.c
@@ -21,13 +21,16 @@
 
 static void Usage(char *name)
 {
-  fprintf(stderr, "Create: %s [-b] [-u owner] [-g group] [-t device-name] "
+  fprintf(stderr, "Create: %s [-b] [-n [-m]] [-u owner] [-g group] [-t device-name] "
 	  "[-f tun-clone-device]\n", name);
   fprintf(stderr, "Delete: %s -d device-name [-f tun-clone-device]\n\n",
 	  name);
   fprintf(stderr, "The default tun clone device is /dev/net/tun - some systems"
 	  " use\n/dev/misc/net/tun instead\n\n");
-  fprintf(stderr, "-b will result in brief output (just the device name)\n");
+  fprintf(stderr, "\t-b will result in brief output (just the device name)\n");
+  fprintf(stderr, "\t-n will create a non-persistent tunnel, and sleep until killed\n");
+  fprintf(stderr, "\t-m will daemonize before slleeping, only makes sense with -n\n");
+
   exit(1);
 }
 
@@ -38,10 +41,10 @@ int main(int argc, char **argv)
   struct group *gr;
   uid_t owner = -1;
   gid_t group = -1;
-  int tap_fd, opt, delete = 0, brief = 0;
+  int tap_fd, opt, delete = 0, brief = 0, persistent = 1, daemonize = 0;
   char *tun = "", *file = "/dev/net/tun", *name = argv[0], *end;
 
-  while((opt = getopt(argc, argv, "bd:f:t:u:g:")) > 0){
+  while((opt = getopt(argc, argv, "bd:f:t:u:g:nm")) > 0){
     switch(opt) {
       case 'b':
         brief = 1;
@@ -83,6 +86,13 @@ int main(int argc, char **argv)
       case 't':
         tun = optarg;
         break;
+      case 'n':
+        persistent = 0;
+        break;
+      case 'm':
+        daemonize = 1;
+        break;
+
       case 'h':
       default:
         Usage(name);
@@ -136,21 +146,34 @@ int main(int argc, char **argv)
       }
     }
 
-    if(ioctl(tap_fd, TUNSETPERSIST, 1) < 0){
-      perror("enabling TUNSETPERSIST");
-      exit(1);
+    if (persistent) {
+      if(ioctl(tap_fd, TUNSETPERSIST, 1) < 0){
+        perror("enabling TUNSETPERSIST");
+        exit(1);
+      }
     }
 
     if(brief)
       printf("%s\n", ifr.ifr_name);
     else {
-      printf("Set '%s' persistent and owned by", ifr.ifr_name);
+      if (persistent) {
+        printf("Set '%s' persistent and owned by", ifr.ifr_name);
+      } else {
+        printf("(%u) Sleeping on non-persistent '%s' owned by",
+                        getpid(), ifr.ifr_name);
+      }
       if(owner != -1)
           printf(" uid %d", owner);
       if(group != -1)
           printf(" gid %d", group);
       printf("\n");
     }
+
+    if (!persistent) {
+          if (daemonize)
+            daemon(1, 1);
+          pause();
+    }
   }
   return(0);
 }


------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

