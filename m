Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARJeY-00078t-HQ
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 15:09:58 -0800
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARJeY-0003KE-4L
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 15:09:58 -0800
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200312022309.hB2N9pxQ016150@hongkong.cs.nmsu.edu>
Subject: [uml-devel] compile problem iin 2.4.23 + 2.4.22-6
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
Date: Tue, 2 Dec 2003 17:09:51 -0600
To: user-mode-linux-devel@lists.sourceforge.net

During compilation I get the following error:

gcc -D__KERNEL__ -I/var/updates/linux-2.4.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -U__i386__ -Ui386 -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE -I/var/updates/linux-2.4.23/arch/um/include -Derrno=kernel_errno -I/var/updates/linux-2.4.23/arch/um/kernel/tt/include -I/var/updates/linux-2.4.23/arch/um/kernel/skas/include   -nostdinc -iwithprefix include -DKBUILD_BASENAME=binfmt_elf  -c -o binfmt_elf.o binfmt_elf.c
binfmt_elf.c:806:44: macro "ELF_PLAT_INIT" passed 2 arguments, but takes just 1
make[2]: *** [binfmt_elf.o] Error 1
make[2]: Leaving directory `/var/updates/linux-2.4.23/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/var/updates/linux-2.4.23/fs'
make: *** [_dir_fs] Error 2

It looks like every arch uses a macro like this:

 ELF_PLAT_INIT(_r, load_addr)

but uml defines it like this:

 ELF_PLAT_INIT(regs)

Has anyone updated the patch to 2.4.23 yet?  If not, I'll be backporting
the missing brk() range check from 2.4.23.

-Ross


-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
