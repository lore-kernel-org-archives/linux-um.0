Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 25 Dec 2015 20:10:01 -0800
From: Josh Triplett <josh@joshtriplett.org>
Message-ID: <20151226041000.GA22571@x>
References: <1450959131-5113-1-git-send-email-mic@digikod.net>
 <20151225013409.GC12977@x>
 <567D8ED5.7000409@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <567D8ED5.7000409@digikod.net>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3] um: Fix build error and kconfig for i386
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Michal Marek <mmarek@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Dec 25, 2015 at 07:45:41PM +0100, Micka=EBl Sala=FCn wrote:
>=20
> On 25/12/2015 02:34, Josh Triplett wrote:
> > On Thu, Dec 24, 2015 at 01:12:11PM +0100, Micka=EBl Sala=FCn wrote:
> >> Fix build error by generating elfcore.o only when ELF_CORE (depend=
ing on
> >> COREDUMP) is selected:
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
> > It looks like ELF_CORE depends on COREDUMP, but not on BINFMT_ELF.
> > Should it?  What happens if you build this with ELF_CORE=3Dy and
> > BINFMT_ELF=3Dn?  Does that configuration even make sense?
>=20
> It build fine with ELF_CORE=3Dy and BINFMT_ELF=3Dn but does not seem
> useful. Nevertheless, it's the same for all architectures (cf.
> init/Kconfig): ELF_CORE only depends on COREDUMP.

As long as that builds, then this patch doesn't introduce an
un-buildable Kconfig configuration, so it seems reasonable.  Thanks
again for producing a new version.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

