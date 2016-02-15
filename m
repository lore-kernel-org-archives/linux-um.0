MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1455532901-5852-1-git-send-email-vegard.nossum@oracle.com>
References: <1455532901-5852-1-git-send-email-vegard.nossum@oracle.com>
Date: Mon, 15 Feb 2016 12:17:00 +0100
Message-ID: <CAMuHMdVKb852m15jj+iB-rafR-TH-aADPk3wbvoyefxn-Yyyfw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 1/2] usb: support building without CONFIG_HAS_DMA
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, USB list <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Vegard,

On Mon, Feb 15, 2016 at 11:41 AM, Vegard Nossum
<vegard.nossum@oracle.com> wrote:
> Some platforms don't have DMA, but we should still be able to build
> USB drivers for these platforms. They could still be used through
> vhci_hcd, usbip_host, or maybe something like USB passthrough in UML
> from a capable host.
>
> This is admittedly ugly with the #ifdefs, but those are necessary to
> get around linker errors like these:
>
> drivers/built-in.o: In function `dma_unmap_sg_attrs':
> include/linux/dma-mapping.h:183: undefined reference to `bad_dma_ops'
> drivers/built-in.o: In function `dma_unmap_single_attrs':
> include/linux/dma-mapping.h:148: undefined reference to `bad_dma_ops'
> drivers/built-in.o: In function `dma_map_sg_attrs':
> include/linux/dma-mapping.h:168: undefined reference to `bad_dma_ops'
> drivers/built-in.o: In function `dma_map_page':
> include/linux/dma-mapping.h:196: undefined reference to `bad_dma_ops'
> drivers/built-in.o: In function `dma_mapping_error':
> include/linux/dma-mapping.h:430: undefined reference to `bad_dma_ops'
> drivers/built-in.o:include/linux/dma-mapping.h:131: more undefined references to `bad_dma_ops' follow
>
> Greg KG suggested just defining these for UML [1] but according to
> Richard Weinberger this has come up before and it was decided not to
> do that just for the sake of making drivers build [2].
>
> [1]: http://www.spinics.net/lists/linux-usb/msg136306.html
> [2]: http://www.spinics.net/lists/linux-usb/msg136308.html
>
> If any of the new warnings trigger, the correct solution is almost
> certainly to add a CONFIG_HAS_DMA dependency in the Kconfig menu for
> the responsible driver -- that driver's functions will hopefully
> appear somewhere in the stack trace.
>
> v2: Reduce the number of #ifdefs by moving code out into helpers.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

I have an even smaller patch that I've been updating over the years to
compile allmodconfig/allyesconfig kernels for m68k/Sun-3.

I'll clean it up and send it...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

