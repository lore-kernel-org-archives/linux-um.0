Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBLcq-0004zm-Rt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 15:34:28 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BBLcp-0004P4-Rv
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 15:34:28 -0700
Received: from host-116-243.rev.vline.pl (HELO [172.16.13.24])
	(sikkh@[217.76.116.243]) (envelope-sender <sikkh@wp.pl>)
	by smtp.wp.pl (wp-smtpd) with RC4-MD5 encrypted SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	8 Apr 2004 00:34:19 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7IIdA4mkZhIgIT7"
Message-Id: <200404080035.39829.sikkh@wp.pl>
Subject: [uml-devel] Quick and dirty patch for 2.6.5 + 2.6.4-um1 patch v2
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
Date: Thu, 8 Apr 2004 00:35:39 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_7IIdA4mkZhIgIT7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> This is just a hack to compile 2.6.5 kernel + 2.6.4-um1 patch. As Jeff Dike 
> put it "you might post that to uml-devel for the impatient" ;), but it's not 
> official fix...

This is a revised version, Jeff Dike says this one seems ok ;).

http://kem.p.lodz.pl/~peter/2.6.5-uml1.fix2

--Boundary-00=_7IIdA4mkZhIgIT7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.5-uml1.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.5-uml1.fix"

diff -ruN linux/include/asm-i386/system.h uml/linux/include/asm-i386/system.h
--- linux/include/asm-i386/system.h	2004-04-07 23:29:03.000000000 +0200
+++ uml/linux/include/asm-i386/system.h	2004-04-07 23:24:39.000000000 +0200
@@ -243,6 +243,7 @@
 #define __HAVE_ARCH_CMPXCHG 1
 #endif
 
+#ifndef __UM_SYSTEM_I386_H 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
@@ -270,6 +271,8 @@
 	return old;
 }
 
+#endif
+
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
--- linux/arch/um/Makefile-i386	2004-04-07 23:29:20.521333000 +0200
+++ uml/linux/arch/um/Makefile-i386	2004-04-07 23:22:31.000000000 +0200
@@ -30,7 +30,7 @@
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
 	$(call filechk,$@)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts/fixdep include/config/MARKER FORCE ; 
+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE ; 
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 $(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare FORCE ; 

--Boundary-00=_7IIdA4mkZhIgIT7--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
