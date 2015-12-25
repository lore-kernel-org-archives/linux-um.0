Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Dec 2015 17:26:13 -0800
From: Josh Triplett <josh@joshtriplett.org>
Message-ID: <20151225012613.GA12977@x>
References: <1450875553-17717-1-git-send-email-mic@digikod.net>
 <20151223214212.GA1300@x>
 <567BE089.8030903@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <567BE089.8030903@digikod.net>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] um: Fix build error and kconfig for i386
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Dec 24, 2015 at 01:09:45PM +0100, Micka=EBl Sala=FCn wrote:
>=20
> On 23/12/2015 22:42, Josh Triplett wrote:
> > On Wed, Dec 23, 2015 at 01:59:13PM +0100, Micka=EBl Sala=FCn wrote:
> >> Fix build error by selecting COREDUMP when X86_32 is selected:
> >>
> >> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
> >> (.text+0x3e62): undefined reference to `dump_emit'
> >> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
> >> (.text+0x3eef): undefined reference to `dump_emit'
> >>
> >> Fixes: 5d2acfc7b974 ("kconfig: make allnoconfig disable options be=
hind EMBEDDED and EXPERT")
> >> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> >> Cc: Jeff Dike <jdike@addtoit.com>
> >> Cc: Richard Weinberger <richard@nod.at>
> >> Cc: Josh Triplett <josh@joshtriplett.org>
> >> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> Cc: Michal Marek <mmarek@suse.cz>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >=20
> > I suppose um doesn't care deeply about binary size, but ideally I w=
ould
> > suggest changing arch/x86/um/Makefile to make elfcore.c compiled in=
 when
> > CONFIG_ELF_CORE rather than CONFIG_BINFMT_ELF.
>=20
> That looks better! Since the first patch has been added to the mmots =
tree (but not yet in mmotm) I'll send a patch update instead of a new o=
ne reverting the first. I hope this is OK.

-mm regularly replaces patches with newer versions, so that ought to be
fine.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

