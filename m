Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Egqr7-0001hH-4e for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 13:48:13 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Egqr2-0001OI-Df
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 13:48:13 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] uml: move TMP default from /tmp to /dev/shm.
References: <200511281029.58116.rob@landley.net>
	<20051128200524.GA23143@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0511282025560.2231@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0511282025560.2231@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9r3iDkPVe0KJJwG"
Message-Id: <200511281547.41319.rob@landley.net>
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
Date: Mon, 28 Nov 2005 15:47:40 -0600
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_9r3iDkPVe0KJJwG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 28 November 2005 13:27, Henrik Nordstrom wrote:
> On Mon, 28 Nov 2005, Jeff Dike wrote:
> > On Mon, Nov 28, 2005 at 11:52:15AM -0600, Rob Landley wrote:
> >> I sent a second copy that hopefully is less mangled.  Did it make it
> >> through ok?
> >
> > By eye, both looked the same.
>
> Not entirely, the first not only munged the whitespace, it also
> word-wrapped the diff lines..
>
> The second only munged the whitespace.
>
> Sending patches as attachments is generally safer than inline when using
> GUI mail programs.

Inline is linux-kernel policy, but here the darn thing is as an attachment.  
(No, I seem to have no control whatsoever over the type of the attachment.  I 
have checkboxes for "compress, encrypt, and sign" though, in case I can't 
figure out how to do that to the actual file...)

I need to find a real mail client, it seems.

Rob

--Boundary-00=_9r3iDkPVe0KJJwG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="devshm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="devshm.patch"

diff -ur linux-2.6.15-rc2/arch/um-old/os-Linux/mem.c linux-2.6.15-rc2/arch/um/os-Linux/mem.c
--- linux-2.6.15-rc2/arch/um-old/os-Linux/mem.c	2005-11-23 02:35:49.000000000 -0600
+++ linux-2.6.15-rc2/arch/um/os-Linux/mem.c	2005-11-28 09:33:21.158395976 -0600
@@ -34,7 +34,7 @@
 			break;
 	}
 	if((dir == NULL) || (*dir == '\0'))
-		dir = "/tmp";
+		dir = "/dev/shm";
 
 	tempdir = malloc(strlen(dir) + 2);
 	if(tempdir == NULL){
@@ -159,3 +159,26 @@
 	}
 	return(fd);
 }
+
+
+void check_tmpexec(void)
+{
+	void *addr;
+	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
+
+	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
+	printf("Checking PROT_EXEC mmap in %s...",tempdir);
+	fflush(stdout);
+	if(addr == MAP_FAILED){
+		err = errno;
+		perror("failed");
+		if(err == EPERM)
+			printf("%s must be not mounted noexec\n",tempdir);
+		exit(1);
+	}
+	printf("OK\n");
+	munmap(addr, UM_KERN_PAGE_SIZE);
+
+	close(fd);
+}
diff -ur linux-2.6.15-rc2/arch/um-old/os-Linux/start_up.c linux-2.6.15-rc2/arch/um/os-Linux/start_up.c
--- linux-2.6.15-rc2/arch/um-old/os-Linux/start_up.c	2005-11-23 02:35:49.000000000 -0600
+++ linux-2.6.15-rc2/arch/um/os-Linux/start_up.c	2005-11-28 09:41:04.051025600 -0600
@@ -296,29 +296,7 @@
 	check_sysemu();
 }
 
-extern int create_tmp_file(unsigned long long len);
-
-static void check_tmpexec(void)
-{
-	void *addr;
-	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
-
-	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
-		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
-	printf("Checking PROT_EXEC mmap in /tmp...");
-	fflush(stdout);
-	if(addr == MAP_FAILED){
-		err = errno;
-		perror("failed");
-		if(err == EPERM)
-			printf("/tmp must be not mounted noexec\n");
-		exit(1);
-	}
-	printf("OK\n");
-	munmap(addr, UM_KERN_PAGE_SIZE);
-
-	close(fd);
-}
+extern void check_tmpexec(void);
 
 void os_early_checks(void)
 {

--Boundary-00=_9r3iDkPVe0KJJwG--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
