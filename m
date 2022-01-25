Return-Path: <lakshmi.sowjanya.d@intel.com>
From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Subject: RE: Build regressions/improvements in v5.17-rc1
Date: Tue, 25 Jan 2022 12:56:50 +0000
Message-ID: <DM6PR11MB3660804C821D7CA7329B6CAFC45F9@DM6PR11MB3660.namprd11.prod.outlook.com>
References: <20220123125737.2658758-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>



> -----Original Message-----
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: Monday, January 24, 2022 1:26 PM
> To: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; sparclinux@vger.kernel.org; linux-
> um@lists.infradead.org; D, Lakshmi Sowjanya
> <lakshmi.sowjanya.d@intel.com>; kvm@vger.kernel.org; linux-
> mips@vger.kernel.org; Tobin C. Harding <me@tobin.cc>; alsa-devel@alsa-
> project.org; amd-gfx@lists.freedesktop.org; netdev@vger.kernel.org
> Subject: Re: Build regressions/improvements in v5.17-rc1
>=20
> On Sun, 23 Jan 2022, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.17-rc1[1] compared to v5.16[2].
> >
> > Summarized:
> >  - build errors: +17/-2
> >  - build warnings: +23/-25
> >
> > Note that there may be false regressions, as some logs are incomplete.
> > Still, they're build errors/warnings.
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1]
> > http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e783362eb54cd99b
> > 2cac8b3a9aeac942e6f6ac07/ (all 99 configs) [2]
> > http://kisskb.ellerman.id.au/kisskb/branch/linus/head/df0cc57e057f18e4
> > 4dac8e6c18aba47ab53202f9/ (98 out of 99 configs)
> >
> >
> > *** ERRORS ***
> >
> > 17 error regressions:
> >  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit
> > declaration of function 'nmi_cpu_backtrace'
> > [-Werror=3Dimplicit-function-declaration]:  =3D> 171:2  +
> > /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit
> > declaration of function 'nmi_trigger_cpumask_backtrace'
> > [-Werror=3Dimplicit-function-declaration]:  =3D> 226:2
>=20
> powerpc-gcc5/skiroot_defconfig
>=20
> >  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible
> > function types from 'void (*)(long unsigned int)' to 'void (*)(long
> > unsigned int,  long unsigned int,  long unsigned int,  long unsigned
> > int,  long unsigned int)' [-Werror=3Dcast-function-type]:  =3D> 1756:13=
,
> > 1639:13  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between
> > incompatible function types from 'void (*)(struct mm_struct *)' to
> > 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,
> > long unsigned int,  long unsigned int)' [-Werror=3Dcast-function-type]:
> > =3D> 1674:29, 1662:29  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast
> > between incompatible function types from 'void (*)(struct mm_struct *,
> > long unsigned int)' to 'void (*)(long unsigned int,  long unsigned
> > int,  long unsigned int,  long unsigned int,  long unsigned int)'
> > [-Werror=3Dcast-function-type]:  =3D> 1767:21  +
> > /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible
> > function types from 'void (*)(struct vm_area_struct *, long unsigned
> > int)' to 'void (*)(long unsigned int,  long unsigned int,  long
> > unsigned int,  long unsigned int,  long unsigned int)'
> > [-Werror=3Dcast-function-type]:  =3D> 1741:29, 1726:29  +
> > /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible
> > function types from 'void (*)(struct vm_area_struct *, long unsigned
> > int,  long unsigned int)' to 'void (*)(long unsigned int,  long
> > unsigned int,  long unsigned int,  long unsigned int,  long unsigned
> > int)' [-Werror=3Dcast-function-type]:  =3D> 1694:29, 1711:29
>=20
> sparc64-gcc11/sparc-allmodconfig
>=20
> >  + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called
> > object is not a function or function pointer:  =3D> 103:18  +
> > /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment makes
> > pointer from integer without a cast [-Werror=3Dint-conversion]:  =3D>
> > 324:9, 317:9  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error:
> > implicit declaration of function 'ioport_map'
> > [-Werror=3Dimplicit-function-declaration]:  =3D> 317:11  +
> > /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit
> > declaration of function 'ioport_unmap'
> > [-Werror=3Dimplicit-function-declaration]:  =3D> 338:15
>=20
> um-x86_64/um-allyesconfig
>=20
> >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:
> > error: control reaches end of non-void function [-Werror=3Dreturn-type]=
:
> > =3D> 1560:1
>=20
> um-x86_64/um-all{mod,yes}config
>=20
> >  + /kisskb/src/drivers/net/ethernet/freescale/fec_mpc52xx.c: error:
> > passing argument 2 of 'mpc52xx_fec_set_paddr' discards 'const'
> > qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]:  =
=3D>
> > 659:29
>=20
> powerpc-gcc5/ppc32_allmodconfig
>=20
> >  + /kisskb/src/drivers/pinctrl/pinctrl-thunderbay.c: error: assignment
> > discards 'const' qualifier from pointer target type
> > [-Werror=3Ddiscarded-qualifiers]:  =3D> 815:8, 815:29
>=20
> arm64-gcc5.4/arm64-allmodconfig
> arm64-gcc8/arm64-allmodconfig
>=20

These errors are fixed with the patch set by Rafa=B3 Mi=B3ecki:=20
https://lore.kernel.org/all/CACRpkdYbR-hpLTcvN1_LuxEH_mgHLqDmopDqo1ddui9o8Z=
vSPQ@mail.gmail.com/t/

Regards,
Lakshmi Sowjanya

> >  + /kisskb/src/lib/test_printf.c: error: "PTR" redefined [-Werror]:
> > =3D> 247:0, 247  + /kisskb/src/sound/pci/ca0106/ca0106.h: error: "PTR"
> > redefined [-Werror]:  =3D> 62, 62:0
>=20
> mips-gcc8/mips-allmodconfig
> mipsel/mips-allmodconfig
>=20
> >  + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to
> > fit: R_PPC64_REL14 (stub) against symbol `machine_check_common'
> > defined in .text section in arch/powerpc/kernel/head_64.o:  =3D>
> > (.text+0x3e4)
>=20
> powerpc-gcc5/powerpc-allyesconfig
>=20
> Gr{oetje,eeting}s,
>=20
>  						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But when
> I'm talking to journalists I just say "programmer" or something like that=
.
>  							    -- Linus Torvalds

