Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <torvalds@linux-foundation.org>) id 1QvyOx-0001Ql-2g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 21:20:51 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvyOw-0006AQ-9m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 21:20:51 +0000
Received: from mail-ww0-f53.google.com (mail-ww0-f53.google.com [74.125.82.53])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p7NLKgh6030845
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 14:20:43 -0700
Received: by wwf25 with SMTP id 25so544817wwf.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Aug 2011 14:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E5416CB.7050604@zytor.com>
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
	<CA+55aFxNeK3nx+FTkBpUuENmvwgQzVCTVjZnCW7Wtr6YkPuRgg@mail.gmail.com>
	<4E5416CB.7050604@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Aug 2011 14:20:20 -0700
Message-ID: <CA+55aFy1nR5D73hO6Pkug-FDZ1yCc6Jg5y0VsTkJWzGhD87Bog@mail.gmail.com>
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

On Tue, Aug 23, 2011 at 2:08 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Again, can we steal one of the padding fields to use for that state
> variable? =A0We have two 16-bit padding fields; one for cs and one for ss.

We can steal them for passing the information to the user, but no, I
don't think we can use them to then take the information *from* the
user.

Somebody may well be setting up a 'pt_regs' structure on his own, and
simply not fill in the padding, resulting in random data in those
fields.

                     Linus

---------------------------------------------------------------------------=
---
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management =

Up to 160% more powerful than alternatives and 25% more efficient. =

Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

