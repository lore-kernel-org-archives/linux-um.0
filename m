Return-Path: <Vineet.Gupta1@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Thu, 14 Aug 2014 23:12:53 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BA673@IN01WEMBXA.internal.synopsys.com>
References: <53ECE9DD.80004@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
 <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
 <53ED36AB.8020703@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
To: Chen Gang <gang.chen.5i5j@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com" <mattst88@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "msalter@redhat.com" <msalter@redhat.com>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>, "starvik@axis.com" <starvik@axis.com>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "takata@linux-m32r.org" <takata@linux-m32r.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>, "jonas@southpole.se" <jonas@southpole.se>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "deller@gmx.de" <deller@gmx.de>, "Benjamin" Herrenschmidt" <benh@kernel.crashing.org>, "paulus@samba.org, paulus@samba.org, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Martin" Schwidefsky" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com, heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>, "David S." Miller" <davem@davemloft.net>, "cmetcalf@tilera.com, " <cmetcalf@tilera.com>, jdike@addtoit.com" <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "chris@zankel.net" <chris@zankel.net>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>, "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>, "linux@lists.openrisc.net" <linux@lists.openrisc.net>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thursday 14 August 2014 03:22 PM, Chen Gang wrote:=0A=
> For many individual modules may need check CPU_LITTLE_ENDIAN or=0A=
> CPU_BIG_ENDIAN, which is an architecture's attribute.=0A=
>=0A=
> Or they have to list many architectures which they support, which they=0A=
> don't support. And still, it is not precise.=0A=
>=0A=
> For architecture API, endian is a main architecture's attribute which=0A=
> may be used by outside, so every architecture need let outside know=0A=
> about it, explicitly.=0A=
=0A=
I don't think that is correct. The modules need to use standard API e.g. sw=
ab=0A=
which will take care of proper endian handling anyways. Why would a module =
do=0A=
anything endian specific outside of those APIs.=0A=
=0A=
And again is this churn just theoretical or do you really have a issue at h=
and ! I=0A=
would not accept a change for ARC unless you prove that something is broken=
 (or=0A=
atleast potentially broken) !=0A=
=0A=
-Vineet=0A=

