Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AL7pr-0000wy-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 13:20:03 -0800
Received: from snowman.net ([66.93.83.236] helo=relay.snowman.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AL7pr-0006QY-8p
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 13:20:03 -0800
Received: from ns.snowman.net (ns.snowman.net [10.10.0.2])
	by relay.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id hAFLJutg002343
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 16:19:56 -0500
Received: from ns.snowman.net (localhost [127.0.0.1])
	by ns.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id hAFLJuOu016634
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 16:19:56 -0500
Received: from localhost (localhost [[UNIX: localhost]])
	by ns.snowman.net (8.12.10/8.12.10/Debian-1) id hAFLJtL4016625
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 16:19:55 -0500
From: "Laurence J. Lane" <ljlane@debian.org>
Message-ID: <20031115211955.GA4221@absolom.libra.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Subject: [uml-devel] arch/um/sys-i386/bugs.c compile error
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
Date: Sat, 15 Nov 2003 16:19:55 -0500
To: user-mode-linux-devel@lists.sourceforge.net



--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I get the same arch/um/sys-i386/bugs.c compile error on 2.6.0-test9-1-um
and 2.4.22-6-um. Anyone have an idea of what causes the error?

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bugs

[2.4.22-6-um with a stock config ]

make[2]: Entering directory `/u0/work/linux-2.4.22/arch/um/sys-i386'
gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  -I/u0/work/linux-2.4.22/arch/um/include -I/u0/work/linux-2.4.22/arch/um/kernel/tt/include -I/u0/work/linux-2.4.22/arch/um/kernel/skas/include -D_GNU_SOURCE -c -o bugs.o bugs.c
bugs.c: In function `disable_lcall':
bugs.c:111: error: storage size of `ldt' isn't known
bugs.c:118: warning: implicit declaration of function `modify_ldt'
bugs.c:111: warning: unused variable `ldt'
make[2]: *** [bugs.o] Error 1



[2.6.0-test9-1.um stock config, with xfs and module loading disabled]

gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE   -Iarch/um/include -I/u0/work/linux-2.6.0-test9/arch/um/kernel/tt/include -I/u0/work/linux-2.6.0-test9/arch/um/kernel/skas/include -D_GNU_SOURCE -c -o arch/um/sys-i386/bugs.o arch/um/sys-i386/bugs.c
arch/um/sys-i386/bugs.c: In function `disable_lcall':
arch/um/sys-i386/bugs.c:110: error: storage size of `ldt' isn't known
arch/um/sys-i386/bugs.c:117: warning: implicit declaration of function `modify_ldt'
arch/um/sys-i386/bugs.c:110: warning: unused variable `ldt'
make[1]: *** [arch/um/sys-i386/bugs.o] Error 1


--FL5UXtIhxfXey3p5--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
