Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20101207072919.GA8511@falooley.org>
References: <22c797d00709272118i33d32b9dy93d5f5ec8f8edd30@mail.gmail.com>
	<20071024011712.GA3762@falooley.org>
	<1193208689.26096.48.camel@pmac.infradead.org>
	<20071227181524.GA19051@falooley.org>
	<20071228174853.GA4252@uranus.ravnborg.org>
	<20101207072919.GA8511@falooley.org>
Date: Tue, 7 Dec 2010 10:39:41 +0100
Message-ID: <AANLkTineLxHdcDKZEUGiqVNAauSX_xyQrs49kKaqhiWo@mail.gmail.com>
Subject: Re: [PATCH] mtd: allow mtd and jffs2 when ARCH=um
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Lunz <lunz@acm.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, David Woodhouse <dwmw2@infradead.org>, atom ota <atomota@sleepyhammer.com>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, Rob Landley <rob@landley.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Dec 7, 2010 at 8:29 AM, Jason Lunz <lunz@acm.org> wrote:
>
> Allow parts of drivers/mtd to compile on uml by pushing the HAS_IOMEM
> dependencies down closer to the parts of mtd that actually need it.
> This allows enough of mtd to build to let jffs2 be used on uml.
>
> Signed-off-by: Jason Lunz <lunz@acm.org>
> ---
> =EF=BF=BDarch/um/Kconfig.rest =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD| =
=EF=BF=BD =EF=BF=BD4 +---
> =EF=BF=BDdrivers/mtd/Kconfig =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD | =
=EF=BF=BD =EF=BF=BD1 -
> =EF=BF=BDdrivers/mtd/Makefile =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD| =
=EF=BF=BD =EF=BF=BD3 ++-
> =EF=BF=BDdrivers/mtd/chips/Kconfig =EF=BF=BD | =EF=BF=BD =EF=BF=BD4 ++++
> =EF=BF=BDdrivers/mtd/devices/Kconfig | =EF=BF=BD =EF=BF=BD8 ++++++++
> =EF=BF=BDdrivers/mtd/maps/Kconfig =EF=BF=BD =EF=BF=BD| =EF=BF=BD =EF=BF=
=BD4 ++++
> =EF=BF=BDdrivers/mtd/mtdchar.c =EF=BF=BD =EF=BF=BD =EF=BF=BD | =EF=BF=BD =
=EF=BF=BD4 ++++
> =EF=BF=BDdrivers/mtd/nand/Kconfig =EF=BF=BD =EF=BF=BD| =EF=BF=BD =EF=BF=
=BD3 +++
> =EF=BF=BDdrivers/mtd/onenand/Kconfig | =EF=BF=BD =EF=BF=BD3 +++
> =EF=BF=BDinclude/linux/mtd/map.h =EF=BF=BD =EF=BF=BD | =EF=BF=BD =EF=BF=
=BD2 ++
> =EF=BF=BD10 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
> index 0ccad0f..e34f399 100644
> --- a/arch/um/Kconfig.rest
> +++ b/arch/um/Kconfig.rest
> @@ -28,9 +28,7 @@ source "drivers/scsi/Kconfig"
>
> =EF=BF=BDsource "drivers/md/Kconfig"
>
> -if BROKEN
> - =EF=BF=BD =EF=BF=BD =EF=BF=BD source "drivers/mtd/Kconfig"
> -endif
> +source "drivers/mtd/Kconfig"

drivers/mtd was already marked as broken when we moved over to git (2.6.12-=
rc2).

Do you exactly know why it was marked and fixes this patch all issues?

> =EF=BF=BDsource "drivers/leds/Kconfig"
>
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 1e2cbf5..a0e2a28 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -1,6 +1,5 @@
> =EF=BF=BDmenuconfig MTD
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDtristate "Memory Technology Device=
 (MTD) support"
> - =EF=BF=BD =EF=BF=BD =EF=BF=BD depends on HAS_IOMEM
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDhelp
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDMemory Technology Device=
s are flash, RAM and similar chips, often
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDused for solid state fil=
e systems on embedded devices. This option
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 760abc5..ffa2e15 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_MTD_OOPS) =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD+=3D mtdoops.o
> =EF=BF=BDnftl-objs =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD:=3D nftlcore.o nftlmount.o
> =EF=BF=BDinftl-objs =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD :=3D inftlcore.o inftlmount.o
>
> -obj-y =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD+=3D chips/ lpddr=
/ maps/ devices/ nand/ onenand/ tests/
> +obj-y =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD+=3D maps/ devices/ nand/ onenand/ tests/
> +obj-$(CONFIG_HAS_IOMEM) =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD+=3D chip=
s/ lpddr/
>
> =EF=BF=BDobj-$(CONFIG_MTD_UBI) =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD+=3D ubi/
> diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
> index 35c6a23..27382c9 100644
> --- a/drivers/mtd/chips/Kconfig
> +++ b/drivers/mtd/chips/Kconfig
> @@ -1,3 +1,5 @@
> +if HAS_IOMEM
> +
> =EF=BF=BDmenu "RAM/ROM/Flash chip drivers"
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdepends on MTD!=3Dn
>
> @@ -240,3 +242,5 @@ config MTD_XIP
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDthen say N.
>
> =EF=BF=BDendmenu
> +
> +endif # HAS_IOMEM
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index 35081ce..8f6d85d 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -112,6 +112,8 @@ config MTD_SST25L
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDSet up your spi devices =
with the right board-specific platform data,
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDif you want to specify d=
evice partitioning.
>
> +if HAS_IOMEM
> +
> =EF=BF=BDconfig MTD_SLRAM
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDtristate "Uncached system RAM"
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDhelp
> @@ -128,6 +130,8 @@ config MTD_PHRAM
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdoesn't have access to, =
memory beyond the mem=3Dxxx limit, nvram,
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDmemory on the video card=
, etc...
>
> +endif # HAS_IOMEM
> +
> =EF=BF=BDconfig MTD_LART
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDtristate "28F160xx flash driver fo=
r LART"
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdepends on SA1100_LART
> @@ -187,6 +191,8 @@ config MTD_BLOCK2MTD
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDTesting MTD users (eg JF=
FS2) on large media and media that might
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDbe removed during a writ=
e (using the floppy drive).
>
> +if HAS_IOMEM
> +
> =EF=BF=BDcomment "Disk-On-Chip Device Drivers"
>
> =EF=BF=BDconfig MTD_DOC2000
> @@ -249,6 +255,8 @@ config MTD_DOC2001PLUS
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDunder "NAND Flash Device=
 Drivers" (currently that driver does not
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDsupport all Millennium P=
lus devices).
>
> +endif # HAS_IOMEM
> +
> =EF=BF=BDconfig MTD_DOCPROBE
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDtristate
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDselect MTD_DOCECC
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index a0dd7bb..e793b29 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -1,3 +1,5 @@
> +if HAS_IOMEM
> +
> =EF=BF=BDmenu "Mapping drivers for chip access"
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdepends on MTD!=3Dn
>
> @@ -553,3 +555,5 @@ config MTD_PISMO
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDWhen built as a module, =
it will be called pismo.ko
>
> =EF=BF=BDendmenu
> +
> +endif # HAS_IOMEM
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 4759d82..a434354 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -1075,6 +1075,7 @@ static unsigned long mtd_get_unmapped_area(struct f=
ile *file,
> =EF=BF=BD/*
> =EF=BF=BD* set up a mapping for shared memory segments
> =EF=BF=BD*/
> +#ifdef CONFIG_HAS_IOMEM
> =EF=BF=BDstatic int mtd_mmap(struct file *file, struct vm_area_struct *vm=
a)
> =EF=BF=BD{
> =EF=BF=BD#ifdef CONFIG_MMU
> @@ -1113,6 +1114,7 @@ static int mtd_mmap(struct file *file, struct vm_ar=
ea_struct *vma)
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDreturn vma->vm_flags & VM_SHARED ?=
 0 : -ENOSYS;
> =EF=BF=BD#endif
> =EF=BF=BD}
> +#endif
>
> =EF=BF=BDstatic const struct file_operations mtd_fops =3D {
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD.owner =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD=3D THIS_MODULE,
> @@ -1125,7 +1127,9 @@ static const struct file_operations mtd_fops =3D {
> =EF=BF=BD#endif
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD.open =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =3D mtd_open,
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD.release =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD=3D mtd_close,
> +#ifdef CONFIG_HAS_IOMEM
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD.mmap =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =3D mtd_mmap,
> +#endif
> =EF=BF=BD#ifndef CONFIG_MMU
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD.get_unmapped_area =3D mtd_get_unm=
apped_area,
> =EF=BF=BD#endif
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 8229802..8bdd465 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -10,6 +10,8 @@ config MTD_NAND_ECC_SMC
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDThe original Linux imple=
mentation had byte 0 and 1 swapped.
>
>
> +if HAS_IOMEM
> +
> =EF=BF=BDmenuconfig MTD_NAND
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDtristate "NAND Device Support"
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdepends on MTD
> @@ -533,3 +535,4 @@ config MTD_NAND_FSMC
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDFlexible Static Memory C=
ontroller (FSMC)
>
> =EF=BF=BDendif # MTD_NAND
> +endif # HAS_IOMEM
> diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
> index 4dbd0f5..166aa18 100644
> --- a/drivers/mtd/onenand/Kconfig
> +++ b/drivers/mtd/onenand/Kconfig
> @@ -1,3 +1,5 @@
> +if HAS_IOMEM
> +
> =EF=BF=BDmenuconfig MTD_ONENAND
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDtristate "OneNAND Device Support"
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDdepends on MTD
> @@ -75,3 +77,4 @@ config MTD_ONENAND_SIM
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDOneNAND MTD layer.
>
> =EF=BF=BDendif # MTD_ONENAND
> +endif # HAS_IOMEM
> diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> index a9e6ba4..c7233ba 100644
> --- a/include/linux/mtd/map.h
> +++ b/include/linux/mtd/map.h
> @@ -388,6 +388,7 @@ static inline map_word map_word_ff(struct map_info *m=
ap)
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDreturn r;
> =EF=BF=BD}
>
> +#ifdef CONFIG_HAS_IOMEM
> =EF=BF=BDstatic inline map_word inline_map_read(struct map_info *map, uns=
igned long ofs)
> =EF=BF=BD{
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDmap_word r;
> @@ -439,6 +440,7 @@ static inline void inline_map_copy_to(struct map_info=
 *map, unsigned long to, co
> =EF=BF=BD{
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDmemcpy_toio(map->virt + to, from, =
len);
> =EF=BF=BD}
> +#endif /* CONFIG_HAS_IOMEM */
>
> =EF=BF=BD#ifdef CONFIG_MTD_COMPLEX_MAPPINGS
> =EF=BF=BD#define map_read(map, ofs) (map)->read(map, ofs)
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =EF=BF=BDhttp://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =EF=BF=BDhttp://www.tux.org/lkml/
>



--=20
Thanks,
//richard
