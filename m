Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8km7-0007bI-Kw	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 13:26:07 -0700
Received: from agminet04.oracle.com ([141.146.126.231])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E8km7-0001RU-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 13:26:07 -0700
Received: from rgmsgw301.us.oracle.com (rgmsgw301.us.oracle.com
	[138.1.186.50])j7QKQ0x4003717
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 15:26:01 -0500
Received: from rgmsgw301.us.oracle.com (localhost [127.0.0.1])
	j7QKQ0AA009657	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 14:26:00 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j7QKPxlk009644
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 14:25:59 -0600
Message-ID: <430F7AD7.3080202@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040409060402020304080004"
Subject: [uml-devel] patch for interrupt, try 3
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
Date: Fri, 26 Aug 2005 16:25:59 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040409060402020304080004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Words fail me?
:)

--------------040409060402020304080004
Content-Type: text/plain;
 name="interrupt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupt.patch"

--- uml_mconsole.c.orig	2005-08-26 13:08:33.000000000 -0400
+++ uml_mconsole.c	2005-08-26 16:22:22.000000000 -0400
@@ -37,13 +37,18 @@
 #include <sys/uio.h>
 #include <readline/readline.h>
 #include <readline/history.h>
+#include <signal.h>
+
 
 static char uml_name[11];
 static struct sockaddr_un sun;
+static long int uml_pid;
 
-static int do_switch(char *file, char *name)
+static int do_switch(char *dir, char *file, char *name)
 {
   struct stat buf;
+  char pid_path[MAXPATHLEN + 1]="";
+  FILE *fd;
 
   if(stat(file, &buf) == -1){
     fprintf(stderr, "Warning: couldn't stat file: %s - ", file);
@@ -53,6 +58,14 @@
   sun.sun_family = AF_UNIX;
   strncpy(sun.sun_path, file, sizeof(sun.sun_path));
   strncpy(uml_name, name, sizeof(uml_name));
+
+  /* Open and read PID file */
+  snprintf(pid_path, sizeof(pid_path), "%s/%s/pid", dir, name);
+  if(!(fd=fopen(pid_path, "r")) || (fscanf(fd, "%ld", &uml_pid)!=1)) {
+      uml_pid=-1;
+      return(0);
+  }
+
   return(0);
 }
 
@@ -65,19 +78,22 @@
     snprintf(dir, sizeof(dir), "%s/.uml", home);
     snprintf(file, sizeof(file), "%s/%s/mconsole", dir, name);
     if(strncmp(name, dir, strlen(dir))){
-      if(!do_switch(file, name)) return(0);
+      if(!do_switch(dir,file, name)) return(0);
       try_file = 0;
     }
   }
 
+  snprintf(dir, sizeof(dir), "/tmp/uml/%s", name);
   snprintf(tmp, sizeof(tmp), "/tmp/uml/%s/mconsole", name);
   if(strncmp(name, "/tmp/uml/", strlen("/tmp/uml/"))){
-    if(!do_switch(tmp, name)) return(0);
+    if(!do_switch(dir,tmp, name)) return(0);
   }
 
-  if(!do_switch(name, name)) return(0);
+
+  snprintf(dir, sizeof(dir), "./");
+  if(!do_switch(dir, name, name)) return(0);
   if(!try_file) return(-1);
-  return(do_switch(file, name));
+  return(do_switch(dir,file, name));
 }
 
 #define MCONSOLE_MAGIC (0xcafebabe)
@@ -264,7 +280,8 @@
     quit - Quit mconsole\n\
     switch <socket-name> - Switch control to the given machine\n\
     log -f <filename> - use contents of <filename> as UML log messages\n\
-    mconsole-version - version of this mconsole program\n";
+    mconsole-version - version of this mconsole program\n\
+    int  - Interrupt UML session \n";
 
 static int help_cmd(int fd, char *command)
 {
@@ -344,6 +361,35 @@
   return(0);
 }
 
+static int int_cmd(int fd, char *command)
+{
+  extern int errno;
+
+  if (uml_pid == -1) {
+    printf("Cannot determine the PID of your UML session, not sending signal.\n");
+    return(0);
+  }
+
+  if(kill(uml_pid, SIGINT) == -1) {
+    printf("Unable to interrupt process %ld.\n", uml_pid);
+    switch(errno) {
+      case EINVAL:
+        printf("\tInvalid Signal.\n");
+        break;
+      case ESRCH:
+        printf("\tPID does not exist! \n");
+        break;
+      case EPERM:
+        printf("\tYou don't have permission to do that. \n");
+        break;
+      default:
+        break;
+    }
+  }
+
+  return(0);
+}
+
 struct cmd {
   char *command;
   int (*proc)(int, char *);
@@ -355,6 +401,7 @@
   { "switch", switch_cmd },
   { "log", log_cmd },
   { "mconsole-version", mversion_cmd },
+  { "int", int_cmd },
   { NULL, default_cmd }
   /* default_cmd means "send it to the UML" */
 };

--------------040409060402020304080004--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
