Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYtoN-0006dT-Ob for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:15:59 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CYtoM-0004Z6-Fq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 14:15:59 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML 2.6.10-rc2-mm3 + incremental crashes
References: <41A6228D.4050908@fujitsu-siemens.com>
In-Reply-To: <41A6228D.4050908@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411292319.04391.blaisorblade_spam@yahoo.it>
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
Date: Mon, 29 Nov 2004 23:19:04 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 25 November 2004 19:21, Bodo Stroesser wrote:
> Have started to test with the new 2.6.10-rc2-mm3 + incrementals tree.
>
> First, it didn't compile, because there are inconsistent definitions
> for __pgd_alloc in include/linux/mm.h and arch/um/kernel/mem.c.
> I added "fastcall" in arch/um/kernel/mem.c, then the build succeeded.
>
> But now the kernel crashes on startup. Please ignore the error messages
> regarding ext3.ko. For the "first shot" I didn't update the initrd.
> But the kernel should handle the fs in ext2-mode anyway.
>
> Bodo
It seems (I've just read it in the ML, not very clearly) that this is 
addressed by:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110117212115156&w=2

I.e. it's a host kernel bug with quotas and DevFS (or whatever). The marked 
portion of the traces match.
> Error messages from SKAS:

> Call Trace:
[...]
>   [<a0073939>] invalidate_bh_lru+0x19/0x40
>   [<a007396a>] invalidate_bh_lrus+0xa/0x10
**
>   [<a009e3e8>] vfs_quota_off+0xa8/0x220
>   [<a008d231>] do_umount+0x1b1/0x1d0
>   [<a008d2b7>] sys_umount+0x67/0x90
**
>   [<a00182bb>] handle_page_fault+0x16b/0x1f0
>   [<a0018465>] segv+0x85/0x1e0
>   [<a001d53a>] execute_syscall_skas+0xda/0x120
>   [<a00172cc>] record_syscall_start+0x4c/0x60
>   [<a001d5b0>] handle_syscall+0x30/0x60
>   [<a001c7e0>] handle_trap+0x30/0x130
>   [<a001cc38>] userspace+0x188/0x1e0
>   [<a001d190>] fork_handler+0x0/0x80
>   [<a01ab228>] __restore+0x0/0x8
>   [<a001d190>] fork_handler+0x0/0x80
>   [<a01ab3e1>] __kill+0x11/0x20
>
>
>
> Error messages from TT:

> Call Trace:
[...]
**
>   [<a009e3e8>] vfs_quota_off+0xa8/0x220
>   [<a008d231>] do_umount+0x1b1/0x1d0
>   [<a008d2b7>] sys_umount+0x67/0x90
**
>   [<a001170f>] sys_execve+0x3f/0x50
>   [<a01ab474>] sigemptyset+0x24/0x40
>   [<a001aaba>] execute_syscall_tt+0xda/0x120
>   [<a00172cc>] record_syscall_start+0x4c/0x60
>   [<a001ab3f>] syscall_handler_tt+0x3f/0x70
>   [<a001bd6d>] sig_handler_common_tt+0x8d/0x110
>   [<a002e2ae>] sig_handler+0x1e/0x40
>   [<a01ab228>] __restore+0x0/0x8


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
