Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgltW-0000k5-6m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 08:30:22 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgltR-000236-Qk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 08:30:18 -0800
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511281029.58116.rob@landley.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] uml: move TMP default from /tmp to /dev/shm.
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
Date: Mon, 28 Nov 2005 10:29:57 -0600
To: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Signed-off-by: Rob Landley <rob@landley.net>

UML really wants shared memory semantics form its physical memory map file,
and the place for that is /dev/shm.  So move the default, and fix the error
messages to recognize that this value can be overridden.
---
Let's try that again with wordrap off...


UML calls mmap() to allocate some "physical memory" it shares between
processes.  If we're not careful, every page of this memory that gets dirtied
is pointelessly scheduled for writeout, which means an active user mode
instance running a compiler or some such can keep the disk pegged with
unnecessary I/O and slow the rest of the system to a crawl.

Back under 2.4 there was a performance hack that if you deleted a file you had
open and mmaped, dirty pages wouldn't get written out anymore unless they were
evicted due to memory pressure.  This hack got yanked sometime during 2.5, and
now you're supposed to use tmpfs if you want file-backed memory you can dirty
without causing unnecessary write I/O.

UML assumed that /tmp would be tmpfs, but this turns out not to be the default
on the systems I checked (Fedora Core 4, Ubuntu, and Gentoo).  But all of
these systems _do_ default to having a tmpfs mount on /dev/shm, which makes
sense since tmpfs used to be shmfs.  So that's a more logical default location
for UML's physical memory file.

(You can override the default location with the TMPDIR environment variable,
but you can't create a new tmpdir mount without root access, and running UML
should never require that.)

One function is moved to another file, but the only changes are to its 
printf()s.

diff -ur linux-2.6.15-rc2/arch/um-old/os-Linux/mem.c linux-2.6.15-rc2/arch/um/os-Linux/mem.c
--- linux-2.6.15-rc2/arch/um-old/os-Linux/mem.c 2005-11-23 02:35:49.000000000 -0600
+++ linux-2.6.15-rc2/arch/um/os-Linux/mem.c 2005-11-28 09:33:21.158395976 -0600
@@ -34,7 +34,7 @@
    break;
  }
  if((dir == NULL) || (*dir == '\0'))
-  dir = "/tmp";
+  dir = "/dev/shm";
 
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
+ void *addr;
+ int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
+
+ addr = mmap(NULL, UM_KERN_PAGE_SIZE,
+      PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
+ printf("Checking PROT_EXEC mmap in %s...",tempdir);
+ fflush(stdout);
+ if(addr == MAP_FAILED){
+  err = errno;
+  perror("failed");
+  if(err == EPERM)
+   printf("%s must be not mounted noexec\n",tempdir);
+  exit(1);
+ }
+ printf("OK\n");
+ munmap(addr, UM_KERN_PAGE_SIZE);
+
+ close(fd);
+}
diff -ur linux-2.6.15-rc2/arch/um-old/os-Linux/start_up.c linux-2.6.15-rc2/arch/um/os-Linux/start_up.c
--- linux-2.6.15-rc2/arch/um-old/os-Linux/start_up.c 2005-11-23 02:35:49.000000000 -0600
+++ linux-2.6.15-rc2/arch/um/os-Linux/start_up.c 2005-11-28 09:41:04.051025600 -0600
@@ -296,29 +296,7 @@
  check_sysemu();
 }
 
-extern int create_tmp_file(unsigned long long len);
-
-static void check_tmpexec(void)
-{
- void *addr;
- int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
-
- addr = mmap(NULL, UM_KERN_PAGE_SIZE,
-      PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
- printf("Checking PROT_EXEC mmap in /tmp...");
- fflush(stdout);
- if(addr == MAP_FAILED){
-  err = errno;
-  perror("failed");
-  if(err == EPERM)
-   printf("/tmp must be not mounted noexec\n");
-  exit(1);
- }
- printf("OK\n");
- munmap(addr, UM_KERN_PAGE_SIZE);
-
- close(fd);
-}
+extern void check_tmpexec(void);
 
 void os_early_checks(void)
 {

-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
