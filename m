Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARKTb-0001Oj-6q
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:02:43 -0800
Received: from 63-255-0-99.ip.mcleodusa.net ([63.255.0.99] helo=firewall.signalbhn.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ARKTa-0004Yv-Kp
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:02:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by firewall.signalbhn.org (Postfix) with ESMTP id D308C56D5E
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue,  2 Dec 2003 17:01:43 -0700 (MST)
Received: from firewall.signalbhn.org ([127.0.0.1])
 by localhost (firewall.signalbhn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04609-09 for <user-mode-linux-devel@lists.sourceforge.net>;
 Tue,  2 Dec 2003 17:01:39 -0700 (MST)
Received: from mail.signalbhn.org (unknown [192.168.15.2])
	by firewall.signalbhn.org (Postfix) with ESMTP id 9235A56D89
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue,  2 Dec 2003 17:01:39 -0700 (MST)
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <D5F775F386413A47B8BF605603C97AF2254BE3@signal01.signalbhn.org>
From: "Chris Wiegand" <cwiegand@signalbhn.org>
Subject: [uml-devel] 2.4.23 + uml patch working??
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 2 Dec 2003 17:02:29 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

I'm trying to update my UML virtual hosts to 2.4.23, and I'm running into
this error:
 
gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-uml-patch5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH="i386"
-D_LARGEFILE64_SOURCE -I/usr/src/linux-2.4.23-uml-patch5/arch/um/include
-Derrno=kernel_errno
-I/usr/src/linux-2.4.23-uml-patch5/arch/um/kernel/tt/include
-I/usr/src/linux-2.4.23-uml-patch5/arch/um/kernel/skas/include   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=binfmt_elf  -c -o binfmt_elf.o
binfmt_elf.c
binfmt_elf.c:806: macro `ELF_PLAT_INIT' used with too many (2) args
make[2]: *** [binfmt_elf.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.23-uml-patch5/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.23-uml-patch5/fs'
make: *** [_dir_fs] Error 2
www:/usr/src/linux-2.4.23-uml-patch5#

I took a pristine 2.4.22 source tree, applied the 2.4.23 patch, then applied
the uml-patch-2.4.22-6 (or -5, tried that too). Fuzzed a little on the uml
patch but no errors. But compiling (make linux ARCH=um) fails... So for now
I'm stuck at 2.4.22 with patch 5 on the hosts... Anyone else getting this
problem? Or is there a 2.4.23 uml patch out?
 


Chris Wiegand 
Network Administrator / Programmer 
Signal Behavioral Health Network 
303.639.9320 x1016 




-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
