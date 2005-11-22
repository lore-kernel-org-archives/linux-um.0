Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EedES-0007zH-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 10:51:08 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EedER-0001Cg-BK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Nov 2005 10:51:09 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAMKPNiZ013793
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Nov 2005 15:25:23 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200511221250.51488.rob@landley.net>
Subject: [uml-devel] How to go about debugging fork in -skas0?
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
Date: Tue, 22 Nov 2005 12:50:51 -0600
Content-Transfer-Encoding: quoted-printable
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

As I mentioned on the -user list, when I build 2.6.15-rc1 or -rc2 on my x86=
=20
laptop, it works just fine as long as PID 1 never forks.  As soon as fork()=
=20
gets called, I get the attached panic.

I'm not sure how to go about debugging this.  Is it the clone stub handler =

again, do you think?  This is an area where I don't particularly understand=
=20
how it worked in the first place.  I can go stare at 2.6.14 (which works) a=
nd=20
try to work out what changed...

Rob

EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:bfad8780 EFLAGS: 002002=
06
=A0 =A0 Not tainted
EAX: ffffffda EBX: 01200011 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 401922e8 EBP: bfad87d8 DS: 007b ES: 007b
088a787c: =A0[<08080b7d>] notifier_call_chain+0x2d/0x50
088a7898: =A0[<08071411>] panic+0x71/0x110
088a78b0: =A0[<0805e8f0>] wait_stub_done+0x100/0x190
088a791c: =A0[<0806bc25>] ptrace_setregs+0x25/0x40
088a7930: =A0[<0805f320>] copy_context_skas0+0x1b0/0x270
088a7a0c: =A0[<0805e68a>] init_new_context_skas+0x11a/0x1a0
088a7a3c: =A0[<0806f872>] copy_mm+0xd2/0x380
088a7a80: =A0[<08070455>] copy_process+0x415/0xda0
088a7aa0: =A0[<0805dcb3>] setjmp_wrapper+0x83/0x90
088a7ac4: =A0[<0805dc67>] setjmp_wrapper+0x37/0x90
088a7ae4: =A0[<0805a745>] change_signals+0x65/0x90
088a7b60: =A0[<08070e4f>] do_fork+0x6f/0x1cc
088a7b80: =A0[<0807f5b4>] kernel_sigprocmask+0x64/0x140
088a7b90: =A0[<08060ae6>] copy_to_user_skas+0x86/0xa0
088a7ba0: =A0[<08060a20>] copy_chunk_to_user+0x0/0x40
088a7bc8: =A0[<0806ce89>] sys_clone+0x79/0xa0
088a7bf4: =A0[<080601dc>] handle_syscall+0xec/0x100
088a7c64: =A0[<0805eaa8>] handle_trap+0x28/0x130
088a7c8c: =A0[<0805f114>] userspace+0x1c4/0x220
088a7cd8: =A0[<08055f50>] init+0x0/0x170
088a7ce4: =A0[<0805fbf2>] new_thread_handler+0xf2/0x130


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_idv28&alloc_id=16845&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
