Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FiHvY-0005h6-TY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 14:27:00 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FiHvY-0004e9-U5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 14:27:00 -0700
Received: from smtp105.plus.mail.mud.yahoo.com ([68.142.206.238])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FiHvY-0007kR-8u
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 14:27:00 -0700
Message-ID: <20060522212649.GA4946@portableric>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Task Size Init cleanup
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
Date: Mon, 22 May 2006 23:26:49 +0200
From: user-mode-linux-devel-admin@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was looking at the code of the UML and more precisely at the functions
set_task_sizes_tt and set_task_sizes_skas. I noticed that these 2
functions take a paramater (arg) which is not used : the function is
always called with the value 0.

I suppose that this value might change in the future (or even can be
configured), so I added a constant in mem_user.h file.

Also, I rounded CONFIG_HOST_TASk_SIZE to a 4M.

-- 
tyler
tyler@agat.net

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="20060522_uml_task_size_init-2.6"

diff -uprN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/um/include/mem_user.h linux-2.6-mine/arch/um/include/mem_user.h
--- linux-2.6/arch/um/include/mem_user.h	2006-05-16 19:05:32.000000000 +0200
+++ linux-2.6-mine/arch/um/include/mem_user.h	2006-05-22 23:17:02.000000000 +0200
@@ -44,6 +44,7 @@ struct iomem_region {
 extern struct iomem_region *iomem_regions;
 extern int iomem_size;
 
+#define DEFAULT_HOST_TASK_SIZE			0
 #define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 << 22) - 1))
 
 extern unsigned long host_task_size;
diff -uprN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/um/kernel/skas/mem.c linux-2.6-mine/arch/um/kernel/skas/mem.c
--- linux-2.6/arch/um/kernel/skas/mem.c	2006-05-16 19:05:32.000000000 +0200
+++ linux-2.6-mine/arch/um/kernel/skas/mem.c	2006-05-22 23:16:37.000000000 +0200
@@ -9,14 +9,14 @@
 #include "mem_user.h"
 #include "skas.h"
 
-unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out, 
+unsigned long set_task_sizes_skas(unsigned long *host_size_out, 
 				  unsigned long *task_size_out)
 {
 	/* Round up to the nearest 4M */
-	unsigned long top = ROUND_4M((unsigned long) &arg);
+	unsigned long top = ROUND_4M(DEFAULT_HOST_TASK_SIZE);
 
 #ifdef CONFIG_HOST_TASK_SIZE
-	*host_size_out = CONFIG_HOST_TASK_SIZE;
+	*host_size_out = ROUND_4M(CONFIG_HOST_TASK_SIZE);
 	*task_size_out = CONFIG_HOST_TASK_SIZE;
 #else
 	*host_size_out = top;
diff -uprN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/um/kernel/tt/mem.c linux-2.6-mine/arch/um/kernel/tt/mem.c
--- linux-2.6/arch/um/kernel/tt/mem.c	2006-05-16 19:05:32.000000000 +0200
+++ linux-2.6-mine/arch/um/kernel/tt/mem.c	2006-05-22 23:16:11.000000000 +0200
@@ -24,11 +24,11 @@ void before_mem_tt(unsigned long brk_sta
 #define SIZE ((CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS) * 0x20000000)
 #define START (CONFIG_TOP_ADDR - SIZE)
 
-unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out, 
+unsigned long set_task_sizes_tt(unsigned long *host_size_out, 
 				unsigned long *task_size_out)
 {
 	/* Round up to the nearest 4M */
-	*host_size_out = ROUND_4M((unsigned long) &arg);
+	*host_size_out = ROUND_4M(DEFAULT_HOST_TASK_SIZE);
 	*task_size_out = START;
 	return(START);
 }
diff -uprN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/um/kernel/um_arch.c linux-2.6-mine/arch/um/kernel/um_arch.c
--- linux-2.6/arch/um/kernel/um_arch.c	2006-05-16 19:05:32.000000000 +0200
+++ linux-2.6-mine/arch/um/kernel/um_arch.c	2006-05-22 23:17:46.000000000 +0200
@@ -374,7 +374,7 @@ int linux_main(int argc, char **argv)
 
 	printf("UML running in %s mode\n", mode);
 
-	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
+	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas,
 				     &host_task_size, &task_size);
 
 	/*

--wac7ysb48OaltWcw--


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services prifiris : virifiez vos nouveaux mails, lancez vos recherches et suivez l'actualiti en temps riel. 
Rendez-vous sur http://fr.yahoo.com/set



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
