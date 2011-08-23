Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <torvalds@linux-foundation.org>) id 1Qvelw-0007fC-0m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 00:23:16 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qvels-0004df-RW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 00:23:15 +0000
Received: from mail-ww0-f53.google.com (mail-ww0-f53.google.com [74.125.82.53])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p7N0MVEm005752
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2011 17:22:33 -0700
Received: by wwf25 with SMTP id 25so5220182wwf.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2011 17:22:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E52EF2A.8060608@zytor.com>
References: <4E51D597.3060800@zytor.com> <20110822095336.GB25949@kernel.org>
	<CAObL_7F6D8nQovf+aJGiEOF1mBpBU8RwtjNA-5myxvEBRRHgsg@mail.gmail.com>
	<20110822144051.GD2946@aftab>
	<20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
	<4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk> <4E52EF2A.8060608@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Aug 2011 17:22:07 -0700
Message-ID: <CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 22, 2011 at 5:07 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Checking for SYSCALL in the vdso is cheap... the only problem is if
> someone thinks that they can copy it out of the vdso and run it, having
> special-cased SYSENTER already, but not SYSCALL. =A0The recent experience
> shows that that is apparently a very real possibility.

I don't understand why people keep harping on this "copy the vdso" thing.

Guys, IF THEY COPY THE VDSO, THEN THEY WOULD GET OUR IMPROVEMENTS!

So stop being silly.

As to comparing the IP address, that's just moronic. Why the hell
would anybody ever do something that stupid? It's expensive and not
worth it. You'd be much better off comparing the contents of the
memory at 'rip', and see if that memory contains the 'int 0x80'
instruction we would add. That automatically also gets the 'somebody
copied the vdso text' case right.

You guys seem to positively _want_ to make this a bigger issue than it
is. As far as I can tell, nobody has ever even noticed this problem
before, and we already have a trivial fix ("don't do it then") for the
case Al actually did notice.

The *only* case left as far as I can tell is the case where people do
*not* copy the vdso, but simply generate (statically and/or
dynamically with a JIT) the syscall instruction directly. And we
cannot fix that, so stop even bothering to try. The absolute best we
can do for that case is to just continue to do what we do now. WE
SIMPLY HAVE NO CHOICE.

I really don't see this as being worth this much discussion.

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

