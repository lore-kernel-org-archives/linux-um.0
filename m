Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Apws7-0003pr-Iz
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 08 Feb 2004 13:53:47 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Apws7-0001sr-9T
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 08 Feb 2004 13:53:47 -0800
From: Werner Almesberger <werner@almesberger.net>
Message-ID: <20040208185334.H9021@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] patch/RFC: add bypass for "debug" parameter
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 8 Feb 2004 18:53:34 -0300
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Since UML ursurps the "debug" parameter, we can't make the kernel
more verbose before user space runs. This patch adds a new option
"kernel" that has the same effect as the original "debug".

Slightly kludgy, but gets the job done :-)

The patch is for 2.6.1 with uml-patch-2.6.1-1.

- Werner

--- linux-2.6.1/arch/um/kernel/tt/tracer.c.orig	Sun Feb  8 18:15:18 2004
+++ linux-2.6.1/arch/um/kernel/tt/tracer.c	Sun Feb  8 18:44:51 2004
@@ -391,10 +391,19 @@
 {
 	char *next;
 
-	debug = 1;
-	*add = 0;
-	if(*line != '=') return(0);
-	line++;
+	if (!strncmp(line, "=kernel", 7)) {
+		*line = 0;
+		if (line[7] != ',')
+			return 0;
+		line += 8;
+		debug = 1;
+	}
+	else {
+		debug = 1;
+		*add = 0;
+		if(*line != '=') return(0);
+		line++;
+	}
 
 	while(line != NULL){
 		next = strchr(line, ',');
@@ -410,10 +419,15 @@
 }
 
 __uml_setup("debug", uml_debug_setup,
-"debug\n"
-"    Starts up the kernel under the control of gdb. See the \n"
-"    kernel debugging tutorial and the debugging session pages\n"
-"    at http://user-mode-linux.sourceforge.net/ for more information.\n\n"
+"debug[=kernel,go,parent]\n"
+"    \"debug=kernel\" changes the kernel log level such that debugging\n"
+"    printks are printed on the console. This is equivalent to the \"debug\"\n"
+"    option in a non-UML kernel. If \"debug=kernel\" is used with other\n"
+"    options, it must be the first option in the list.\n"
+"    The other options (or just plain \"debug\") start up the kernel under\n"
+"    the control of gdb. See the kernel debugging tutorial and the\n"
+"    debugging session pages at http://user-mode-linux.sourceforge.net/\n"
+"    for more information.\n\n"
 );
 
 static int __init uml_debugtrace_setup(char *line, int *add)

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
