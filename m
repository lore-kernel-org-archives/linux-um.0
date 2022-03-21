MIME-Version: 1.0
Date: Mon, 21 Mar 2022 15:48:30 +0100
References: <CAHk-=wj4fFjx2pgbGNBM4wJs3=eReZ05EQyprzgT2Jv8qJ2vJg@mail.gmail.com>
	<20220321101654.3570822-1-geert@linux-m68k.org>
In-Reply-To: <20220321101654.3570822-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdWsrW0WFB+B6wGg2k4wo1qk1xi2s2sbaw44=uVvVpopHw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, KVM list <kvm@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Mar 21, 2022 at 3:00 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.17[1] to v5.17-rc8[3], the summaries are:
>   - build errors: +5/-0

  + /kisskb/src/crypto/blake2b_generic.c: error: the frame size of
2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  =>
109:1

sparc64-gcc11/sparc-allmodconfig

  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment
makes pointer from integer without a cast [-Werror=int-conversion]:
=> 324:9, 317:9
  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit
declaration of function 'ioport_map'
[-Werror=implicit-function-declaration]:  => 317:11
  + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit
declaration of function 'ioport_unmap'
[-Werror=implicit-function-declaration]:  => 338:15

um-x86_64/um-all{mod,yes}config

  + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to
fit: R_PPC64_REL14 (stub) against symbol `machine_check_common'
defined in .text section in arch/powerpc/kernel/head_64.o:  =>
(.text+0x3e4)

powerpc-gcc5/powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f443e374ae131c168a065ea1748feac6b2e76613/ (96 out of 98 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09688c0166e76ce2fb85e86b9d99be8b0084cdf9/ (96 out of 98 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

