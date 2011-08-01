Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20110801043207.GE2203@ZenIV.linux.org.uk>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
	<20110731225801.GD2203@ZenIV.linux.org.uk>
	<1312153988.18010.39.camel@i7.infradead.org>
	<CAFLxGvyewG70ZgU41Kmu_eOYpjZ0TVXYwYq1AfS1sXONAM6G_w@mail.gmail.com>
	<20110801043207.GE2203@ZenIV.linux.org.uk>
Date: Mon, 1 Aug 2011 19:52:35 +0200
Message-ID: <CAFLxGvwxQ2VeqkDpkiVks35DHxZFvAP5nKUtD7i4Z32291otOg@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall exports, not SUBARCH_i386
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Aug 1, 2011 at 6:32 AM, Al Viro <viro@zeniv.linux.org.uk> wrote=
:
> Anyway, could you take a look at the git tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/um-header.git/,
> branch x86_merge and comment? =A0It doesn't include stuff from this
> thread (yet); what it does is
> =A0 =A0 =A0 =A0* further headers cleanups
> =A0 =A0 =A0 =A0* sys-{i386,x86_64} merged; all[1] x86-specific code t=
aken first
> to arch/um/sys-x86 and then (by final commit) to arch/x86/um. =A0IMO =
that's
> the right place for it - target-dependent code is better off not hidd=
en
> from maintainers of the target arch. =A0When we get other ports to wo=
rking
> shape, their target-specific parts ought to go into arch/<target>/um.
> =A0 =A0 =A0 =A0* hopefully saner treatment of sigcontext; should make=
 life easier
> for other ports.
>
> [1] theoretically - in reality we still have more than a few x86-isms=
 in
> "generic" um headers in arch/um/include/asm.
>

Ok, will look at it in the next few days.
"sys-{i386,x86_64} merged" sounds great!

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

