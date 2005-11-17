Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ecl2a-0002Th-Id for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 06:47:08 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ecl2Z-0000cR-3Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 06:47:08 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511161811.38823.rob@landley.net>
	<20051117052622.GA12221@ccure.user-mode-linux.org>
In-Reply-To: <20051117052622.GA12221@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511170846.55886.rob@landley.net>
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
Date: Thu, 17 Nov 2005 08:46:55 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 16 November 2005 23:26, Jeff Dike wrote:
> On Wed, Nov 16, 2005 at 06:11:38PM -0600, Rob Landley wrote:
> > Sure:
> >
> > make: *** [arch/um/kernel-offsets.s] Error 1
>
> Sorry, I forgot this was x86_64.  Try the patches up to tt-options - the
> tls stuff doesn't build on x86_64 yet.
>
>     Jeff

Actually, it turns out straight 2.6.15-rc1 is unstable under -skas0 mode on my 
intel laptop.  It boots up and gives me a shell prompt (which is all I tested 
the first time), but if I type whoami (my standard "is this a UML or a host 
system prompt" test), it panics with:

sh-3.00# whoami
Stub registers -
        0 - bffff000
        1 - 1000
        2 - 3
        3 - 11
        4 - bffff000
        5 - 0
        6 - bffff000
        7 - 7b
        8 - 7b
        9 - 0
        10 - 33
        11 - ffffffff
        12 - bfffe08d
        13 - 73
        14 - 210246
        15 - bffff7fc
        16 - 7b
Kernel panic - not syncing: copy_context_skas0 : failed to wait for 
SIGUSR1/SIGTRAP, pid = 9642, n = 9642, errno = 0, status = 0xb7f


EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:bfa61780 EFLAGS: 00200206
    Not tainted
EAX: ffffffda EBX: 01200011 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 401922e8 EBP: bfa617d8 DS: 007b ES: 007b
0819387c:  [<08080b5d>] notifier_call_chain+0x2d/0x50
08193898:  [<080714a1>] panic+0x71/0x110
081938b0:  [<0805e910>] wait_stub_done+0x100/0x190
0819391c:  [<0806bc75>] ptrace_setregs+0x25/0x40
08193930:  [<0805f340>] copy_context_skas0+0x1b0/0x270
08193a0c:  [<0805e6aa>] init_new_context_skas+0x11a/0x1a0
08193a3c:  [<0806f912>] copy_mm+0xd2/0x380
08193a80:  [<0807051c>] copy_process+0x43c/0xd90
08193aa0:  [<0805dcd3>] setjmp_wrapper+0x83/0x90
08193ac4:  [<0805dc87>] setjmp_wrapper+0x37/0x90
08193ae4:  [<0805a745>] change_signals+0x65/0x90
08193b60:  [<08070edf>] do_fork+0x6f/0x1ca
08193b80:  [<0807f5a4>] kernel_sigprocmask+0x64/0x140
08193b90:  [<08060b00>] copy_to_user_skas+0x70/0xa0
08193ba0:  [<08060a50>] copy_chunk_to_user+0x0/0x40
08193bc8:  [<0806ced9>] sys_clone+0x79/0xa0
08193bf4:  [<080601fc>] handle_syscall+0xec/0x100
08193c64:  [<0805eac8>] handle_trap+0x28/0x130
08193c8c:  [<0805f134>] userspace+0x1c4/0x220
08193cd8:  [<08055f50>] init+0x0/0x170
08193ce4:  [<0805fc12>] new_thread_handler+0xf2/0x130

What do you want dumps of?  (Keep in mind this is straight -rc1.  As of 
yesterday I can't get your current patch set to even _build_ on my 32-bit x86 
ubuntu laptop.)

Let me know what you want me to try...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
