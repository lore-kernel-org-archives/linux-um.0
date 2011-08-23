Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <amluto@gmail.com>) id 1QvtaD-0000uT-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:12:09 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QvtaC-0004ZV-Id
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:12:09 +0000
Received: by gyg4 with SMTP id 4so263879gyg.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 09:12:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
References: <4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk> <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
From: Andrew Lutomirski <luto@mit.edu>
Date: Tue, 23 Aug 2011 12:11:43 -0400
Message-ID: <CAObL_7F-E2y_cd1MK4ayBx_CqszrewSrBt6V7=ndVuBQrrmTKQ@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Aug 23, 2011 at 12:03 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 22, 2011 at 11:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> * it does SETREGS, setting eax to return value, eip to original return
>> address of syscall insn... and ebp to what it had in regs.bp. =A0I.e. the
>> damn arg6 value.
>
> Ok, I think that exhaustively explains that
>
> =A0(a) our system call restart has always worked correctly, and we're goo=
d.
>
> =A0(b) it's simply just UML that is buggy, and doesn't understand the
> subtleties about doing GETREGS at a system call.
>
> and I think that the correct and simple solution is to just teach UML
> to understand the proper logic of pt_regs during a system call (and a
> 'syscall' instruction in particular).
>
> The thing is, UML emulates 'syscall' the way the *CPU* does it, not
> the way *we* do it. That may make sense, but it's simply not correct.
>
> So I would vote very strongly against actually changing anything in
> arch/x86. This is very much an UML issue.
>
> Suggested fixes:
>
> =A0- instead of blindly doing SETREGS, just write the result registers
> individually like you suggested
>
> OR (and perhaps preferably):
>
> =A0- teach UML that when you do 'GETREGS' after a system call trapped,
> we have switched things around to match the "official system call
> order", and UML should just undo our swizzling, and do a "regs.ebp =3D
> regs.ecx" to make it be what the actual original registers were (or
> whatever the actual correct swizzle is - I didn't think that through
> very much).
>
> IOW, I think the core kernel does the right thing. Our argument
> register swizzling is odd, yes, but it's an implementation detail that
> something like uml should just have to take into account. No?
>
> Hmm?

Egads.  Does this mean that doing GETREGS and then doing SETREGS later
on with the *exact same values* is considered incorrect?  IMO, this
way lies madness.

In any case, this seems insanely overcomplicated.  I'd be less afraid
of something like my approach (which, I think, makes all of the
SYSCALL weirdness pretty much transparent to ptrace users) or of just
removing SYSCALL entirely from 32-bit code.

--Andy

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

