Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyfYs-0005lH-UF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:23:02 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyfYq-0006ec-6g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:23:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
References: <20060116171447.GA15932@suse.de>
In-Reply-To: <20060116171447.GA15932@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zbEzDPuiTRg754p"
Message-Id: <200601170222.59415.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 02:22:59 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Olaf Hering <olh@suse.de>

--Boundary-00=_zbEzDPuiTRg754p
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 16 January 2006 18:14, Olaf Hering wrote:
> Current Linus tree does not compile for me:
>
>
> girgendwas:~/linux-2.6.15$ gcc -Wp,-MD,arch/um/drivers/.chan_user.o.d -Wall
> -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -ffreestanding -Os -fomit-frame-pointer -D__arch_um__ -DSUBARCH=\"i386\"
> -Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback
> -Iarch/um/include  -I/home/abuild/linux-2.6.15/arch/um/kernel/skas/include
> -D_FILE_OFFSET_BITS=64 -march=i686 -mpreferred-stack-boundary=2
> -D_GNU_SOURCE -D_LARGEFILE64_SOURCE  -c -o arch/um/drivers/chan_user.o
> arch/um/drivers/chan_user.c --save-temps In file included from
> arch/um/drivers/chan_user.c:16:
> arch/um/include/kern_util.h:35: error: 'CONFIG_NR_CPUS' undeclared here
> (not in a function)
>
> It picks up the libc headers instead of the 2.6.15 ones.
Yep, that's correct, the bug is that shouldn't be using CONFIG_NR_CPUS.
> grep -E '^#[[:blank:]]+[[:digit:]]' chan_user.i

Disable CONFIG_SMP, it doesn't work well anyway, however thanks for the 
report.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_zbEzDPuiTRg754p
Content-Type: text/x-diff; charset="utf-8";
	name="uml-compilation-error-smp-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-compilation-error-smp-fix"

Index: linux-2.6.git/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/kern_util.h
+++ linux-2.6.git/arch/um/include/kern_util.h
@@ -31,8 +31,6 @@ extern int timer_irq_inited;
 extern int jail;
 extern int nsyscalls;
 
-extern struct task_struct *idle_threads[NR_CPUS];
-
 #define UML_ROUND_DOWN(addr) ((void *)(((unsigned long) addr) & PAGE_MASK))
 #define UML_ROUND_UP(addr) \
 	UML_ROUND_DOWN(((unsigned long) addr) + PAGE_SIZE - 1)
Index: linux-2.6.git/arch/um/kernel/reboot.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/reboot.c
+++ linux-2.6.git/arch/um/kernel/reboot.c
@@ -5,6 +5,7 @@
 
 #include "linux/module.h"
 #include "linux/sched.h"
+#include "asm/smp.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
Index: linux-2.6.git/include/asm-um/smp.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/smp.h
+++ linux-2.6.git/include/asm-um/smp.h
@@ -23,6 +23,8 @@ extern inline void smp_cpus_done(unsigne
 {
 }
 
+extern struct task_struct *idle_threads[NR_CPUS];
+
 #endif
 
 #endif

--Boundary-00=_zbEzDPuiTRg754p--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
