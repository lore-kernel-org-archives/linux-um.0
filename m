Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9r6Q-00074E-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 12:14:34 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9r6O-0007Tv-Ei
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 15 Oct 2003 12:14:32 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yzZj/D9HKsWemEs"
Message-Id: <200310152116.02073.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] UML is not consistent with other ARCH's about errno
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 15 Oct 2003 21:16:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com



--Boundary-00=_yzZj/D9HKsWemEs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I posted this patch some time ago, but it was hidden inside an unrelated 
thread, then it seemed not to be noticed. So I'll repost it forever, like if 
this were the main LKML.
This patch applies to .22-[345]um
**Description**
On the i386 arch(and I think others, too) the translation from 
return value(of calls like open(), fork()...) to errno setting is done in 
include/asm-i386/unistd.h. Instead, 
UML doesn't do it. I'm posting a patch to correct this in 
include/asm-um/unistd.h for mainline, but I think that parts of the rest of 
Uml will have to be changed, probably, to conform to the new(and correct) 
semantic. However, I've checked the code and it seems that already it wants 
the "new" behaviour(the other archs already have this). Note I'm aware of the 
difference between errno and kernel_errno(understood the Makefile stuff 
concerning it).
The patch I'm posting corrects only 1 use of errno, but it's about the user 
space errno.
**Why it IS needed**
Code inside the kernel relies on this behaviour. It's a things archs must do. 
So, it will have to end up in.
**Tested**
Yes, it's straightforward and also works. Stability seems ok.
**Applies cleanly**
Yes, fine, to all the 3 versions I spoke upon. Use -p1 for patch.

**Could need changes?**
Some(not all) archs, in include/asm/unistd.h(they all have a errno handling 
path like the one this patch adds) also check that return value is >=-125. 
Quoting from the i386 one:

/* user-visible error numbers are in the range -1 - -124: see 
<asm-i386/errno.h> */

#define __syscall_return(type, res) \
do { \
        if ((unsigned long)(res) >= (unsigned long)(-125)) { \ //Note the 
check!
                errno = -(res); \
                res = -1; \
        } \
        return (type) (res); \
} while (0)
This is done somewhere, and somewhere not. Additionally, there could be some 
doubts about casts and overflows of errno.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_yzZj/D9HKsWemEs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="errno.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="errno.patch"

--- ./arch/um/kernel/helper.c.errnofix	2003-10-03 20:35:22.000000000 +0200
+++ ./arch/um/kernel/helper.c	2003-10-05 11:24:15.000000000 +0200
@@ -134,7 +134,7 @@
 		pid = waitpid(pid, &status, 0);
 		if(pid < 0)
 			printk("run_helper_thread - wait failed, errno = %d\n",
-			       -pid);
+			       -errno);
 		if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 			printk("run_helper_thread - thread returned status "
 			       "0x%x\n", status);
--- ./include/asm-um/unistd.h.errnofix	2003-10-04 15:26:51.000000000 +0200
+++ ./include/asm-um/unistd.h	2003-10-05 12:49:26.000000000 +0200
@@ -33,7 +33,10 @@
 	set_fs(KERNEL_DS);			\
 	ret = sys(args);			\
 	set_fs(fs);				\
-	return ret;
+	if (ret >= 0)				\
+		return ret;			\
+	errno = -(long)ret;			\
+	return -1;
 
 static inline long open(const char *pathname, int flags, int mode) 
 {

--Boundary-00=_yzZj/D9HKsWemEs--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
