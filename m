Return-Path: <johannes@sipsolutions.net>
Message-ID: <69743b4e0fe1364f1d933a883bd580e7b76129f0.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v5.12-rc4
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 22 Mar 2021 15:57:14 +0100
In-Reply-To: <CAMuHMdVvCGa6SaumOOA-hM=WDEb7WHgXTNRsTrU=BnCXGqcr2g@mail.gmail.com>
References: <20210322141417.1062111-1-geert@linux-m68k.org>
	 <CAMuHMdVvCGa6SaumOOA-hM=WDEb7WHgXTNRsTrU=BnCXGqcr2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, 2021-03-22 at 15:43 +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 22, 2021 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.12-rc4[1] to v5.12-rc3[3], the summaries are:
> >   - build errors: +6/-2
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b/ (all 192 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1e28eed17697bcf343c6743f0028cc3b5dd88bf0/ (all 192 configs)
> 
> > 6 error regressions:
> >   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
> >   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!:  => N/A
> >   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
> >   + error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
> >   + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
> 
> x86_64/um-allmodconfig

I'd guess that's a missing 'depends on HAS_IOMEM'.

johannes


