Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSdgX-0001LN-1b for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 10:59:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GSdgT-0004b0-L1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 10:59:05 -0700
Message-Id: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 27 Sep 2006 13:57:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/5] UML - Assign random MACs to interfaces if
	necessary
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Assign a random MAC to an ethernet interface if one was not provided on
the command line.  This became pressing when distros started
bringing interfaces up before assigning IPs to them.  The previous
pattern of assigning an IP then bringing it up allowed the MAC to be
generated from the first IP assigned.  However, once the thing is
up, it's probably a bad idea to change the MAC, so the MAC stayed
initialized to fe:fd:0:0:0:0.

Now, if there is no MAC from the command line, one is generated.  We
use the microseconds from gettimeofday (20 bits), plus the low 12
bits of the pid to seed the random number generator.  random() is
called twice, with 16 bits of each result used.  I didn't want to
have to try to fill in 32 bits optimally given an arbitrary
RAND_MAX, so I just assume that it is greater than 65536 and use 16
bits of each random() return.

There is also a bit of reformatting and whitespace cleanup here.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/net_kern.c |   15 +++++++++++----
 arch/um/drivers/net_user.c |   30 ++++++++++++++++++++++++++++++
 arch/um/include/net_user.h |   19 +++++--------------
 3 files changed, 46 insertions(+), 18 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_user.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_user.c	2006-09-22 10:19:26.000000000 -0400
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
+#include <sys/time.h>
 #include "user.h"
 #include "user_util.h"
 #include "kern_util.h"
@@ -258,3 +259,32 @@ char *split_if_spec(char *str, ...)
 	va_end(ap);
 	return str;
 }
+
+void random_mac(unsigned char *addr)
+{
+	struct timeval tv;
+	long n;
+	unsigned int seed;
+
+	gettimeofday(&tv, NULL);
+
+	/* Assume that 20 bits of microseconds and 12 bits of the pid are
+	 * reasonably unpredictable.
+	 */
+	seed = tv.tv_usec | (os_getpid() << 20);
+	srandom(seed);
+
+	/* Don't care about endianness here - switching endianness
+	 * just rearranges what are hopefully random numbers.
+	 *
+	 * Assume that RAND_MAX > 65536, so random is called twice and
+	 * we use 16 bits of the result.
+	 */
+	n = random();
+	addr[2] = (n >> 8) & 255;
+	addr[3] = n % 255;
+
+	n = random();
+	addr[4] = (n >> 8) & 255;
+	addr[5] = n % 255;
+}
Index: linux-2.6.18-mm/arch/um/include/net_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_user.h	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/net_user.h	2006-09-22 10:20:11.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -26,8 +26,8 @@ struct net_user_info {
 
 extern void ether_user_init(void *data, void *dev);
 extern void dev_ip_addr(void *d, unsigned char *bin_buf);
-extern void iter_addresses(void *d, void (*cb)(unsigned char *, 
-					       unsigned char *, void *), 
+extern void iter_addresses(void *d, void (*cb)(unsigned char *,
+					       unsigned char *, void *),
 			   void *arg);
 
 extern void *get_output_buffer(int *len_out);
@@ -51,15 +51,6 @@ extern char *split_if_spec(char *str, ..
 
 extern int dev_netmask(void *d, void *m);
 
-#endif
+extern void random_mac(unsigned char *addr);
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-09-22 10:17:11.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-09-22 10:19:26.000000000 -0400
@@ -752,7 +752,8 @@ int setup_etheraddr(char *str, unsigned 
 	int i;
 
 	if(str == NULL)
-		return(0);
+		goto random;
+
 	for(i=0;i<6;i++){
 		addr[i] = simple_strtoul(str, &end, 16);
 		if((end == str) ||
@@ -760,7 +761,7 @@ int setup_etheraddr(char *str, unsigned 
 			printk(KERN_ERR 
 			       "setup_etheraddr: failed to parse '%s' "
 			       "as an ethernet address\n", str);
-			return(0);
+			goto random;
 		}
 		str = end + 1;
 	}
@@ -768,9 +769,15 @@ int setup_etheraddr(char *str, unsigned 
 		printk(KERN_ERR 
 		       "Attempt to assign a broadcast ethernet address to a "
 		       "device disallowed\n");
-		return(0);
+		goto random;
 	}
-	return(1);
+	return 1;
+
+random:
+	addr[0] = 0xfe;
+	addr[1] = 0xfd;
+	random_mac(addr);
+	return 1;
 }
 
 void dev_ip_addr(void *d, unsigned char *bin_buf)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
