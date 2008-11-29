Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <balbir@linux.vnet.ibm.com>) id 1L6Mkz-00069M-9K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 10:08:57 +0000
Received: from e28smtp06.in.ibm.com ([59.145.155.6])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L6Mkt-0004DR-BZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 10:08:57 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id mATA8lmq020814
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Nov 2008 15:38:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mATA85Iu2666666 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Nov 2008 15:38:05 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id mATA8l6a029731
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Nov 2008 21:08:47 +1100
Date: Sat, 29 Nov 2008 15:38:30 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
Message-ID: <20081129100830.GA24128@balbir.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
Reply-To: balbir@linux.vnet.ibm.com
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
a big overrun bug reported on UML bootup.

Reported-by: Vikas K Managutte <vikki.km@gmail.com>
Reported-by: Sarvesh Kumar Lal Das <skldas@gmail.com>
Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
---

 arch/um/drivers/mconsole_kern.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/mconsole_kern.c~fix-uml-buggy-socket-creation arch/um/drivers/mconsole_kern.c
--- linux-2.6.28-rc6/arch/um/drivers/mconsole_kern.c~fix-uml-buggy-socket-creation	2008-11-29 15:29:04.000000000 +0530
+++ linux-2.6.28-rc6-balbir/arch/um/drivers/mconsole_kern.c	2008-11-29 15:32:23.000000000 +0530
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/utsname.h>
+#include <linux/socket.h>
+#include <linux/un.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
@@ -785,7 +787,7 @@ static int __init mconsole_init(void)
 	/* long to avoid size mismatch warnings from gcc */
 	long sock;
 	int err;
-	char file[256];
+	char file[UNIX_PATH_MAX];
 
 	if (umid_file_name("mconsole", file, sizeof(file)))
 		return -1;
_

-- 
	Balbir

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
