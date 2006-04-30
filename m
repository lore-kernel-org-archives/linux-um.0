Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaCkR-0001gm-1v for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:07 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FaCkR-0001yr-0x for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:07 -0700
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaCkN-0005ZK-4c for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:06 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060430141512.9060.39338.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 0/7] Uml fixes for 2.6.17
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
Date: Sun, 30 Apr 2006 16:15:12 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This series fixes one "regression" in the 2.6.17 cycle (the mismerge of a
patch broke some code), makes UML compile & run with GCC hardened and fixes
some regressions of the compile infrastructure - special CFLAGS settings for
some files, needed in some configurations (say with profiling enabled) weren't
applied due to bad interactions with Kbuild. Finally, we make UML compatible
with Debian settings for uml_utilities (which conform to the FHS).

From stg series:

+ uml-diagnose-64-bit-broken-padding    | uml: fix patch mismerge
+ uml-PATH-for-uml_net.patch            | uml: search from uml_net in a more
	reasonable PATH
+ uml-copy_user-inatomic-v2.patch       | uml: make copy_*_user atomic
+ uml-makefile-nicer                    | uml: use Kbuild tracking for all
	files and fix compilation output
+ uml-compile-nopic-clone-stub          | uml: fix compilation and execution
	with hardened GCC
+ uml-fix-unprofile-kbuild-interaction  | uml: cleanup unprofile expression
	and build infrastructure
+ uml-export-stack-protector-symbols    | uml: export symbols added by GCC
	hardened

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
