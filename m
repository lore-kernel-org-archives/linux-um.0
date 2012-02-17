MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4F3E9DC8.6090304@xenotime.net>
References: <20120217165045.2394d944d6efc37104421d2e@canb.auug.org.au>
	<4F3E9DC8.6090304@xenotime.net>
Date: Fri, 17 Feb 2012 22:32:40 +0100
Message-ID: <CAMuHMdUKDFBuWbbCp5maBQHDz7F+=XSUvf=i2nGsgnixUQSSdA@mail.gmail.com>
Subject: Re: linux-next: Tree for Feb 17 (uml)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Feb 17, 2012 at 19:34, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On 02/16/2012 09:50 PM, Stephen Rothwell wrote:
>> Changes since 20120216:
>
> uml on x86_64 (defconfig):
>
> =C2=A0CC =C2=A0 =C2=A0 =C2=A0arch/um/kernel/asm-offsets.s
> In file included from linux-next-20120217/include/linux/slab.h:12:0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from linux-next-2=
0120217/include/linux/crypto.h:23,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from
> linux-next-20120217/arch/x86/um/shared/sysdep/kernel-offsets.h:4,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from linux-next-2=
0120217/arch/um/kernel/asm-offsets.c:1:
> linux-next-20120217/include/linux/gfp.h: In function 'gfp_zonelist':
> linux-next-20120217/include/linux/gfp.h:267:1: error:
> '__enabled_CONFIG_NUMA' undeclared (first use in this function)
> linux-next-20120217/include/linux/gfp.h:267:1: note: each undeclared
> identifier is reported only once for each function it appears in
> linux-next-20120217/include/linux/gfp.h:267:1: error:
> '__enabled_CONFIG_NUMA_MODULE' undeclared (first use in this function)

That's due to the lack of CONFIG_NUMA in various archs (also m68k).

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

