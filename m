Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Al3k1-0005g1-Mg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 02:13:13 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AkJ0F-0000an-QT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jan 2004 00:18:52 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Draft docs for port console channel
Message-ID: <20040124082057.GG4203@erizo.shearer.org>
References: <20040123035639.GC4203@erizo.shearer.org>
	<20040123144320.GB6768@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040123144320.GB6768@ccure.user-mode-linux.org>
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
Date: Sat, 24 Jan 2004 18:50:57 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 23, 2004 at 09:43:20AM -0500, Jeff Dike wrote:

> > 	The login program, which is receiving data from the master side of 
> > 	the pty that telnetd opened, sends the data back through this pipe
> 
> And no.  port_helper passes the actual file descriptor back to UML through
> the unix socket on fd 3.  Then, UML receives characters directly from telnetd
> without port_helper having to relay them.

Got it now. Here is a patch to port-helper that might help others.

> Otherwise, this is pretty good.

You mean apart from the fact that I missed the point entirely.

Another fumbling newbie question: why can't we just have the fd for the
unix socket for xterm connected before xterm is exec'd? Then there would
be no need for open_socket in port-helper. I'm sure there's an obvious
reason.

-- 
Dan Shearer
dan@shearer.org


--- port-helper.c.orig
+++ port-helper.c
@@ -1,3 +1,15 @@
+/* port-helper
+
+Used by the port and xterm console channels for User Mode Linux.
+
+Tells UML "here is a file descriptor for my stdin as given to me by 
+xterm or telnetd". Once UML has that (with os_rcv_fd()) UML opens it
+for read and write, and the console is functional.
+
+(c) Jeff Dike 2002-2004
+
+*/
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
@@ -8,8 +20,17 @@
 #include <sys/un.h>
 #include <sys/uio.h>
 
+/* pass the fd over an fd that is already connected to a socket */
 static void send_fd(int fd, int target)
 {
+
+  /* File descriptors are specific to a process and normally only
+     sharable with another process by inheritence with fork(). The 
+     alternative is to use sendmsg with a special flag that says 
+     "I'm knowingly giving another process information from my private 
+     file descriptor table" (SCM_RIGHTS) 
+  */
+
   char anc[CMSG_SPACE(sizeof(fd))];
   struct msghdr msg;
   struct cmsghdr *cmsg;
@@ -42,6 +63,8 @@
   }
 }
 
+/* for xterm we don't have an open socket, we only have the name
+ of a file used as a Unix socket by UML. So we need to open it. */
 static int open_socket(char *name)
 {
   struct sockaddr_un sock;
@@ -74,12 +97,17 @@
 {
   int fd;
 
-  if((argc > 1) && !strcmp(argv[1], "-uml-socket")) fd = open_socket(argv[2]);
-  else fd = 3;
+  if((argc > 1) && !strcmp(argv[1], "-uml-socket")) {
+	/* inherited a filename not an open fd */
+	fd = open_socket(argv[2]);
+  } else {
+	/* inherited fd of the listening TCP socket */
+	fd = 3;
+  }
 
   signal(SIGHUP, SIG_IGN);
   if(ioctl(0, TIOCNOTTY, 0) < 0)
-    perror("TIOCNOTTY failed");
+    perror("TIOCNOTTY failed in port-helper, check UML's exec call for xterm or telnetd");
   send_fd(0, fd);
   pause();
   return(0);


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
