Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wZIZ-0000U5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 20:36:11 -0700
Received: from flintstone.ichilton.net ([212.13.198.46])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wU4z-0000XV-43
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Sep 2003 15:01:49 -0700
Received: from roadrunner.ichilton.net (roadrunner.dmz.ichilton.local [10.10.1.3])
	by flintstone.ichilton.net (Postfix) with ESMTP id 4A734482E8
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon,  8 Sep 2003 20:50:53 +0100 (BST)
From: Ian Chilton <mailinglist@ichilton.co.uk>
Message-ID: <20030908195052.GA20529@roadrunner.ichilton.net>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UML 2.4.22-2 Compile Problem
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
Date: Mon, 8 Sep 2003 20:50:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

Trying to compile 2.4.22-2 on a new Debian (testing) host, running 2.4.22+skas3.

gcc version 3.3.1 20030626 (Debian prerelease)


Getting this:

make[1]: Leaving directory
`/home/uml/build/linux-2.4.22/arch/um/os-Linux/drivers'
ld -r  init/main.o init/version.o init/do_mounts.o \
        --start-group \
        kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
arch/um/kernel/built-in.o arch/um/sys-i386/built-in.o
arch/um/os-Linux/built-in.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o arch/um/fs/built-in.o
arch/um/drivers/built-in.o arch/um/os-Linux/drivers/drivers.o \
        net/network.o \
        /home/uml/build/linux-2.4.22/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
mv vmlinux vmlinux.o
gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free
-Wl,--wrap,calloc \
        -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
arch/um/main.o(.text.init+0x2): In function `do_uml_initcalls':
: undefined reference to `__uml_initcall_start'
arch/um/main.o(.text.init+0xb): In function `do_uml_initcalls':
: undefined reference to `__uml_initcall_end'
arch/um/main.o(.text.init+0x1f): In function `do_uml_initcalls':
: undefined reference to `__uml_initcall_end'
vmlinux.o(.text+0xe42f4): In function `mem_init':
: undefined reference to `__binary_start'
vmlinux.o(.text+0xe4307): In function `mem_init':
: undefined reference to `__binary_start'
vmlinux.o(.text+0xe5bd6): In function `do_uml_exitcalls':
: undefined reference to `__uml_exitcall_end'
vmlinux.o(.text+0xe5bdf): In function `do_uml_exitcalls':
: undefined reference to `__uml_exitcall_begin'
vmlinux.o(.text+0xe5bf3): In function `do_uml_exitcalls':
: undefined reference to `__uml_exitcall_begin'
vmlinux.o(.text+0xebb99): In function `show_trace':
: undefined reference to `_stext'
vmlinux.o(.text+0xebba5): In function `show_trace':
: undefined reference to `_etext'
vmlinux.o(.text+0xee2f7): In function `before_mem_tt':
: undefined reference to `_etext'
vmlinux.o(.text+0xee305): In function `before_mem_tt':
: undefined reference to `_stext'
vmlinux.o(.text+0xee319): In function `before_mem_tt':
: undefined reference to `_edata'
vmlinux.o(.text+0xee326): In function `before_mem_tt':
: undefined reference to `_sdata'
vmlinux.o(.text+0xee34a): In function `before_mem_tt':
: undefined reference to `__bss_start'
vmlinux.o(.text+0xee3de): In function `remap_data':
: undefined reference to `switcheroo'
vmlinux.o(.text+0xeeca4): In function `mprotect_kernel_mem':
: undefined reference to `_stext'
vmlinux.o(.text+0xeecaa): In function `mprotect_kernel_mem':
: undefined reference to `_etext'
vmlinux.o(.text+0xeecc7): In function `mprotect_kernel_mem':
: undefined reference to `_unprotected_end'
vmlinux.o(.text+0xeeccd): In function `mprotect_kernel_mem':
: undefined reference to `_edata'
vmlinux.o(.text+0xeecf2): In function `mprotect_kernel_mem':
: undefined reference to `__bss_start'
vmlinux.o(.text+0xef579): In function `do_syscall':
: undefined reference to `_stext'
vmlinux.o(.text+0xef580): In function `do_syscall':
: undefined reference to `_etext'
vmlinux.o(.text.init+0x3b): In function `checksetup':
: undefined reference to `__setup_start'
vmlinux.o(.text.init+0x82): In function `checksetup':
: undefined reference to `__setup_end'
vmlinux.o(.text.init+0x4d1): In function `start_kernel':
: undefined reference to `_etext'
vmlinux.o(.text.init+0x4da): In function `start_kernel':
: undefined reference to `_stext'
vmlinux.o(.text.init+0x519): In function `do_initcalls':
: undefined reference to `__initcall_start'
vmlinux.o(.text.init+0x527): In function `do_initcalls':
: undefined reference to `__initcall_end'
vmlinux.o(.text.init+0x3d98): In function `Usage':
: undefined reference to `__uml_help_start'
vmlinux.o(.text.init+0x3da6): In function `Usage':
: undefined reference to `__uml_help_end'
vmlinux.o(.text.init+0x3dcf): In function `Usage':
: undefined reference to `__uml_help_end'
vmlinux.o(.text.init+0x3de3): In function `uml_checksetup':
: undefined reference to `__uml_setup_start'
vmlinux.o(.text.init+0x3deb): In function `uml_checksetup':
: undefined reference to `__uml_setup_end'
vmlinux.o(.text.init+0x3e36): In function `uml_checksetup':
: undefined reference to `__uml_setup_end'
vmlinux.o(.text.init+0x3e6e): In function `uml_postsetup':
: undefined reference to `__uml_postsetup_start'
vmlinux.o(.text.init+0x3e77): In function `uml_postsetup':
: undefined reference to `__uml_postsetup_end'
vmlinux.o(.text.init+0x3e8b): In function `uml_postsetup':
: undefined reference to `__uml_postsetup_end'
vmlinux.o(__ksymtab+0xe20): undefined reference to `_end'
collect2: ld returned 1 exit status
make: *** [linux] Error 1



Thanks

--ian



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
