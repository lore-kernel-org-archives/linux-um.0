Return-Path: <John.Youn@synopsys.com>
From: John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH 3/3] usb: dwc2: USB_DWC2 should depend on HAS_DMA
Date: Mon, 15 Feb 2016 23:21:36 +0000
Message-ID: <2B3535C5ECE8B5419E3ECBE30077290901DC448871@US01WEMBX2.internal.synopsys.com>
References: <1455535305-9508-1-git-send-email-geert@linux-m68k.org>
 <1455535305-9508-4-git-send-email-geert@linux-m68k.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: John Youn <John.Youn@synopsys.com>, Richard Weinberger <richard@nod.at>, James McMechan <James_McMechan@hotmail.com>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 2/15/2016 3:21 AM, Geert Uytterhoeven wrote:=0A=
> If NO_DMA=3Dy:=0A=
> =0A=
>     ERROR: "usb_gadget_map_request" [drivers/usb/dwc2/dwc2.ko] undefined!=
=0A=
>     ERROR: "usb_gadget_unmap_request" [drivers/usb/dwc2/dwc2.ko] undefine=
d!=0A=
>     ERROR: "bad_dma_ops" [drivers/usb/dwc2/dwc2.ko] undefined!=0A=
> =0A=
> Add a dependency on HAS_DMA to fix this.=0A=
> =0A=
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>=0A=
> ---=0A=
>  drivers/usb/dwc2/Kconfig | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/Kconfig b/drivers/usb/dwc2/Kconfig=0A=
> index fd95ba6ec317fdac..f0decc0d69b5197d 100644=0A=
> --- a/drivers/usb/dwc2/Kconfig=0A=
> +++ b/drivers/usb/dwc2/Kconfig=0A=
> @@ -1,5 +1,6 @@=0A=
>  config USB_DWC2=0A=
>  	tristate "DesignWare USB2 DRD Core Support"=0A=
> +	depends on HAS_DMA=0A=
>  	depends on USB || USB_GADGET=0A=
>  	help=0A=
>  	  Say Y here if your system has a Dual Role Hi-Speed USB=0A=
> =0A=
=0A=
=0A=
Acked-by: John Youn <johnyoun@synopsys.com>=0A=
=0A=
=0A=
=0A=

