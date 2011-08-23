Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <torvalds@linux-foundation.org>) id 1Qvurb-0000PS-87
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 17:34:11 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qvura-0004E1-7q
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 17:34:11 +0000
Received: from mail-ww0-f53.google.com (mail-ww0-f53.google.com [74.125.82.53])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p7NHXT6H009213
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 10:33:30 -0700
Received: by wwf25 with SMTP id 25so353101wwf.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 10:33:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110823164849.GF2203@ZenIV.linux.org.uk>
References: <4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk> <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<20110823164849.GF2203@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Aug 2011 10:33:09 -0700
Message-ID: <CA+55aFxNeK3nx+FTkBpUuENmvwgQzVCTVjZnCW7Wtr6YkPuRgg@mail.gmail.com>
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

On Tue, Aug 23, 2011 at 9:48 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Um... =A0How would it know which syscall variant had that been, to start
> with?

Just read the instruction, for chissake.

UML *already* does that, to see if it's "int80" or "sysenter" ('is_syscall(=
)').

Now, I do agree that if we had designed the ptrace interface with
these kinds of issues in mind, then we would have added a "state"
field to the thing that could have this kind of information as part of
the GETREGS interface. There is no question that that would have been
a good idea - but we have what we have.

I mean, technically, we could also have always just given "raw user
space register state" to ptrace, and then just said that "anybody who
traces system calls needs to know the exact calling conventions for
*that* kind of system call". But instead of that, we give the "cooked"
pt_regs values on read-out, to make it simpler for strace and friends.

And it's actualyl simpler for UML too. If we *didn't* give that cooked
register set information, then UML would *still* have to look at the
actual instruction in order to emulate the system call correctly
("it's sysenter, so now I need to take some of the system call
arguments from the stack"). So the fact that we do that register state
swizzling actually helps not just strace, but UML too.

It would be *nice* if we did the swizzling automatically at setregs()
time too, but we simply don't have enough information in the kernel to
do that. Again, exactly because pt_regs doesn't have a "state"
variable, when user-space does the SETREGS call, we simply don't know
whether we are in "normal" code or in some system call entry or exit
state. So the kernel does the swizzling at GETREGS time (by virtue of
always having the registers in a "canonical" state for system call
entry), but we fundamentally *cannot* to do the unswizzle, because we
don't know what the SETREGS caller actually did.

So I think the current state is actually the best we could possibly
do, with the caveat that *if* we had known about the "different system
calls have different register layouts" originally and had thought of
it, we could have added a 'state' word that the kernel could set at
GETREGS time, and use at SETREGS time to decide whether swizzling is
needed or not.

But not only would that have required time travel (ptrace existed
before the multiple system calls did), even then it's not 100% clear
that the current simpler model (with the admittedly subtle case of
implicit state and its effect on register state) isn't actually the
better solution. *Somebody* has to do the register swizzling, and the
current "kernel canonicalizes registers at read time, you need to
swizzle them if you change state" may simply be the RightThing(tm).

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

