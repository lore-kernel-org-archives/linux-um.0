Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 21 Feb 2016 19:09:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] usb: core: Allow compilation on platforms where
 NO_DMA=y
Message-ID: <20160222030933.GA4033@kroah.com>
References: <1455635459-1576-1-git-send-email-geert@linux-m68k.org>
 <1455635459-1576-2-git-send-email-geert@linux-m68k.org>
 <20160221042334.GA14825@kroah.com>
 <CAMuHMdWx+8hBGDQyTEuAff4=N259O_+GytPg-PFXnW0Bt4U2RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWx+8hBGDQyTEuAff4=N259O_+GytPg-PFXnW0Bt4U2RQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, USB list <linux-usb@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Feb 21, 2016 at 10:46:59PM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sun, Feb 21, 2016 at 5:23 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Feb 16, 2016 at 04:10:57PM +0100, Geert Uytterhoeven wrote:
> >> Some platforms don't have DMA, but we should still be able to build USB
> >> drivers for these platforms. They could still be used through vhci_hcd,
> >> usbip_host, or maybe something like USB passthrough in UML from a
> >> capable host.
> >>
> >> If NO_DMA=y:
> >>
> >>     ERROR: "dma_pool_destroy" [drivers/usb/core/usbcore.ko] undefined!
> >>     ERROR: "bad_dma_ops" [drivers/usb/core/usbcore.ko] undefined!
> >>     ERROR: "dma_pool_free" [drivers/usb/core/usbcore.ko] undefined!
> >>     ERROR: "dma_pool_alloc" [drivers/usb/core/usbcore.ko] undefined!
> >>     ERROR: "dma_pool_create" [drivers/usb/core/usbcore.ko] undefined!
> >>
> >> Add a few checks for CONFIG_HAS_DMA to fix this.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Acked-by: Vegard Nossum <vegard.nossum@oracle.com>
> >> ---
> >> v2:
> >>   - Replace remaining #ifdefs by IS_ENABLED() checks,
> >>   - Add to patch description that this actually allows using USB on UML,
> >>   - Add Acked-by.
> >
> > This patch didn't apply to my tree, can you rebase it against usb-next
> > of usb.git and resend?
> 
> Are you sure it's this one that didn't apply? It's already in usb-testing?
> 
> "[2/3] usb: host: Host drivers relying on DMA should depend on HAS_DMA"
> doesn't apply, as your tree gained some HAS_IOMEM dependencies, so I'll
> resend.

Thanks, I think you were right.

greg k-h

