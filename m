Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Al4iz-00077J-6D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 03:16:13 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AkwjU-0006nO-6Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 18:44:12 -0800
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040126024617.GB4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] mconsole fixes
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
Date: Mon, 26 Jan 2004 13:16:17 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

This makes uml_mconsole a bit more useful in scripts:

	1. it exits with '1' for an error, '0' for no error. So you can
	now tell if you have got a pty for a tty or not without scraping
	text

	2. has a more sensible error message where the pipe doesn't
	exist

	3. adds a local command called 'mconsole-version' (which will be
	more useful as UML matures and the design of having all the
	clever bits inside UML really shows its value.)

SGML docs not modified, because I don't know the convention for changing
them (eg, do you add new ENTITY entries for new authors, or does the
last author overwrite the previous...?)

-- 
Dan Shearer
dan@shearer.org

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="diff.mconsole"

--- uml_mconsole.c.orig	2004-01-26 11:30:54.000000000 +1030
+++ uml_mconsole.c	2004-01-26 13:00:21.000000000 +1030
@@ -1,5 +1,30 @@
-/* Copyright 2001 Jeff Dike and others
- * Licensed under the GPL
+/* (c) Copyright 2001-2004 Jeff Dike and others
+ * Licensed under the GPL, see file COPYING
+ *
+ * This is uml_console version 2, a tool for querying a User Mode Linux 
+ * instance over a local pipe connection. This tool does not
+ * (since uml_mconsole version 1) need to be in sync with the version
+ * of the UML kernel since the commands and their implementation 
+ * are within UML. uml_mconsole just displays what UML tells it to.
+ * There are a very few local commands that this program knows
+ * about, but by default everything gets processed by UML.
+ *
+ * The uml_mconsole documentation distributed with covers all mconsole
+ * commands, so the docs have to be kept in sync with the kernel.
+ * In future it should be possible for the docs to come from (or be
+ * in common with) something over in the kernel source.
+ *
+ * If you are looking for the command implementation, go to the
+ * files mconsole_kern.c in the Linux kernel source under arch/um.
+ * 
+ * The program exits with error values of:
+ *
+ *      0    No error
+ *      1    Error     (need better breakdown of error type in future)
+ *
+ * Future TODO: return commandline results as a shell variable assignment 
+ * eg: 'uml_mconsole config con0' might return "UML-CON=fd:0,fd:1"
+ *
  */
 
 #include <stdio.h>
@@ -27,7 +52,7 @@
   if(stat(file, &buf) == -1){
     fprintf(stderr, "Warning: couldn't stat file: %s - ", file);
     perror("");
-    return(-1);
+    return(1);
   }
   sun.sun_family = AF_UNIX;
   strncpy(sun.sun_path, file, sizeof(sun.sun_path));
@@ -183,7 +208,7 @@
   return(1);
 }
 
-static void default_cmd(int fd, char *command)
+static int default_cmd(int fd, char *command)
 {
   struct mconsole_request request;
   struct mconsole_reply reply;
@@ -192,7 +217,7 @@
 
   if((sscanf(command, "%128[^: \f\n\r\t\v]:", name) == 1) &&
      (*(name + 1) == ':')){
-    if(switch_common(name)) return;
+    if(switch_common(name)) return(1);
     command = strchr(command, ':');
     *command++ = '\0';
     while(isspace(*command)) command++;
@@ -210,18 +235,21 @@
 
   if(sendto(fd, &request, sizeof(request), 0, (struct sockaddr *) &sun, 
 	    sizeof(sun)) < 0){
-    fprintf(stderr, "Sending command to '%s' : ", sun.sun_path);
-    perror("");
-    return;
+    if (strlen(sun.sun_path)==0) {
+      fprintf(stderr, "No connection exists, cannot send command.\n");
+    } else {
+      fprintf(stderr, "While sending command to '%s' : ", sun.sun_path);
+      perror("");
+    }
+    return(1);
   }
 
   first = 1;
   do {
-    int len = sizeof(sun);
     n = recvfrom(fd, &reply, sizeof(reply), 0, NULL, 0);
     if(n < 0){
       perror("recvmsg");
-      return;
+      return(1);
     }
 
     if(first){
@@ -235,31 +263,35 @@
   } while(reply.more);
 
   printf("\n");
+  if (reply.err) return(1); else return(0);
 }
 
 char *local_help = 
 "Additional local mconsole commands:\n\
     quit - Quit mconsole\n\
     switch <socket-name> - Switch control to the given machine\n\
-    log -f <filename> - use contents of <filename> as UML log messages\n";
+    log -f <filename> - use contents of <filename> as UML log messages\n\
+    mconsole-version - version of this mconsole program\n";
 
-static void help_cmd(int fd, char *command)
+static int help_cmd(int fd, char *command)
 {
   default_cmd(fd, command);
   printf("%s", local_help);
+  return(0);
 }
 
-static void switch_cmd(int fd, char *command)
+static int switch_cmd(int fd, char *command)
 {
   char *ptr;
 
   ptr = &command[strlen("switch")];
   while(isspace(*ptr)) ptr++;
-  if(switch_common(ptr)) return;
+  if(switch_common(ptr)) return(1);
   printf("Switched to '%s'\n", ptr);
+  return(0);
 }
 
-static void log_cmd(int fd, char *command)
+static int log_cmd(int fd, char *command)
 {
   int len, max, chunk, input_fd;
   char *ptr, buf[sizeof(((struct mconsole_request *) NULL)->data)];
@@ -299,16 +331,23 @@
       ptr += chunk;
     }
   }
+  return(0);
 }
 
-static void quit_cmd(int fd, char *command)
+static int quit_cmd(int fd, char *command)
 {
   exit(0);
 }
 
+static int mversion_cmd(int fd, char *command)
+{
+  printf("uml_mconsole client version %d\n",MCONSOLE_VERSION);
+  return(0);
+}
+
 struct cmd {
   char *command;
-  void (*proc)(int, char *);
+  int (*proc)(int, char *);
 };
 
 static struct cmd cmds[] = {
@@ -316,14 +355,16 @@
   { "help", help_cmd },
   { "switch", switch_cmd },
   { "log", log_cmd },
+  { "mconsole-version", mversion_cmd },
   { NULL, default_cmd }
+  /* default_cmd means "send it to the UML" */
 };
 
 /* sends a command */
 int issue_command(int fd, char *command)
 {
   char *ptr;
-  int i;
+  int i=0,ret=0;
 
   /* Trim trailing spaces left by readline's filename completion */
   ptr = &command[strlen(command) - 1];
@@ -332,20 +373,20 @@
   for(i = 0; i < sizeof(cmds)/sizeof(cmds[0]); i++){
     if((cmds[i].command == NULL) || 
        !strncmp(cmds[i].command, command, strlen(cmds[i].command))){
-      (*cmds[i].proc)(fd, command);
+      ret=(int)(*cmds[i].proc)(fd, command);
       break;
     }
   }
     
-  /* in future, return command status */
-  return 0;
+  return(ret);
+
 }
 
 /* sends a command in argv style array */
 int issue_commandv(int fd, char **argv)
 {
   char *command;
-  int len, i, status;
+  int len=-1, i=0, status=-2;
 
   len = 1;  /* space for trailing null */
   for(i = 0; argv[i] != NULL; i++)
@@ -354,7 +395,7 @@
   command = malloc(len);
   if(command == NULL){
     perror("issue_command");
-    return(-1);
+    return(1);
   }
   command[0] = '\0';
 
@@ -401,7 +442,7 @@
   }
 
   if(argc>2)
-    return issue_commandv(fd, argv+2);
+    exit(issue_commandv(fd,argv+2));
 
   while(1){
     char *command, prompt[1 + sizeof(uml_name) + 2 + 1];
@@ -416,5 +457,5 @@
     free(command);
   }
   printf("\n");
-  return(0);
+  exit(0);
 }

--dc+cDN39EJAMEtIO--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
