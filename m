Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgTqd-0000xv-Nc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 11:05:07 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AgTqc-0001JT-W1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 11:05:07 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-6) with ESMTP id
	i0DJ51GU015989 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Jan 2004 20:05:01 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-5) with UUCP id
	i0DJ51MN015976 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 20:05:01 +0100
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0DItxnW027956
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Jan 2004 19:55:59 +0100
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <bu0gnf$ief$1@sea.gmane.org>
Message-ID: <87y8sbbrup.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] Re: uml-patch-2.6.0
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
Date: 13 Jan 2004 19:55:58 +0100
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Sven Köhler <skoehler@upb.de> writes:

> > The 2.6.0 UML patch is available at
> > 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.0-1.bz2
> 
> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wra
> p,calloc \
> 	-o linux arch/um/main.o vmlinux -L/usr/lib -lutil
> vmlinux(.text+0x5288): In function `mem_init':
> : undefined reference to `phys_page'
> vmlinux(.init.text+0x21f3): In function `kmap_init':
> : undefined reference to `pte_offset'
> collect2: ld returned 1 exit status

Disable CONFIG_HIGHMEM, then it does build.

I have a few more questions:

 * what is the status of kernel modules in 2.6 kernels?  It doesn't
   build without patching the kernel: One issue is some elf relocation
   defines being missing (R_386_32, R_386_PC32), making
   apply_relocate() fail to build.  The other issue is
   apply_alternatives() not being defined, making the final link fail.
   Trying to fix that, booting and trying to load modules leads to
   kernel panic.

 * Any known issues with 2.6.1 kernels?  Tried to apply the 2.6.0
   patch to 2.6.1 and fixup the one reject in arch/um/kernel/irq.c
   manually and the fs/proc/task_mmu.c build failure with a patch
   fished from this list.  But the resulting kernel fails to boot up
   the system.  I see the init start banner, then it stops.  Looking
   whats up with gdb shows that the fork syscall seems to hang in a
   endless loop, pagefaulting at the same address over and over ...

  Gerd

-- 
You have a new virus in /var/mail/kraxel


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
