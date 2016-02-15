MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <56C1BB63.9070906@oracle.com>
References: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
	<1455535305-9508-2-git-send-email-geert@linux-m68k.org>
	<56C1BB63.9070906@oracle.com>
Date: Mon, 15 Feb 2016 13:28:39 +0100
Message-ID: <CAMuHMdVxNS1_coU6EPZcHYKZqGnOPDmHq9_aQGa08jLNP55Nhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: core: Allow compilation on platforms where NO_DMA=y
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Youn <johnyoun@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, USB list <linux-usb@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Vegard,

On Mon, Feb 15, 2016 at 12:49 PM, Vegard Nossum
<vegard.nossum@oracle.com> wrote:
> On 02/15/2016 12:21 PM, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>>
>>      ERROR: "dma_pool_destroy" [drivers/usb/core/usbcore.ko] undefined!
>>      ERROR: "bad_dma_ops" [drivers/usb/core/usbcore.ko] undefined!
>>      ERROR: "dma_pool_free" [drivers/usb/core/usbcore.ko] undefined!
>>      ERROR: "dma_pool_alloc" [drivers/usb/core/usbcore.ko] undefined!
>>      ERROR: "dma_pool_create" [drivers/usb/core/usbcore.ko] undefined!
>>
>> Add a few checks for CONFIG_HAS_DMA to fix this.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>>   drivers/usb/core/buffer.c | 18 ++++++++++++------
>>   drivers/usb/core/hcd.c    | 14 ++++++++++----
>>   2 files changed, 22 insertions(+), 10 deletions(-)
>>
>
> This does look nicer than my patch.

I'm happy you like it ;-)

>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -1408,12 +1408,15 @@ static void hcd_free_coherent(struct usb_bus *bus,
>> dma_addr_t *dma_handle,
>>
>>   void usb_hcd_unmap_urb_setup_for_dma(struct usb_hcd *hcd, struct urb
>> *urb)
>>   {
>> +#ifdef CONFIG_HAS_DMA
>>         if (urb->transfer_flags & URB_SETUP_MAP_SINGLE)
>>                 dma_unmap_single(hcd->self.controller,
>>                                 urb->setup_dma,
>>                                 sizeof(struct usb_ctrlrequest),
>>                                 DMA_TO_DEVICE);
>> -       else if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
>> +       else
>> +#endif /* CONFIG_HAS_DMA */
>> +       if (urb->transfer_flags & URB_SETUP_MAP_LOCAL)
>
>
> Why not use IS_ENABLED() here as well instead of the ifdef?

This used to be needed, else the calls to e.g. dma_unmap_single() would
still cause link errors.

This no longer seems to be the case (I told you this was a patch set I started
a while ago ;-), probably due to the recent dma_map_ops conversion.
Will update.

> Assuming this still lets the platform actually run USB drivers (which it
> looks like it does -- I still have to test it), then I'm all for it. You

Please give it a try and let me know, as I'm not in a position to test-run
this on Sun-3.

> may want to steal parts of the commit description for my last patch to
> include that this actually allows using USB on UML and the references to
> the discussion.

Thanks, will do!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

