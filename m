Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vincent-perrier@club-internet.fr>)
	id 1MEUAx-0003AO-RJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 20:13:35 +0000
Received: from smtp22.services.sfr.fr ([93.17.128.12])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MEUAl-0003eE-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 20:13:27 +0000
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2213.sfr.fr (SMTP Server) with ESMTP id 14C9170000A5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Jun 2009 22:13:21 +0200 (CEST)
Received: from [192.168.1.3] (mol92-3-89-80-166-40.dsl.club-internet.fr
	[89.80.166.40])
	by msfrf2213.sfr.fr (SMTP Server) with ESMTP id E1E7370000A4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Jun 2009 22:13:20 +0200 (CEST)
From: Vincent Perrier <vincent-perrier@club-internet.fr>
Date: Wed, 10 Jun 2009 22:13:20 +0200
Message-Id: <1244664800.22809.31.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] Fedora core 11 and UML kernel compile
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hello,
I think I am not the first to have this problem, but just
to remind people of this problem:
Fedora 11 cannot compile uml kernels (2.6.29.4 and 2.6.30),
here is the error:
   . . .
   . . .
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/usr/bin/ld:arch/um/kernel/vmlinux.lds:1: ignoring invalid character `#'
in expression
/usr/bin/ld:arch/um/kernel/vmlinux.lds:1: syntax error
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

I have no knowledge at all of kernel compilation, so I have no idea
how to get it compiled.

Note with no link to the above problem:
I have made a virtual network creation software using UML at
http://clownix.net and with it you can mix UML and KVM machines
and on this emulated network UML is MUCH faster as far as
emulated ethernet interfaces are concerned.

On both machines, a socket is used to get into the machine ethernet
emulated interface, and as the KVM emulates real hardware (interrupts
and so-on) the throughput bandwidth is affected.
The strange thing that the "para-virtualization" of KVM ethernet
interfaces only had very little effect and did not bring it much closer
to the UML throughput.  
So I say to UML users: have no fear of KVM, UML is still the best
product to have a virtual linux over linux.

Regards 




------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

