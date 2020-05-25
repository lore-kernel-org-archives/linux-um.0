Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jd9VX-0002xb-0n
 for linux-um@lists.infradead.org; Mon, 25 May 2020 09:34:56 +0000
Date: Mon, 25 May 2020 11:34:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.7-rc7
In-Reply-To: <20200525075924.23960-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.21.2005251132020.9189@ramsan.of.borg>
References: <20200525075924.23960-1-geert@linux-m68k.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org

On Mon, 25 May 2020, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> JFYI, when comparing v5.7-rc7[1] to v5.7-rc6[3], the summaries are:
>  - build errors: +4/-0
>  - build warnings: +0/-0

   + error: modpost: "devm_ioremap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
   + error: modpost: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

um-x86_64/um-all*config

Most of these are not new, but were somehow hidden in the previous
builds.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9cb1fd0efd195590b828b9b865421ad345a4a145/ (194 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce/ (194 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

