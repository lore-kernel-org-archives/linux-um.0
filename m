Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1QnfG7-0001Rn-M5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:17:23 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QnfG6-000493-W3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:17:23 +0000
Received: by vws2 with SMTP id 2so5899326vws.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 31 Jul 2011 16:17:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1312153988.18010.39.camel@i7.infradead.org>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
	<20110731225801.GD2203@ZenIV.linux.org.uk>
	<1312153988.18010.39.camel@i7.infradead.org>
Date: Mon, 1 Aug 2011 01:17:17 +0200
Message-ID: <CAFLxGvyewG70ZgU41Kmu_eOYpjZ0TVXYwYq1AfS1sXONAM6G_w@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall
	exports, not SUBARCH_i386
To: David Woodhouse <dwmw2@infradead.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Aug 1, 2011 at 1:13 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sun, 2011-07-31 at 23:58 +0100, Al Viro wrote:
>> FWIW, the next step (still not pushed there) is to move arch/um/sys-x86 =
to
>> arch/x86/um, with arch/um/os-Linux/sys-x86 becoming arch/x86/um/os-Linux,
>> Kconfig.x86 moving to arch/x86/um/Kconfig and Makefile-x86 - to
>> arch/x86/um/Makefile.defs. =A0Next after that - arch/powerpc/um (and yes,
>> it means resurrected uml/ppc port; for now - only ppc32, since I have no
>> ppc64 boxen to test on).
>
> I can give you an account on a ppc64 box if that would help...

Isn't UML on ppc broken since ages?
As I don't have a ppc box I could never test it...

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

