Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IfP9U-0005XQ-9i for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 17:10:16 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IfP9T-0005u8-Gm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 17:10:15 -0700
Received: from [192.168.0.6] (80-195-236-49.cable.ubr02.camd.blueyonder.co.uk
	[80.195.236.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id D019E43A06
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Oct 2007 01:10:01 +0100 (BST)
Message-ID: <470C1859.5090809@nagafix.co.uk>
Date: Wed, 10 Oct 2007 01:10:01 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] 2.6.23 linkage error with ipv6 enabled
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
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I remember something similar ages ago with another IPv6 symbol no being
pulled in - can't remember how to fix it.

(.text+0x116b9): warning: Using 'getservbyname' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/lib/gcc/x86_64-pc-linux-gnu/4.1.2/../../../../lib64/libc.a(in6_addr.o):(.rodata+0x0):
multiple definition of `in6addr_any'
net/built-in.o:(.rodata+0x5680): first defined here
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHDBhZGK2zHPGK1rsRCpnOAJ9RqsCYLu2z6/5Vv0oxviCimKjy7wCfTaGl
O4jpUIpd9WuqRLwX6zablDI=
=4uon
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
