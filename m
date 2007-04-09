Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HaySi-0004Oc-M5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 11:19:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HaySh-0007Tf-2M
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 11:19:32 -0700
Date: Mon, 9 Apr 2007 14:14:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070409181440.GA7262@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Remove unused x86_64 code
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

It turns out that essentially none of the x86_64 bugs.c is needed.
So, we can delete most of it.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/sys-x86_64/bugs.c |   69 ----------------------------------------------
 1 file changed, 69 deletions(-)

Index: linux-2.6.21-mm/arch/um/sys-x86_64/bugs.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-x86_64/bugs.c	2007-04-03 11:31:25.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-x86_64/bugs.c	2007-04-05 13:26:48.000000000 -0400
@@ -4,12 +4,7 @@
  * Licensed under the GPL
  */
 
-#include "linux/sched.h"
-#include "linux/errno.h"
-#include "asm/system.h"
-#include "asm/pda.h"
 #include "sysdep/ptrace.h"
-#include "os.h"
 
 void arch_init_thread(void)
 {
@@ -23,67 +18,3 @@ int arch_handle_signal(int sig, union um
 {
 	return 0;
 }
-
-#define MAXTOKEN 64
-
-/* Set during early boot */
-int host_has_cmov = 1;
-int host_has_xmm = 0;
-
-static char token(int fd, char *buf, int len, char stop)
-{
-	int n;
-	char *ptr, *end, c;
-
-	ptr = buf;
-	end = &buf[len];
-	do {
-		n = os_read_file(fd, ptr, sizeof(*ptr));
-		c = *ptr++;
-		if(n != sizeof(*ptr)){
-			if(n == 0)
-				return 0;
-			printk("Reading /proc/cpuinfo failed, err = %d\n", -n);
-			if(n < 0)
-				return n;
-			else return -EIO;
-		}
-	} while((c != '\n') && (c != stop) && (ptr < end));
-
-	if(ptr == end){
-		printk("Failed to find '%c' in /proc/cpuinfo\n", stop);
-		return -1;
-	}
-	*(ptr - 1) = '\0';
-	return c;
-}
-
-static int find_cpuinfo_line(int fd, char *key, char *scratch, int len)
-{
-	int n;
-	char c;
-
-	scratch[len - 1] = '\0';
-	while(1){
-		c = token(fd, scratch, len - 1, ':');
-		if(c <= 0)
-			return 0;
-		else if(c != ':'){
-			printk("Failed to find ':' in /proc/cpuinfo\n");
-			return 0;
-		}
-
-		if(!strncmp(scratch, key, strlen(key)))
-			return 1;
-
-		do {
-			n = os_read_file(fd, &c, sizeof(c));
-			if(n != sizeof(c)){
-				printk("Failed to find newline in "
-				       "/proc/cpuinfo, err = %d\n", -n);
-				return 0;
-			}
-		} while(c != '\n');
-	}
-	return 0;
-}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
