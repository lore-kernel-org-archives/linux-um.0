Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x3QT-00081k-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 04:46:21 -0700
Received: from mx04.covadmail.net ([63.65.120.64] helo=smtp.covadmail.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19x3QS-0003ld-75
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 04:46:20 -0700
From: Paul Giordano <giordano@covad.net>
Content-Type: text/plain
Message-Id: <1063194344.5333.6.camel@tyan.crapulence.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: uml-patch-2.6.0-test5
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
Date: Wed, 10 Sep 2003 06:45:44 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Applied to linux-2.6.0-test5-mm1, compile fails with 

arch/i386/kernel/sys_i386.c: In function `do_mmap2':
arch/i386/kernel/sys_i386.c:59: warning: passing arg 1 of
`do_mmap_pgoff' from incompatible pointer type
arch/i386/kernel/sys_i386.c:59: warning: passing arg 2 of
`do_mmap_pgoff' makes pointer from integer without a cast
arch/i386/kernel/sys_i386.c:59: error: too few arguments to function
`do_mmap_pgoff'
make[1]: *** [arch/i386/kernel/sys_i386.o] Error 1
make: *** [arch/i386/kernel] Error 2

Seems all the do_mmap_pgoff's will fail with the change made in
mmap.c.While I understand the change is to enable compilation of a uml
kernel, it really shouldn't break the normal compiles as well, should
it?

Regards,
Gio



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
