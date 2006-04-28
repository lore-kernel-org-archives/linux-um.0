Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZWKL-0002fI-VK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:21 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZWKL-0005VQ-U9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:22 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZWKK-0003HD-Si
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 10:00:21 -0700
Message-Id: <200604281601.k3SG17dn007532@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/6] UML - Clean up after MADVISE_REMOVE
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
Date: Fri, 28 Apr 2006 12:01:07 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The MADVISE_REMOVE-checking code didn't clean up after itself.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/process.c	2006-04-27 20:51:58.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/process.c	2006-04-28 12:20:55.000000000 -0400
@@ -206,29 +206,36 @@ int os_drop_memory(void *addr, int lengt
 int can_drop_memory(void)
 {
 	void *addr;
-	int fd;
+	int fd, ok = 0;
 
 	printk("Checking host MADV_REMOVE support...");
 	fd = create_mem_file(UM_KERN_PAGE_SIZE);
 	if(fd < 0){
 		printk("Creating test memory file failed, err = %d\n", -fd);
-		return 0;
+		goto out;
 	}
 
 	addr = mmap64(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 		      MAP_SHARED, fd, 0);
 	if(addr == MAP_FAILED){
 		printk("Mapping test memory file failed, err = %d\n", -errno);
-		return 0;
+		goto out_close;
 	}
 
 	if(madvise(addr, UM_KERN_PAGE_SIZE, MADV_REMOVE) != 0){
 		printk("MADV_REMOVE failed, err = %d\n", -errno);
-		return 0;
+		goto out_unmap;
 	}
 
 	printk("OK\n");
-	return 1;
+	ok = 1;
+
+out_unmap:
+	munmap(addr, UM_KERN_PAGE_SIZE);
+out_close:
+	close(fd);
+out:
+	return ok;
 }
 
 void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
