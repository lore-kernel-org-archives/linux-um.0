Return-Path: <alexdeucher@gmail.com>
MIME-Version: 1.0
References: <20220123125737.2658758-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jan 2022 13:51:48 -0500
Message-ID: <CADnq5_MUq0fX7wMLJyUUxxa+2xoRinonL-TzD8tUhXALRfY8-A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, kvm@vger.kernel.org, Network Development <netdev@vger.kernel.org>, linux-um@lists.infradead.org, linux-mips@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, sparclinux@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Tobin C. Harding" <me@tobin.cc>
List-ID: <linux-um.lists.infradead.org>

On Mon, Jan 24, 2022 at 5:25 AM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
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
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e783362eb54cd=
99b2cac8b3a9aeac942e6f6ac07/ (all 99 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/df0cc57e057f1=
8e44dac8e6c18aba47ab53202f9/ (98 out of 99 configs)
> >
> >
> > *** ERRORS ***
> >
> > 17 error regressions:
> >  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit declar=
ation of function 'nmi_cpu_backtrace' [-Werror=3Dimplicit-function-declarat=
ion]:  =3D> 171:2
> >  + /kisskb/src/arch/powerpc/kernel/stacktrace.c: error: implicit declar=
ation of function 'nmi_trigger_cpumask_backtrace' [-Werror=3Dimplicit-funct=
ion-declaration]:  =3D> 226:2
>
> powerpc-gcc5/skiroot_defconfig
>
> >  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible =
function types from 'void (*)(long unsigned int)' to 'void (*)(long unsigne=
d int,  long unsigned int,  long unsigned int,  long unsigned int,  long un=
signed int)' [-Werror=3Dcast-function-type]:  =3D> 1756:13, 1639:13
> >  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible =
function types from 'void (*)(struct mm_struct *)' to 'void (*)(long unsign=
ed int,  long unsigned int,  long unsigned int,  long unsigned int,  long u=
nsigned int)' [-Werror=3Dcast-function-type]:  =3D> 1674:29, 1662:29
> >  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible =
function types from 'void (*)(struct mm_struct *, long unsigned int)' to 'v=
oid (*)(long unsigned int,  long unsigned int,  long unsigned int,  long un=
signed int,  long unsigned int)' [-Werror=3Dcast-function-type]:  =3D> 1767=
:21
> >  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible =
function types from 'void (*)(struct vm_area_struct *, long unsigned int)' =
to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  lo=
ng unsigned int,  long unsigned int)' [-Werror=3Dcast-function-type]:  =3D>=
 1741:29, 1726:29
> >  + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible =
function types from 'void (*)(struct vm_area_struct *, long unsigned int,  =
long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  lo=
ng unsigned int,  long unsigned int,  long unsigned int)' [-Werror=3Dcast-f=
unction-type]:  =3D> 1694:29, 1711:29
>
> sparc64-gcc11/sparc-allmodconfig
>
> >  + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called o=
bject is not a function or function pointer:  =3D> 103:18
> >  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment make=
s pointer from integer without a cast [-Werror=3Dint-conversion]:  =3D> 324=
:9, 317:9
> >  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declar=
ation of function 'ioport_map' [-Werror=3Dimplicit-function-declaration]:  =
=3D> 317:11
> >  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declar=
ation of function 'ioport_unmap' [-Werror=3Dimplicit-function-declaration]:=
  =3D> 338:15
>
> um-x86_64/um-allyesconfig
>
> >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: err=
or: control reaches end of non-void function [-Werror=3Dreturn-type]:  =3D>=
 1560:1

I don't really see what's going on here:

#ifdef CONFIG_X86_64
return cpu_data(first_cpu_of_numa_node).apicid;
#else
return first_cpu_of_numa_node;
#endif

Alex

>
> um-x86_64/um-all{mod,yes}config
>
> >  + /kisskb/src/drivers/net/ethernet/freescale/fec_mpc52xx.c: error: pas=
sing argument 2 of 'mpc52xx_fec_set_paddr' discards 'const' qualifier from =
pointer target type [-Werror=3Ddiscarded-qualifiers]:  =3D> 659:29
>
> powerpc-gcc5/ppc32_allmodconfig
>
> >  + /kisskb/src/drivers/pinctrl/pinctrl-thunderbay.c: error: assignment =
discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-qu=
alifiers]:  =3D> 815:8, 815:29
>
> arm64-gcc5.4/arm64-allmodconfig
> arm64-gcc8/arm64-allmodconfig
>
> >  + /kisskb/src/lib/test_printf.c: error: "PTR" redefined [-Werror]:  =
=3D> 247:0, 247
> >  + /kisskb/src/sound/pci/ca0106/ca0106.h: error: "PTR" redefined [-Werr=
or]:  =3D> 62, 62:0
>
> mips-gcc8/mips-allmodconfig
> mipsel/mips-allmodconfig
>
> >  + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to f=
it: R_PPC64_REL14 (stub) against symbol `machine_check_common' defined in .=
text section in arch/powerpc/kernel/head_64.o:  =3D> (.text+0x3e4)
>
> powerpc-gcc5/powerpc-allyesconfig
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds

