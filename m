Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6NMq-0004Ri-QJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 21:25:24 -0800
Received: from mta13.mail.adelphia.net ([68.168.78.44] helo=mta13.adelphia.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6NMp-0002zb-Nc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 21:25:23 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040325052515.GF12415@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [kapil@imsc.res.in: Bug#239980: kernel-patch-uml: Symbols
	reqd for translucency not exported]
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
Date: Wed, 24 Mar 2004 21:25:15 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 239980-forwarded@bugs.debian.org, kapil@imsc.res.in

----- Forwarded message from Kapil Hari Paranjape <kapil@imsc.res.in> -----

Date: Thu, 25 Mar 2004 10:31:47 +0530
From: Kapil Hari Paranjape <kapil@imsc.res.in>
Resent-From: Kapil Hari Paranjape <kapil@imsc.res.in>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#239980: kernel-patch-uml: Symbols reqd for translucency not exported

Package: kernel-patch-uml
Version: 20040216-1
Severity: normal
Tags: patch

Hello,

The symbols "strncpy_from_user_tt" and "strncpy_from_user_skas" are
required by the "translucency" module and these are not exported by the
user-mode-linux kernel.

As far as I can make out this problem exists with upstream as well.

It *is* possible that modules should be making use of different
interfaces, in which case these alternatives should be documented
somewhere.

The system seems to work fine with the minimal patch enclosed.

Regards,

Kapil.

=======uml_ksyms.diff========
--- kernel-source-2.4.24/arch/um/kernel/ksyms.c.orig	2004-03-25 10:27:19.000000000 +0530
+++ kernel-source-2.4.24/arch/um/kernel/ksyms.c	2004-03-25 10:28:25.000000000 +0530
@@ -45,11 +45,13 @@
 EXPORT_SYMBOL(handle_page_fault);
 
 #ifdef CONFIG_MODE_TT
+EXPORT_SYMBOL(strncpy_from_user_tt);
 EXPORT_SYMBOL(copy_from_user_tt);
 EXPORT_SYMBOL(copy_to_user_tt);
 #endif
 
 #ifdef CONFIG_MODE_SKAS
+EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);
 #endif
=======end of uml_ksyms.diff========

-- System Information:
Debian Release: testing/unstable
  APT prefers testing
  APT policy: (990, 'testing'), (500, 'unstable')
Architecture: i386 (i686)
Kernel: Linux 2.4.25-1-686
Locale: LANG=C, LC_CTYPE=C

Versions of packages kernel-patch-uml depends on:
ii  bash                          2.05b-14   The GNU Bourne Again SHell
ii  grep-dctrl                    2.1.3      Grep Debian package information
ii  m4                            1.4-17     a macro processing language
ii  patch                         2.5.9-1    Apply a diff file to an original

-- no debconf information

----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
