Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcTB2-0007DI-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 11:42:40 -0800
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcTAx-0001qd-CW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 11:42:40 -0800
Message-ID: <437B8BA1.1020805@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
In-Reply-To: <200511161100.31053.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 16 Nov 2005 20:42:25 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

Rob Landley wrote:
> So I took the rollup patch I posted earlier (which made things work on 
> x86-64), and tried to compile it on my x86 Ubuntu "Horny Hedgehog" laptop.  I 
> had to revert the /lib64 change, of course.  (I need to come up with a good 
> fix for that.) 
> 
> I also needed to change one more thing: replacing <asm/signal.h> with 
> <signal.h> in skas-i386/stub_segv.c.  (I.E. the same kind of fix I had to 
> make for skas-x86_64/stub_segv.c.)
> 
> That got it to build.  Here's the panic and the dissassembly:
> 
> Initialized stdio console driver
> Console initialized on /dev/tty0
> Failed to open 'root_fs', errno = 2
> VFS: Mounted root (hostfs filesystem).
> Stub registers -
>         0 - 0
>         1 - 0
>         2 - 0
>         3 - 0
>         4 - 0
>         5 - 0
>         6 - 0
>         7 - 7b
>         8 - 7b
>         9 - 0
>         10 - 33
>         11 - ffffffff
>         12 - 40000c20
>         13 - 73
>         14 - 210246
>         15 - bf55ec10
>         16 - 7b
> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for 
> SIGUSR1/SIGTRAP, pid = 13213, n = 13213, errno = 0, status = 0xb7f
> 
> 
> EIP: 0073:[<40000c20>] CPU: 0 Not tainted ESP: 007b:bf55ec10 EFLAGS: 00210246
>     Not tainted
> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
> 088a7bac:  [<08080b5d>] notifier_call_chain+0x2d/0x50
> 088a7bc8:  [<080714a1>] panic+0x71/0x110
> 088a7be0:  [<0805e910>] wait_stub_done+0x100/0x190
> 088a7c60:  [<0805ea1a>] get_skas_faultinfo+0x7a/0xa0
> 088a7c70:  [<0806a081>] save_registers+0x41/0x80
> 088a7c78:  [<08060602>] user_signal+0x62/0x70
> 088a7c8c:  [<0805f0f0>] userspace+0x180/0x220
> 088a7cd8:  [<08055f50>] init+0x0/0x170
> 088a7ce4:  [<0805fc12>] new_thread_handler+0xf2/0x130

Oh, this implies, that registers already have been restored successfully
after processing of stub_segv!
So I guess, SIGUSR1 isn't unblocked at sigreturn or there is no SIGUSR1
in the queue for userspace (don't ask me why ...). In that case userspace
wouldn't stop at stub_segv's sigreturn, but would try to run the segfaulted
code, which again segfaults, as first segfault is unhandled yet.
If so, just handling SIGSEGV the same way as SIGUSR1 or SIGSTOP in
wait_stub_done() could work around the problem. (Not a solution, but a test
only)

> 
> 081130b0 <stub_segv_handler>:
>  81130b0:       8b 44 24 5c             mov    0x5c(%esp),%eax
>  81130b4:       8d 54 24 08             lea    0x8(%esp),%edx
>  81130b8:       a3 04 f0 ff bf          mov    %eax,0xbffff004
>  81130bd:       8b 44 24 3c             mov    0x3c(%esp),%eax
>  81130c1:       a3 00 f0 ff bf          mov    %eax,0xbffff000
>  81130c6:       8b 44 24 38             mov    0x38(%esp),%eax
>  81130ca:       a3 08 f0 ff bf          mov    %eax,0xbffff008
>  81130cf:       89 d0                   mov    %edx,%eax
>  81130d1:       89 c4                   mov    %eax,%esp
>  81130d3:       b8 77 00 00 00          mov    $0x77,%eax
>  81130d8:       cd 80                   int    $0x80
>  81130da:       c3                      ret

This looks fine.

	Bodo


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
