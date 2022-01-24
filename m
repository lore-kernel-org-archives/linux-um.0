MIME-Version: 1.0
Date: Mon, 24 Jan 2022 19:55:32 +0100
References: <20220123125737.2658758-1-geert@linux-m68k.org>
	<alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
	<CADnq5_MUq0fX7wMLJyUUxxa+2xoRinonL-TzD8tUhXALRfY8-A@mail.gmail.com>
In-Reply-To: <CADnq5_MUq0fX7wMLJyUUxxa+2xoRinonL-TzD8tUhXALRfY8-A@mail.gmail.com>
Message-ID: <CAMuHMdWUWqHYbbavtMT-XAD_sarDPC5xnc3c0pX1ZAh3Wuzuzg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Tobin C. Harding" <me@tobin.cc>
List-ID: <linux-um.lists.infradead.org>

Hi Alex,

On Mon, Jan 24, 2022 at 7:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Mon, Jan 24, 2022 at 5:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 23 Jan 2022, Geert Uytterhoeven wrote:
> > >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1560:1
>
> I don't really see what's going on here:
>
> #ifdef CONFIG_X86_64
> return cpu_data(first_cpu_of_numa_node).apicid;
> #else
> return first_cpu_of_numa_node;
> #endif

Ah, the actual failure causing this was not included:

In file included from /kisskb/src/arch/x86/um/asm/processor.h:41:0,
                 from /kisskb/src/include/linux/mutex.h:19,
                 from /kisskb/src/include/linux/kernfs.h:11,
                 from /kisskb/src/include/linux/sysfs.h:16,
                 from /kisskb/src/include/linux/kobject.h:20,
                 from /kisskb/src/include/linux/pci.h:35,
                 from
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:25:
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In
function 'kfd_cpumask_to_apic_id':
/kisskb/src/arch/um/include/asm/processor-generic.h:103:18: error:
called object is not a function or function pointer
 #define cpu_data (&boot_cpu_data)
                  ^
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1556:9:
note: in expansion of macro 'cpu_data'
  return cpu_data(first_cpu_of_numa_node).apicid;
         ^
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1560:1:
error: control reaches end of non-void function [-Werror=return-type]
 }
 ^

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

