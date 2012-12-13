Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 13 Dec 2012 19:37:00 +0100
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20121213183659.GC31485@liondog.tnic>
References: <cover.1355335227.git.joe@perches.com>
 <054f8a88fe46ae0b4c2669d0e155d84c11b66115.1355335228.git.joe@perches.com>
 <20121212210959.GH8760@liondog.tnic>
 <1355347803.8538.16.camel@joe-AO722>
 <3908561D78D1C84285E8C5FCA982C28F1C969495@ORSMSX108.amr.corp.intel.com>
 <1355351039.27571.2.camel@joe-AO722>
 <20121212224550.GJ8760@liondog.tnic>
 <1355422990.13796.9.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1355422990.13796.9.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 16/26] x86: Convert print_symbol to %pSR
To: Joe Perches <joe@perches.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Jiri Kosina <trivial@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Dec 13, 2012 at 10:23:10AM -0800, Joe Perches wrote:
> m->ip is a u64 so, when compiling x86-32, there's a new warning
> "cast to pointer from integer of different size".  This isn't new
> different behavior, just a new warning.  The previous print_symbol
> took a ulong and the u64 was silently truncated.
>=20
>   CC      arch/x86/kernel/cpu/mcheck/mce.o
> arch/x86/kernel/cpu/mcheck/mce.c: In function =E2=80=98print_mce=E2=80=
=99:
> arch/x86/kernel/cpu/mcheck/mce.c:246:4: warning: cast to pointer from=
 integer of different size [-Wint-to-pointer-cast]
>=20
> If appropriate, the code could be changed to
>=20
> 	(void *)(unsigned long)m->ip

Can we explicitly cast it to what it is so that we can be explicit as t=
o
what we're casting it? IOW:

	(void *)(__u64)m->ip;

Does that even work on 32bit?

Also, does the compiler bitch about this useless cast when building wit=
h
W=3D123?

Thanks.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

