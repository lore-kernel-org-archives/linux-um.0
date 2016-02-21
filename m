Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 20 Feb 2016 20:23:34 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] usb: core: Allow compilation on platforms where
 NO_DMA=y
Message-ID: <20160221042334.GA14825@kroah.com>
References: <1455635459-1576-1-git-send-email-geert@linux-m68k.org>
 <1455635459-1576-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455635459-1576-2-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-usb@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Feb 16, 2016 at 04:10:57PM +0100, Geert Uytterhoeven wrote:
> Some platforms don't have DMA, but we should still be able to build USB
> drivers for these platforms. They could still be used through vhci_hcd,
> usbip_host, or maybe something like USB passthrough in UML from a
> capable host.
> 
> If NO_DMA=y:
> 
>     ERROR: "dma_pool_destroy" [drivers/usb/core/usbcore.ko] undefined!
>     ERROR: "bad_dma_ops" [drivers/usb/core/usbcore.ko] undefined!
>     ERROR: "dma_pool_free" [drivers/usb/core/usbcore.ko] undefined!
>     ERROR: "dma_pool_alloc" [drivers/usb/core/usbcore.ko] undefined!
>     ERROR: "dma_pool_create" [drivers/usb/core/usbcore.ko] undefined!
> 
> Add a few checks for CONFIG_HAS_DMA to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
> v2:
>   - Replace remaining #ifdefs by IS_ENABLED() checks,
>   - Add to patch description that this actually allows using USB on UML,
>   - Add Acked-by.

This patch didn't apply to my tree, can you rebase it against usb-next
of usb.git and resend?

thanks,

greg k-h

