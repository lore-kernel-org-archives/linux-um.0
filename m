Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <torvalds@linux-foundation.org>) id 1QvgIS-0002Tg-7A
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 02:00:56 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvgIR-00070b-C6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 02:00:56 +0000
Received: from mail-wy0-f175.google.com (mail-wy0-f175.google.com
	[74.125.82.175]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p7N209IH011397
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2011 19:00:11 -0700
Received: by wyf19 with SMTP id 19so5641932wyf.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2011 19:00:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110823011312.GZ2203@ZenIV.linux.org.uk>
References: <20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
	<4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk> <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Aug 2011 18:59:48 -0700
Message-ID: <CA+55aFygGyi8HRr8wNVDw5xk46D5QDOhis18u2qV-9+h0-4ReA@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 22, 2011 at 6:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> *UGH*. =A0OK,
> =A0 =A0 =A0 =A01) I'm an idiot; int_ret_from_sys_call does *not* usually =
step on
> rbp (it's callee-saved). =A0So normally ebp is left as is on the way out,
> which is why we don't see stuff getting buggered left, right and center.

Check.

And the system call restart should actually work fine too, because at
syscall entry we save %ebp *both* in the slot for ebp and ecx when we
enter the first time. So the second time, we'll re-load the third
argument from ebp again, but that's fine - it's still going to be the
right value. Yes? No?

However, I note that the cstar entrypont has a comment about not saving ebp:

 * %ebp Arg2    [note: not saved in the stack frame, should not be touched]

which sounds odd. Why don't we save it? If we take a signal handler
there, don't we want %ebp on the kernel stack in pt_regs, in order to
do everything right?

Now I'm *really* confused.

                       Linus

---------------------------------------------------------------------------=
---
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, =

user administration capabilities and model configuration. Take =

the hassle out of deploying and managing Subversion and the =

tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

