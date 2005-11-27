Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgTcr-00089c-0d for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 12:59:57 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgTcp-00049v-Mc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 12:59:57 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_54hiDNJ1dS2RKBc"
Message-Id: <200511272159.38069.blaisorblade@yahoo.it>
Subject: [uml-devel] Testing requested - [PATCH] Fixing SKAS0 compilation
	problem / TT mode bug report
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
Date: Sun, 27 Nov 2005 21:59:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_54hiDNJ1dS2RKBc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is a (hacky) proposal, alternative to Jeff's 
fix-stub-syscall6, to fix the SKAS0 compilation problem.

In fact, Jeff's patch makes the problem appear on my system (where I never 
reproduced it).

I'm going to stick this in -bs2, as it makes kernels compiled for me work 
better. So please test compiling -bs2.

As an aside, I saw this code crashing at shutdown in TT mode, from 
fs/proc/array.c:do_task_stat() :

        if (mm) {
                vsize = task_vsize(mm);
                eip = KSTK_EIP(task);
                esp = KSTK_ESP(task);
        }

Went looking and guess what? There is full crap (starting from 2.6.14, due to 
the fixes for sysrq-t IIRC):

include/asm-um/processor-i386.h

#define KSTK_EIP(tsk) KSTK_REG(tsk, EIP)
#define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
#define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)

include/asm-um/processor-generic.h

#ifdef CONFIG_MODE_SKAS
#define KSTK_REG(tsk, reg) \
        ({ union uml_pt_regs regs; \
           get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
           UPT_REG(&regs, reg); })
#else
#define KSTK_REG(tsk, reg) (0xbadbabe)
#endif

I didn't fully realize the amount of crap in the patch when I reviewed it at 
that time (but I do remember complaining about 0xbadbabe rather than 
0xdeadbeef, so I'm guilty too).

I'll restore for TT mode the 2.6.13 content (which is wrong and kills sysrq-t, 
but is better than crap).

And there's no reason for letting TT mode bitrot so much, sorry. Making UML 
work for everybody, plus having a SMP testing mode, still means keeping it 
working.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_54hiDNJ1dS2RKBc
Content-Type: text/x-diff; charset="us-ascii";
	name="uml-use-asm-preventing-ebp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-use-asm-preventing-ebp.diff"

Index: linux-2.6.14/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/skas/clone.c
+++ linux-2.6.14/arch/um/kernel/skas/clone.c
@@ -1,5 +1,6 @@
 #include <sched.h>
 #include <signal.h>
+#include <stddef.h>
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <asm/unistd.h>
@@ -39,6 +40,10 @@ stub_clone_handler(void)
 			    from->fd, from->offset);
  out:
 	/* save current result. Parent: pid; child: retcode of mmap */
+#if defined(UML_CONFIG_UML_X86) && !defined(UML_CONFIG_64BIT)
+	__asm__("movl %0, %1": : "r" (err), "g" (*(long*) (UML_CONFIG_STUB_DATA + offsetof(struct stub_data, err))));
+#else
 	from->err = err;
+#endif
 	trap_myself();
 }

--Boundary-00=_54hiDNJ1dS2RKBc--

	

	
		
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
