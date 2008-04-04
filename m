Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhvJ0-0004bG-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 16:26:46 -0700
Received: from fmmailgate05.web.de ([217.72.192.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhvIz-0000Vd-FE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 16:26:46 -0700
Received: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id 0804D4B2D6F8
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat,  5 Apr 2008 00:53:59 +0200 (CEST)
Date: Sat, 05 Apr 2008 00:53:57 +0200
Message-Id: <226194606@web.de>
MIME-Version: 1.0
From: devzero@web.de
Subject: [uml-devel] allyesconfig/allmodconfig broken for 2.6.25-rc8-git3
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

hi !

this maybe minor issue, but it seems that with 2.6.25-rc8-git3, allyesconfig and allmodconfig doesn`t build for ARCH=um

regards
roland


# configuration written to .config
#
scripts/kconfig/conf -s arch/um/Kconfig
  SYMLINK arch/um/include/sysdep
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
make[2]: `arch/um/sys-i386/user-offsets.s' is up to date.
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      init/main.o
In file included from arch/um/include/um_uaccess.h:10,
                 from include/asm/uaccess.h:41,
                 from include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:35,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/stat.h:60,
                 from include/linux/module.h:10,
                 from init/main.c:13:
include/asm/fixmap.h:38: error: `NR_CPUS' undeclared here (not in a function)
include/asm/fixmap.h:38: error: enumerator value for `FIX_KMAP_END' not integer constant
In file included from include/linux/rmap.h:9,
                 from init/main.c:49:
include/linux/mm.h: In function `is_vmalloc_addr':
include/linux/mm.h:249: error: `PKMAP_BASE' undeclared (first use in this function)
include/linux/mm.h:249: error: (Each undeclared identifier is reported only once
include/linux/mm.h:249: error: for each function it appears in.)
make[2]: *** [init/main.o] Error 1
make[1]: *** [init] Error 2
make: *** [linux] Error 2
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
