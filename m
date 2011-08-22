Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <amluto@gmail.com>) id 1QvKDa-0006Ug-QB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 02:26:26 +0000
Received: from mail-pz0-f42.google.com ([209.85.210.42])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QvKDa-0002wR-3m
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 02:26:26 +0000
Received: by pzk37 with SMTP id 37so7947545pzk.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Aug 2011 19:26:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110822020737.GP2203@ZenIV.linux.org.uk>
References: <20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<20110821144352.GJ2203@ZenIV.linux.org.uk>
	<20110821164124.GL2203@ZenIV.linux.org.uk>
	<CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
	<20110822011645.GM2203@ZenIV.linux.org.uk>
	<CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
	<4E51B56F.3080301@zytor.com>
	<CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
	<20110822020737.GP2203@ZenIV.linux.org.uk>
From: Andrew Lutomirski <luto@mit.edu>
Date: Sun, 21 Aug 2011 22:26:00 -0400
Message-ID: <CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 21, 2011 at 10:07 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Aug 21, 2011 at 10:01:40PM -0400, Andrew Lutomirski wrote:
>
>> =A03. We're worried that pt_regs-using compat syscalls might want the
>> regs to appear to match the actual arguments (why?)
>
> run strace and you'll see why.
>

I'm talking about the implementations of stub32_rt_sigreturn,
sys32_rt_sigreturn, stub32_sigreturn, stub32_sigaltstack,
stub32_execve, stub32_fork, stub32_clone, stub32_vfork, and stub32_iopl.
I don't know what this has to do with strace or user ABI at all.

>> =A04. ptrace expects the "registers" when SYSCALL happens to match the
>> int 0x80 convention. =A0(This is, IMO, sick.)
>
> That's what ptrace is *for*. =A0It's there to let debuggers play with
> the program being debugged, including taking a look at the syscall
> arguments and modifying them. =A0In a predictable way, please.
>

It may be necessary, but I still think it's sick.  Especially in the
case of inlined SYSCALL, where the registers reported to ptrace do not
match any register values that ever actually existed in CPU registers.
 Too late to fix it, though.

Which still leaves the question of how to fix it.  Restarting via an
int 0x80-based helper might be the only option that leaves everything
fully functional.

--Andy

---------------------------------------------------------------------------=
---
uberSVN's rich system and user administration capabilities and model =

configuration take the hassle out of deploying and managing Subversion and =

the tools developers use with it. Learn more about uberSVN and get a free =

download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

