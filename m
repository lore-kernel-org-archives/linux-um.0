Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BETzf-0007EV-P3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 07:06:59 -0700
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BETzf-0000e4-8b
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 07:06:59 -0700
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx13.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i3GE6ou8000998
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2004 09:06:50 -0500 (CDT)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.11/8.12.11) with ESMTP id
	i3GE6mKt017896 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2004 09:06:48 -0500 (CDT)
Received: from pppz6 (pppz6 [155.161.201.186] (may be forged))
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id i3GE5K002131
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2004 22:05:20 +0800
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1815932998-1082124260=:29213"
Subject: [uml-devel] patch for 2.6.6-rc1
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
Date: Fri, 16 Apr 2004 22:04:20 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>



--0-1815932998-1082124260=:29213
Content-Type: TEXT/PLAIN; charset=US-ASCII


Here's patch to make uml compiles and run with 2.6.6-rc1.

1) Host 2.6.6-rc1 has 00-2.6.6-v0-host-SKAS2.patch.bz2 applied.

2) Guest has patch.2.6.5-uml1.fix applied, make mrproper ARCH=um, then
   patch.266rc1-1 applied.

I fudged those filed to make it compile and run. Please verify. I know
TASK_DEBUGREGS is incorrect, but since I don't use the debug mode, I
simply set to 1 to make it run, but it may not be right if you need to
debug uml. Hopefully someone can come up with a better patch.


Thanks,
Jeff
--0-1815932998-1082124260=:29213
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch.266rc1-1"
Content-ID: <Pine.LNX.4.58.0404162204200.29213@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename="patch.266rc1-1"
Content-Transfer-Encoding: quoted-printable

--- uml/arch/um/kernel/Makefile.org	Wed Mar 24 23:55:39 2004
+++ uml/arch/um/kernel/Makefile	Tue Mar 23 22:20:55 2004
@@ -38,7 +38,7 @@
 $(USER=5FOBJS) : %.o: %.c
 	$(CC) $(CFLAGS=5F$(notdir $@)) $(USER=5FCFLAGS) -c -o $@ $<
=20
-QUOTE =3D 'my $$config=3D`cat $(TOPDIR)/.config`; $$config =3D~ s/"/\\"/g =
; $$config =3D~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$=5F =3D~ s/CONFIG/$$con=
fig/; print $$=5F }'
+QUOTE =3D 'my $$config=3D`cat $(TOPDIR)/.config`; $$config =3D~ s/"/\\"/g =
; $$config =3D~ s/\\n/\\\n"\\n"/g ; while(<STDIN>) { $$=5F =3D~ s/CONFIG/$$=
config/; print $$=5F }'
=20
 $(obj)/config.o : $(obj)/config.c
=20
--- uml/arch/um/kernel/skas/process.c.org	Wed Mar 24 23:56:27 2004
+++ uml/arch/um/kernel/skas/process.c	Tue Mar 23 22:20:22 2004
@@ -24,6 +24,7 @@
 #include "sysdep/sigcontext.h"
 #include "os.h"
 #include "proc=5Fmm.h"
+#define =5F=5FSKAS=5FPTRACE=5FH
 #include "skas=5Fptrace.h"
 #include "chan=5Fuser.h"
 #include "signal=5Fuser.h"
--- uml/arch/um/kernel/process.c.org	Wed Mar 24 23:57:25 2004
+++ uml/arch/um/kernel/process.c	Tue Mar 23 22:20:27 2004
@@ -37,6 +37,7 @@
 #include "mode.h"
 #ifdef UML=5FCONFIG=5FMODE=5FSKAS
 #include "skas.h"
+#define =5F=5FSKAS=5FPTRACE=5FH
 #include "skas=5Fptrace.h"
 #endif
=20
--- uml.org/arch/um/util/mk=5Fconstants=5Fkern.c	Fri Apr 16 21:23:49 2004
+++ uml/arch/um/util/mk=5Fconstants=5Fkern.c	Fri Apr 16 11:35:02 2004
@@ -1,3 +1,4 @@
+#define =5F=5FKERNEL=5F=5F
 #include "linux/kernel.h"
 #include "linux/stringify.h"
 #include "linux/time.h"
--- uml.org/arch/um/util/mk=5Ftask=5Fkern.c	Sun Apr  4 11:36:25 2004
+++ uml/arch/um/util/mk=5Ftask=5Fkern.c	Fri Apr 16 11:58:29 2004
@@ -1,3 +1,4 @@
+#define =5F=5FKERNEL=5F=5F
 #include "linux/sched.h"
 #include "linux/stddef.h"
=20
@@ -10,7 +11,7 @@
 {
   print=5Fhead();
   print=5Fptr("TASK=5FREGS", "union uml=5Fpt=5Fregs",=20
-	    offsetof(struct task=5Fstruct, thread.regs));
+	    offsetof(struct task=5Fstruct, thread.esp0));
   print("TASK=5FPID", "int", offsetof(struct task=5Fstruct, pid));
   print=5Ftail();
   return(0);
--- uml.org/arch/um/sys-i386/util/mk=5Fthread=5Fkern.c	Sun Apr  4 11:36:14 =
2004
+++ uml/arch/um/sys-i386/util/mk=5Fthread=5Fkern.c	Fri Apr 16 12:01:33 2004
@@ -1,3 +1,4 @@
+#define =5F=5FKERNEL=5F=5F
 #include "linux/config.h"
 #include "linux/stddef.h"
 #include "linux/sched.h"
@@ -12,7 +13,7 @@
 int main(int argc, char **argv)
 {
   print=5Fhead();
-  print=5Fconstant=5Fptr("TASK=5FDEBUGREGS", THREAD=5FOFFSET(arch.debugreg=
s));
+  print=5Fconstant=5Fptr("TASK=5FDEBUGREGS", 1);
 #ifdef CONFIG=5FMODE=5FTT
   print=5Fconstant("TASK=5FEXTERN=5FPID", "int", THREAD=5FOFFSET(mode.tt.e=
xtern=5Fpid));
 #endif
--- uml.org/arch/um/kernel/physmem.c	Fri Apr 16 21:23:49 2004
+++ uml/arch/um/kernel/physmem.c	Fri Apr 16 12:01:56 2004
@@ -285,7 +285,7 @@
 		p =3D &map[i];
 		set=5Fpage=5Fcount(p, 0);
 		SetPageReserved(p);
-		INIT=5FLIST=5FHEAD(&p->list);
+		INIT=5FLIST=5FHEAD(&p->lru);
 	}
=20
 	mem=5Fmap =3D map;
--- uml.org/kernel/sched.c	Fri Apr 16 21:23:00 2004
+++ uml/kernel/sched.c	Fri Apr 16 12:19:34 2004
@@ -225,12 +225,14 @@
 #define task=5Frq(p)		cpu=5Frq(task=5Fcpu(p))
 #define cpu=5Fcurr(cpu)		(cpu=5Frq(cpu)->curr)
=20
+/*
 extern unsigned long =5F=5Fscheduling=5Ffunctions=5Fstart=5Fhere;
 extern unsigned long =5F=5Fscheduling=5Ffunctions=5Fend=5Fhere;
 const unsigned long scheduling=5Ffunctions=5Fstart=5Fhere =3D
 			(unsigned long)&=5F=5Fscheduling=5Ffunctions=5Fstart=5Fhere;
 const unsigned long scheduling=5Ffunctions=5Fend=5Fhere =3D
 			(unsigned long)&=5F=5Fscheduling=5Ffunctions=5Fend=5Fhere;
+*/
=20
 /*
  * Default context-switch locking:



--0-1815932998-1082124260=:29213
Content-Type: APPLICATION/octet-stream; name="00-2.6.6-v0-host-SKAS2.patch.bz2"
Content-ID: <Pine.LNX.4.58.0404162204201.29213@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename="00-2.6.6-v0-host-SKAS2.patch.bz2"
Content-Transfer-Encoding: base64

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
XnIHMGVKMErK2lSnzEnnJMPtF3JFOFCQzQOScA==

--0-1815932998-1082124260=:29213
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch.2.6.5-uml1.fix"
Content-ID: <Pine.LNX.4.58.0404162204202.29213@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: attachment; filename="patch.2.6.5-uml1.fix"
Content-Transfer-Encoding: quoted-printable

diff -ruN linux/include/asm-i386/system.h uml/linux/include/asm-i386/system=
.h
--- linux/include/asm-i386/system.h	2004-04-07 23:29:03.000000000 +0200
+++ uml/linux/include/asm-i386/system.h	2004-04-07 23:24:39.000000000 +0200
@@ -243,6 +243,7 @@
 #define =5F=5FHAVE=5FARCH=5FCMPXCHG 1
 #endif
=20
+#ifndef =5F=5FUM=5FSYSTEM=5FI386=5FH=20
 static inline unsigned long =5F=5Fcmpxchg(volatile void *ptr, unsigned lon=
g old,
 				      unsigned long new, int size)
 {
@@ -270,6 +271,8 @@
 	return old;
 }
=20
+#endif
+
 #define cmpxchg(ptr,o,n)\
 	((=5F=5Ftypeof=5F=5F(*(ptr)))=5F=5Fcmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
--- linux/arch/um/Makefile-i386	2004-04-07 23:29:20.521333000 +0200
+++ uml/linux/arch/um/Makefile-i386	2004-04-07 23:22:31.000000000 +0200
@@ -30,7 +30,7 @@
 $(SYS=5FDIR)/thread.h: $(SYS=5FUTIL=5FDIR)/mk=5Fthread=20
 	$(call filechk,$@)
=20
-$(SYS=5FUTIL=5FDIR)/mk=5Fsc: scripts/fixdep include/config/MARKER FORCE ; =

+$(SYS=5FUTIL=5FDIR)/mk=5Fsc: scripts/basic/fixdep include/config/MARKER FO=
RCE ;=20
 	$(Q)$(MAKE) $(build)=3D$(SYS=5FUTIL=5FDIR) $@
=20
 $(SYS=5FUTIL=5FDIR)/mk=5Fthread: $(ARCH=5FSYMLINKS) $(GEN=5FHEADERS) sys=
=5Fprepare FORCE ;=20

--0-1815932998-1082124260=:29213--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
