Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8mPZ-0003ay-Vc	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 15:10:57 -0700
Received: from agminet03.oracle.com ([141.146.126.230])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E8mPZ-0004ou-Hm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 15:10:57 -0700
Received: from rgmsgw300.us.oracle.com (rgmsgw300.us.oracle.com
	[138.1.186.49])j7QMAp5B020354
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 17:10:51 -0500
Received: from rgmsgw300.us.oracle.com (localhost [127.0.0.1])
	j7QMAovd031771	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 16:10:50 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j7QMAn2S031764
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 16:10:50 -0600
Message-ID: <430F936A.9020404@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090105030600080000080605"
Subject: [uml-devel] patch, try #3 for interrupt
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
Date: Fri, 26 Aug 2005 18:10:50 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090105030600080000080605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I must be perfect.  Really, really perfect.  If not, Jeff will make me.

--------------090105030600080000080605
Content-Type: text/plain;
 name="interrupt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupt.patch"

--- uml_mconsole.c.orig	2005-08-26 13:08:33.000000000 -0400
+++ uml_mconsole.c	2005-08-26 18:07:10.000000000 -0400
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
@@ -344,6 +361,24 @@
   return(0);
 }
 
+static int int_cmd(int fd, char *command)
+{
+  extern int errno;
+  char er_string[255];
+
+  if (uml_pid == -1) {
+    perror("Cannot determine the PID of your UML session, not sending signal.\n");
+    return(0);
+  }
+
+  if(kill(uml_pid, SIGINT) == -1) {
+    sprintf(er_string, "Unable to interrupt process %ld.\n", uml_pid);
+    perror(er_string);
+  }
+
+  return(0);
+}
+
 struct cmd {
   char *command;
   int (*proc)(int, char *);
@@ -355,6 +390,7 @@
   { "switch", switch_cmd },
   { "log", log_cmd },
   { "mconsole-version", mversion_cmd },
+  { "int", int_cmd },
   { NULL, default_cmd }
   /* default_cmd means "send it to the UML" */
 };

--------------090105030600080000080605--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
