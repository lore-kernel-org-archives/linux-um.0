Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVPuT-00065t-T7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 05:02:02 -0700
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]
	helo=tadamune.kami.home)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVPuT-0001VD-1y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 05:02:01 -0700
Date: Tue, 19 Aug 2008 21:01:55 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20080819120155.GD7425@inferi.kami.home>
References: <20080818230509.23819.90290.reportbug@carrera.home.cobb.me.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080818230509.23819.90290.reportbug@carrera.home.cobb.me.uk>
Subject: Re: [uml-devel] [Pkg-uml-pkgs] Bug#495611:
	user-mode-linux:	page_mapcount(page) went negative!
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
To: UML-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: 495611@bugs.debian.org, Graham Cobb <g+debian@cobb.uk.net>

Hello again Jeff,

one more bug report on 2.6.26.2. It looks like .25 is affected as well
are both suffering from it.


On Tue, Aug 19, 2008 at 12:05:09AM +0100, Graham Cobb wrote:
> Package: user-mode-linux
> Version: 2.6.24-1um-1
> Severity: normal
> 
> I use Debian lenny guest environment in UML to automatically build software 
> for the Nokia Maemo environment.
> 
> The overnight all work fine using UML 2.6.24-1um-1.  However, UML 
> 2.6.25-1um-2 and UML 2.6.26-1um-2 both crash, early in each build, with
> the kernel panic shown below.  I can easily reproduce this with my automated 
> build system although I have not yet found another stress test (even doing a 
> kernel build in the guest environment) which reproduces it.
> 
> The crash details are:
> 
> Eeek! page_mapcount(page) went negative! (-1)
>   page pfn = 2cc
>   page->flags = 400
>   page->count = 1
>   page->mapping = 00000000
>   vma->vm_ops = 0x83accc8
>   vma->vm_ops->fault = special_mapping_fault+0x0/0x60
> BUG: failure at mm/rmap.c:669/page_remove_rmap()!
> Kernel panic - not syncing: BUG!
> 
> EIP: 0073:[<080a407a>] CPU: 0 Not tainted ESP: 007b:bf9ec8fc EFLAGS: 00000246
>     Not tainted
> EAX: ffffffda EBX: 00008000 ECX: 001b6000 EDX: 00000005
> ESI: 00000812 EDI: 00000004 EBP: 00000000 DS: 007b ES: 007b
> 277ebd38:  [<0809ec74>] notifier_call_chain+0x34/0x70
> 277ebd5c:  [<08311f2a>] panic+0x71/0xff
> 277ebd78:  [<080cb4e1>] page_remove_rmap+0x151/0x160
> 277ebd90:  [<080c3f99>] unmap_vmas+0x2c9/0x600
> 277ebda4:  [<08060fd3>] flush_tlb_page+0x113/0x1f0
> 277ebdf8:  [<080c7895>] unmap_region+0xa5/0x150
> 277ebe2c:  [<080c8a98>] do_munmap+0x1d8/0x290
> 277ebe58:  [<080c9544>] mmap_region+0xd4/0x590
> 277ebe90:  [<080c7230>] arch_get_unmapped_area+0x0/0x160
> 277ebeb8:  [<080b4870>] generic_file_mmap+0x0/0x60
> 277ebec4:  [<080c9c1a>] do_mmap_pgoff+0x21a/0x300
> 277ebf00:  [<08060846>] sys_mmap2+0x76/0xe0
> 277ebf30:  [<080627aa>] handle_syscall+0x8a/0xc0
> 277ebf4c:  [<080607d0>] sys_mmap2+0x0/0xe0
> 277ebf78:  [<080789ca>] userspace+0x48a/0x510
> 277ebf90:  [<08075675>] os_set_thread_area+0x25/0x50
> 277ebfec:  [<0805f72d>] fork_handler+0x5d/0x70
> 
> 
> -- System Information:
> Debian Release: lenny/sid
>   APT prefers testing
>   APT policy: (900, 'testing')
> Architecture: i386 (i686)
> 
> Kernel: Linux 2.6.25-2-686 (SMP w/1 CPU core)
> Locale: LANG=en_IE@euro, LC_CTYPE=en_IE@euro (charmap=ISO-8859-15) (ignored: LC_ALL set to en_IE@euro)
> Shell: /bin/sh linked to /bin/bash
> 
> Versions of packages user-mode-linux depends on:
> ii  uml-utilities               20070815-1.1 User-mode Linux (utility programs)
> 
> user-mode-linux recommends no packages.
> 
> Versions of packages user-mode-linux suggests:
> ii  konsole [x-terminal- 4:3.5.9.dfsg.1-2+b1 X terminal emulator for KDE
> pn  linux-patch-skas     <none>              (no description available)
> pn  rootstrap            <none>              (no description available)
> ii  rxvt [x-terminal-emu 1:2.6.4-14          VT102 terminal emulator for the X 
> pn  slirp                <none>              (no description available)
> pn  user-mode-linux-doc  <none>              (no description available)
> ii  xterm [x-terminal-em 235-1               X terminal emulator
> 
> -- no debconf information
> 
> 
> 
> _______________________________________________
> Pkg-uml-pkgs mailing list
> Pkg-uml-pkgs@lists.alioth.debian.org
> http://lists.alioth.debian.org/mailman/listinfo/pkg-uml-pkgs
> 
-- 
mattia
:wq!

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
