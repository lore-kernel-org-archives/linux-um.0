Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D55s9-0006IK-HL for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Feb 2005 09:36:57 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D55s6-0007rn-RN for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Feb 2005 09:36:57 -0800
Received: from mizar.alcor.net ([68.66.78.251]) by mta11.adelphia.net
	(InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
	id <20050226173607.OHFL5402.mta11.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 26 Feb 2005 12:36:07 -0500
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20050226173644.GG12439@alcor.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] allow jail_uml to work with a numeric uid
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
Date: Sat, 26 Feb 2005 09:36:44 -0800
To: user-mode-linux-devel@lists.sourceforge.net


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
 - mdz

--mYCpIKhGyMATD0i+
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <bock@blacknet.de>
X-Original-To: mdz@csh.rit.edu
Delivered-To: mdz@csh.rit.edu
Received: from mail.csh.rit.edu [129.21.60.6]
	by localhost with IMAP (fetchmail-6.2.5)
	for mdz@localhost (single-drop); Thu, 02 Dec 2004 10:22:31 -0800 (PST)
Received: from master.debian.org (master.debian.org [146.82.138.7])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 5EF2B924E
	for <mdz@csh.rit.edu>; Thu,  2 Dec 2004 13:21:47 -0500 (EST)
Received: from shell.blacknet.de [80.254.131.106] 
	by master.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1CZvaM-0000TM-00; Thu, 02 Dec 2004 12:21:46 -0600
Received: by shell.blacknet.de (Postfix, from userid 500)
	id 66041C9A8; Thu,  2 Dec 2004 19:48:49 +0100 (CET)
Date: Thu, 2 Dec 2004 19:48:49 +0100
From: Goetz Bock <bock@blacknet.de>
To: Matt Zimmerman <mdz@debian.org>
Subject: Re: uml-utilities-20040406-1
Message-ID: <20041202184849.GR7154@shell.blacknet.de>
References: <20041202180806.GQ7154@shell.blacknet.de>
	<20041202175103.GI5727@alcor.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20041202175103.GI5727@alcor.net>
User-Agent: Mutt/1.4.2i
X-BlackNet: somebody is watching you
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000826, version=0.93.1


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Dec 02 '04 at 09:51, Matt Zimmerman wrote:
> Could you send your changes as a patch against the current package, rather
> than a new package?

Like this?

Cu,
    Goetz.
-- 
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /       (c) 2004 Creative Commons, Attribution-ShareAlike 2.0 de
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml-utilities_20040406-1-1bg.diff"

diff -pruN uml-utilities-20040406-1/debian/changelog uml-utilities-20040406-1bg/debian/changelog
--- uml-utilities-20040406-1/debian/changelog	2004-12-02 19:19:26.000000000 +0100
+++ uml-utilities-20040406-1bg/debian/changelog	2004-12-02 19:20:12.000000000 +0100
@@ -1,3 +1,9 @@
+uml-utilities (20040406-1bg) unstable; urgency=low
+
+  * Patch from Goetz Bock to allow jail_uml to work with a numeric uid
+  
+ -- Goetz Bock <bock@blacknet.de>  Thu,  2 Dec 2004 18:16:23 -0100
+
 uml-utilities (20040406-1) unstable; urgency=low
 
   * New upstream release
diff -pruN uml-utilities-20040406-1/jail/Makefile uml-utilities-20040406-1bg/jail/Makefile
--- uml-utilities-20040406-1/jail/Makefile	2004-12-02 19:19:26.000000000 +0100
+++ uml-utilities-20040406-1bg/jail/Makefile	2004-12-02 19:20:12.000000000 +0100
@@ -1,11 +1,17 @@
-all : jail_uml
+OBJS = jail_uml.o
+BIN = jail_uml
+CFLAGS = -g -Wall
 
-install:
+SBIN_DIR ?= /usr/sbin
 
-jail_uml : jail_uml.c
+all : $(BIN)
 
-# Don't install anything as yet
-install :
+$(BIN) : $(OBJS)
+	$(CC) $(CFLAGS) -o $(BIN) $(OBJS)
 
+install : $(BIN)
+	install -d $(DESTDIR)$(SBIN_DIR)
+	install -s $(BIN) $(DESTDIR)$(SBIN_DIR)
+	
 clean :
-	rm -rf *~ jail_uml cell[0-9]* core* tty_log_cell*
+	rm -rf *~ $(BIN) $(OBJS) cell[0-9]* core* tty_log_cell*
diff -pruN uml-utilities-20040406-1/jail/jail_uml.c uml-utilities-20040406-1bg/jail/jail_uml.c
--- uml-utilities-20040406-1/jail/jail_uml.c	2003-01-22 18:46:36.000000000 +0100
+++ uml-utilities-20040406-1bg/jail/jail_uml.c	2004-12-02 19:20:12.000000000 +0100
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
@@ -21,8 +35,22 @@ int main(int argc, char **argv)
 
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
 
@@ -36,6 +64,10 @@ int main(int argc, char **argv)
     exit(1);
   }
 
+  if(setgid(gid)){
+    perror("setgid");
+    exit(1);
+  }
   if(setuid(uid)){
     perror("setuid");
     exit(1);

--RASg3xLB4tUQ4RcS--

--mYCpIKhGyMATD0i+--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
