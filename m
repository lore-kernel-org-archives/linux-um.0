Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4SPD-0003Og-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Sep 2003 14:51:39 -0700
Received: from hannover-internet.com ([217.160.140.99])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4SPC-0003AQ-81
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 30 Sep 2003 14:51:38 -0700
Received: from alex (dsl-082-082-155-071.arcor-ip.net [82.82.155.71])
	(authenticated bits=0)
	by hannover-internet.com (8.12.9/SQL-8.12.9-18/8.12.9/8.12.9) with ESMTP id h8ULr1wh032500
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Sep 2003 23:53:04 +0200
Message-ID: <045401c3879d$06745b90$6f01a8c0@alex>
From: "Alexander Newald" <alexander@newald.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml failes to build with pcap enabled
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
Date: Tue, 30 Sep 2003 23:51:35 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hello,

I've tried to use uml with pcap but I fail to build the linux binary.

I used a clean sorce of kernel 2.4.22 from kernel.org and the corresponding
patch from the uml site.

I did:

make menuconfig ARCH=um
make linux ARCH=um

and ended up here...

make[1]: Leaving directory `/home/uml/UML/linux-2.4.22/arch/um/fs'
make
CFLAGS="-D__KERNEL__ -I/home/uml/UML/linux-2.4.22/include -Wall -Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common  -U__i386__ -Ui3
86 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -
I/home/uml/UML/linux-2.4.22/arch/um/include -Derrno=kernel_errno -I/home/uml
/UML/linux-2.4.22/arch/um/kernel/tt/include -I/home/uml/UML/linux-2.4.22/arc
h/um/kernel/skas/include " -C  arch/um/drivers
make[1]: Entering directory `/home/uml/UML/linux-2.4.22/arch/um/drivers'
make all_targets
make[2]: Entering directory `/home/uml/UML/linux-2.4.22/arch/um/drivers'
make[2]: *** No rule to make target `-L/usr/lib', needed by `pcap.o'.  Stop.
make[2]: Leaving directory `/home/uml/UML/linux-2.4.22/arch/um/drivers'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/uml/UML/linux-2.4.22/arch/um/drivers'
make: *** [_dir_arch/um/drivers] Error 2

libpcap is installed as

~/UML/linux-2.4.22> rpm -q -l libpcap
/usr/include/net/bpf.h
/usr/include/pcap-namedb.h
/usr/include/pcap.h
/usr/lib/libpcap.a
/usr/lib/libpcap.so
/usr/lib/libpcap.so.0
/usr/lib/libpcap.so.0.6.2
/usr/share/doc/packages/libpcap
/usr/share/doc/packages/libpcap/CHANGES
/usr/share/doc/packages/libpcap/CREDITS
/usr/share/doc/packages/libpcap/INSTALL.txt
/usr/share/doc/packages/libpcap/LICENSE
/usr/share/doc/packages/libpcap/README
/usr/share/doc/packages/libpcap/README.aix
/usr/share/doc/packages/libpcap/README.linux
/usr/share/doc/packages/libpcap/README.tru64
/usr/share/doc/packages/libpcap/TODO
/usr/share/man/man3/pcap.3.gz

What I'm doing wrong?

Thanks

Alexander Newald



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
