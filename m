Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 25 May 2013 05:18:51 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20130525121851.GB3746@kroah.com>
References: <51A0989A.6070100@nagafix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <51A0989A.6070100@nagafix.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: UML build broken since 3.0.75 (also affects 3.2.x)
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: stable@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, May 25, 2013 at 05:55:22PM +0700, Antoine Martin wrote:
> Linus' vm patches broke the UML build in 3.0.75 onwards:
>=20
>   CC      mm/memory.o
> mm/memory.c: In function =E2=80=98vm_iomap_memory=E2=80=99:
> mm/memory.c:2363:2: error: implicit declaration of function
> =E2=80=98io_remap_pfn_range=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
> cc1: some warnings being treated as errors
> make[1]: *** [mm/memory.o] Error 1
> make: *** [mm] Error 2
>=20
>=20
> This fix is just a copy of what is found in later kernels.

What is that git commit id?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

