Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDLX8-00BXv4-O6
	for linux-um@lists.infradead.org; Mon, 18 Jul 2022 07:51:17 +0000
Date: Mon, 18 Jul 2022 09:51:03 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.19-rc7
In-Reply-To: <20220718074308.3801763-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2207180949260.949449@ramsan.of.borg>
References: <CAHk-=wj63HHDU0MTRVKese5a4j82g3s3u4Ztno7=7Cj=cRRFFQ@mail.gmail.com> <20220718074308.3801763-1-geert@linux-m68k.org>
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
Cc: linux-rdma@vger.kernel.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org

On Mon, 18 Jul 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.19-rc7[1] to v5.19-rc6[3], the summaries are:
>  - build errors: +11/-6

   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config
(seen before in v5.18)

   + {standard input}: Error: displacement to undefined symbol .L271 overflows 12-bit field:  => 1625
   + {standard input}: Error: displacement to undefined symbol .L271 overflows 8-bit field :  => 1634
   + {standard input}: Error: displacement to undefined symbol .L318 overflows 8-bit field :  => 1665, 1681, 1711, 1693
   + {standard input}: Error: pcrel too far:  => 1657, 1667, 1629, 1685, 1649, 1655, 1635, 1698, 1618, 1644, 1695, 1705, 1676, 1673, 1670, 1660, 1686, 1656, 1702, 1672, 1700, 1609, 1632, 1684
   + {standard input}: Error: unknown opcode:  => 1713

sh4-gcc11/sh-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ff6992735ade75aae3e35d16b17da1008d753d28/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/32346491ddf24599decca06190ebca03ff9de7f8/ (all 135 configs)

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

