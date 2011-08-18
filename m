Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E1Qu80V-00083a-Uk@ZenIV.linux.org.uk>
References: <E1Qu80V-00083a-Uk@ZenIV.linux.org.uk>
Date: Thu, 18 Aug 2011 16:18:24 -0400
Message-ID: <CACqU3MWV2Zk_VpGtTeQgcK8APp0dY_z-+FR5NJ+S_yLB_yO4AQ@mail.gmail.com>
From: Arnaud Lacombe <lacombar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: Subject: [PATCH 78/91] um: switch to use of drivers/Kconfig
To: Al Viro <viro@ftp.linux.org.uk>, Greg KH <greg@kroah.com>
Cc: richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

On Thu, Aug 18, 2011 at 3:11 PM, Al Viro <viro@ftp.linux.org.uk> wrote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> =A0arch/um/Kconfig.rest =A0 =A0 =A0 =A0 =A0 | =A0 23 +---------------=
-------
> =A0drivers/char/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +++---
> =A0drivers/char/ttyprintk.c =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/input/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/isdn/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/misc/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/power/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/rtc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/tty/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/watchdog/Kconfig =A0 =A0 =A0 | =A0 =A02 +-
> =A0security/integrity/ima/Kconfig | =A0 =A02 +-
> =A0sound/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A012 files changed, 14 insertions(+), 33 deletions(-)
>
> diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
> index 0ccad0f..567eb5f 100644
> --- a/arch/um/Kconfig.rest
> +++ b/arch/um/Kconfig.rest
> @@ -2,20 +2,14 @@ source "init/Kconfig"
>
> =A0source "kernel/Kconfig.freezer"
>
> -source "drivers/block/Kconfig"
> -
> =A0source "arch/um/Kconfig.char"
>
> -source "drivers/base/Kconfig"
> +source "drivers/Kconfig"
>
> =A0source "net/Kconfig"
>
> =A0source "arch/um/Kconfig.net"
>
> -source "drivers/net/Kconfig"
> -
> -source "drivers/connector/Kconfig"
> -
> =A0source "fs/Kconfig"
>
> =A0source "security/Kconfig"
> @@ -24,19 +18,4 @@ source "crypto/Kconfig"
>
> =A0source "lib/Kconfig"
>
> -source "drivers/scsi/Kconfig"
> -
> -source "drivers/md/Kconfig"
> -
> -if BROKEN
> - =A0 =A0 =A0 source "drivers/mtd/Kconfig"
> -endif
> -
> -source "drivers/leds/Kconfig"
> -
> -#This is just to shut up some Kconfig warnings, so no prompt.
> -config INPUT
> - =A0 =A0 =A0 tristate
> - =A0 =A0 =A0 default n
> -
> =A0source "arch/um/Kconfig.debug"
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 423fd56..4364303 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -298,7 +298,7 @@ if RTC_LIB=3Dn
> =A0config RTC
> =A0 =A0 =A0 =A0tristate "Enhanced Real Time Clock Support (legacy PC =
RTC driver)"
> =A0 =A0 =A0 =A0depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC=
 && !FRV \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && !ARM && !SUPERH && !=
S390 && !AVR32 && !BLACKFIN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && !ARM && !SUPERH && !=
S390 && !AVR32 && !BLACKFIN && !UML
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0If you say Y here and create a character special f=
ile /dev/rtc with
> =A0 =A0 =A0 =A0 =A0major number 10 and minor number 135 using mknod (=
"man mknod"), you
> @@ -346,7 +346,7 @@ config JS_RTC
>
> =A0config GEN_RTC
> =A0 =A0 =A0 =A0tristate "Generic /dev/rtc emulation"
> - =A0 =A0 =A0 depends on RTC!=3Dy && !IA64 && !ARM && !M32R && !MIPS =
&& !SPARC && !FRV && !S390 && !SUPERH && !AVR32 && !BLACKFIN
> + =A0 =A0 =A0 depends on RTC!=3Dy && !IA64 && !ARM && !M32R && !MIPS =
&& !SPARC && !FRV && !S390 && !SUPERH && !AVR32 && !BLACKFIN && !UML
shouldn't all these, at some point, only depends on an ARCH-selected
HAVE_RTC-like symbols ? I know this is not the point of this patch,
but I have a few WIP patches in this area, so I'm just asking. This
dependency line is really ugly.

Thanks,
 - Arnaud

> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0If you say Y here and create a character special f=
ile /dev/rtc with
> =A0 =A0 =A0 =A0 =A0major number 10 and minor number 135 using mknod (=
"man mknod"), you
> @@ -490,7 +490,7 @@ config SCx200_GPIO
>
> =A0config PC8736x_GPIO
> =A0 =A0 =A0 =A0tristate "NatSemi PC8736x GPIO Support"
> - =A0 =A0 =A0 depends on X86_32
> + =A0 =A0 =A0 depends on X86_32 && !UML
> =A0 =A0 =A0 =A0default SCx200_GPIO =A0 =A0 # mostly N
> =A0 =A0 =A0 =A0select NSC_GPIO =A0 =A0 =A0 =A0 # needed for support r=
outines
> =A0 =A0 =A0 =A0help
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index a1f68af..f228615 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -170,7 +170,7 @@ static const struct tty_operations ttyprintk_ops =
=3D {
> =A0 =A0 =A0 =A0.ioctl =3D tpk_ioctl,
> =A0};
>
> -struct tty_port_operations null_ops =3D { };
> +static struct tty_port_operations null_ops =3D { };
>
> =A0static struct tty_driver *ttyprintk_driver;
>
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index 23e82e4..001b147 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -3,7 +3,7 @@
> =A0#
>
> =A0menu "Input device support"
> - =A0 =A0 =A0 depends on !S390
> + =A0 =A0 =A0 depends on !S390 && !UML
>
> =A0config INPUT
> =A0 =A0 =A0 =A0tristate "Generic input layer (needed for keyboard, mo=
use, ...)" if EXPERT
> diff --git a/drivers/isdn/Kconfig b/drivers/isdn/Kconfig
> index 4fb6016..a233ed5 100644
> --- a/drivers/isdn/Kconfig
> +++ b/drivers/isdn/Kconfig
> @@ -5,7 +5,7 @@
> =A0menuconfig ISDN
> =A0 =A0 =A0 =A0bool "ISDN support"
> =A0 =A0 =A0 =A0depends on NET
> - =A0 =A0 =A0 depends on !S390
> + =A0 =A0 =A0 depends on !S390 && !UML
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0ISDN ("Integrated Services Digital Network", calle=
d RNIS in France)
> =A0 =A0 =A0 =A0 =A0is a fully digital telephone service that can be u=
sed for voice and
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0a4d86c..4447ea3 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -146,6 +146,7 @@ config PHANTOM
>
> =A0config INTEL_MID_PTI
> =A0 =A0 =A0 =A0tristate "Parallel Trace Interface for MIPI P1149.7 cJ=
TAG standard"
> + =A0 =A0 =A0 depends on HAS_IOMEM
> =A0 =A0 =A0 =A0default n
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0The PTI (Parallel Trace Interface) driver directs
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 57de051..9f88641 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -70,6 +70,7 @@ config BATTERY_DS2760
>
> =A0config BATTERY_DS2780
> =A0 =A0 =A0 =A0tristate "DS2780 battery driver"
> + =A0 =A0 =A0 depends on HAS_IOMEM
> =A0 =A0 =A0 =A0select W1
> =A0 =A0 =A0 =A0select W1_SLAVE_DS2780
> =A0 =A0 =A0 =A0help
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 5a538fc..53eb4e5 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -8,7 +8,7 @@ config RTC_LIB
> =A0menuconfig RTC_CLASS
> =A0 =A0 =A0 =A0bool "Real Time Clock"
> =A0 =A0 =A0 =A0default n
> - =A0 =A0 =A0 depends on !S390
> + =A0 =A0 =A0 depends on !S390 && !UML
> =A0 =A0 =A0 =A0select RTC_LIB
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Generic RTC class support. If you say yes here, yo=
u will
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index bd7cc05..aa07914 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -1,6 +1,6 @@
> =A0config VT
> =A0 =A0 =A0 =A0bool "Virtual terminal" if EXPERT
> - =A0 =A0 =A0 depends on !S390
> + =A0 =A0 =A0 depends on !S390 && !UML
> =A0 =A0 =A0 =A0select INPUT
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0---help---
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 86b0735..be740ce 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -726,7 +726,7 @@ config SBC8360_WDT
>
> =A0config SBC7240_WDT
> =A0 =A0 =A0 =A0tristate "SBC Nano 7240 Watchdog Timer"
> - =A0 =A0 =A0 depends on X86_32
> + =A0 =A0 =A0 depends on X86_32 && !UML
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0This is the driver for the hardware watchdog found=
 on the IEI
> =A0 =A0 =A0 =A0 =A0single board computers EPIC Nano 7240 (and likely =
others). This
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/=
Kconfig
> index b6ecfd4..5294d73 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -8,7 +8,7 @@ config IMA
> =A0 =A0 =A0 =A0select CRYPTO_HMAC
> =A0 =A0 =A0 =A0select CRYPTO_MD5
> =A0 =A0 =A0 =A0select CRYPTO_SHA1
> - =A0 =A0 =A0 select TCG_TPM if !S390
> + =A0 =A0 =A0 select TCG_TPM if !S390 && !UML
> =A0 =A0 =A0 =A0select TCG_TIS if TCG_TPM
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0The Trusted Computing Group(TCG) runtime Integrity
> diff --git a/sound/Kconfig b/sound/Kconfig
> index 1fef141..261a03c 100644
> --- a/sound/Kconfig
> +++ b/sound/Kconfig
> @@ -59,7 +59,7 @@ config SOUND_OSS_CORE_PRECLAIM
>
> =A0source "sound/oss/dmasound/Kconfig"
>
> -if !M68K
> +if !M68K && !UML
>
> =A0menuconfig SND
> =A0 =A0 =A0 =A0tristate "Advanced Linux Sound Architecture"
> --
> 1.7.2.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

