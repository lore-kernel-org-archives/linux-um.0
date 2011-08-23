Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <torvalds@linux-foundation.org>) id 1Qvwtg-0002a7-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 19:44:28 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qvwtf-0002hp-Gh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 19:44:28 +0000
Received: from mail-wy0-f175.google.com (mail-wy0-f175.google.com
	[74.125.82.175]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p7NJhoDi022712
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 12:43:52 -0700
Received: by wyf19 with SMTP id 19so540008wyf.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 12:43:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110823194103.GK2203@ZenIV.linux.org.uk>
References: <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<20110823164849.GF2203@ZenIV.linux.org.uk> <4E53FCF7.7060703@zytor.com>
	<CA+55aFyQTgXD6WeKJLvfOdsgqon=vhnhZ-h9oVpGF1uwQZkdDQ@mail.gmail.com>
	<20110823194103.GK2203@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Aug 2011 12:43:28 -0700
Message-ID: <CA+55aFzECeh_xRC=sF7qG_nc3bREqUNXXGmzcLHi4vndFvE6cg@mail.gmail.com>
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

On Tue, Aug 23, 2011 at 12:41 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> And it's not cheap - doing that on each syscall will be unpleasant...
> Frankly, I'd rather stopped telling the uml userland about vdso in such
> setups. =A0And anything that plays with SYSCALL outside of vdso... <shrug>
> we already have a "don't run it native on 32bit", adding "don't run
> it on 32bit uml on amd64 host" is not too serious. =A0At least for now...

I do agree that the solution might well be to just stop using the
non-int80 vdsos for UML. That may just solve everything in practice.

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

