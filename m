Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWq7-0004b7-Ej for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:03 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWq2-0000Dq-Tp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:03 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231719.0CC3A36389@zion.localdomain>
Subject: [uml-devel] [patch 02/20] Uml: add startup check for
	mmap(...PROT_EXEC...) from /tmp.
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
Date: Thu, 04 Nov 2004 00:17:18 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


This adds a check that /tmp is not mounted noexec.  UML needs to be able
to do PROT_EXEC mmaps of temp files.  Previously, a noexec /tmp would
cause an early mysterious UML crash.
(Actually, not /tmp but $TMP, which often is the same).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/mem_user.h |    1 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/mem_user.c  |   22 ++++++++++++++++++-
 vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c   |    5 ++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff -puN arch/um/include/mem_user.h~uml-tmp-exec arch/um/include/mem_user.h
--- vanilla-linux-2.6.9/arch/um/include/mem_user.h~uml-tmp-exec	2004-11-03 23:44:37.382877056 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/mem_user.h	2004-11-03 23:44:37.387876296 +0100
@@ -67,6 +67,7 @@ extern void map_memory(unsigned long vir
 extern int protect_memory(unsigned long addr, unsigned long len, 
 			  int r, int w, int x, int must_succeed);
 extern unsigned long get_kmem_end(void);
+extern void check_tmpexec(void);
 
 #endif
 
diff -puN arch/um/kernel/mem_user.c~uml-tmp-exec arch/um/kernel/mem_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/mem_user.c~uml-tmp-exec	2004-11-03 23:44:37.383876904 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/mem_user.c	2004-11-03 23:44:37.388876144 +0100
@@ -83,6 +83,26 @@ static int create_tmp_file(unsigned long
 	return(fd);
 }
 
+void check_tmpexec(void)
+{
+	void *addr;
+	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
+
+	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
+	printf("Checking PROT_EXEC mmap in /tmp...");
+	fflush(stdout);
+	if(addr == MAP_FAILED){
+		err = errno;
+		perror("failed");
+		if(err == EPERM)
+			printf("/tmp must be not mounted noexec\n");
+		exit(1);
+	}
+	printf("OK\n");
+	munmap(addr, UM_KERN_PAGE_SIZE);
+}
+
 static int have_devanon = 0;
 
 void check_devanon(void)
@@ -111,7 +131,7 @@ static int create_anon_file(unsigned lon
 		exit(1);
 	}
 
-	addr = mmap(NULL, len, PROT_READ | PROT_WRITE , MAP_PRIVATE, fd, 0);
+	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if(addr == MAP_FAILED){
 		os_print_error((int) addr, "mapping physmem file");
 		exit(1);
diff -puN arch/um/kernel/um_arch.c~uml-tmp-exec arch/um/kernel/um_arch.c
--- vanilla-linux-2.6.9/arch/um/kernel/um_arch.c~uml-tmp-exec	2004-11-03 23:44:37.385876600 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/um_arch.c	2004-11-03 23:44:37.388876144 +0100
@@ -321,6 +321,11 @@ int linux_main(int argc, char **argv)
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 
+	/* Need to check this early because mmapping happens before the
+	 * kernel is running.
+	 */
+	check_tmpexec();
+
 	brk_start = (unsigned long) sbrk(0);
 	CHOOSE_MODE_PROC(before_mem_tt, before_mem_skas, brk_start);
 	/* Increase physical memory size for exec-shield users
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
