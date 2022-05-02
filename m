Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlQGP-0008ET-KL
 for linux-um@lists.infradead.org; Mon, 02 May 2022 07:14:36 +0000
Date: Mon, 2 May 2022 09:14:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.18-rc5
In-Reply-To: <20220502065353.2658957-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2205020912140.658493@ramsan.of.borg>
References: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com>
 <20220502065353.2658957-1-geert@linux-m68k.org>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-rdma@vger.kernel.org, linux-mips@vger.kernel.org

On Mon, 2 May 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc5[1] to v5.18-rc4[3], the summaries are:
>  - build errors: +6/-21

6 error regressions:
   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

sh4-gcc11/se7750_defconfig
sh4-gcc11/sh-defconfig
sh4-gcc11/se7619_defconfig
sh4-gcc11/sh-allmodconfig
sh4-gcc11/sh-allyesconfig
sh4-gcc11/sh-allnoconfig

gcc-11 fallout

   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{yes,no}config

   + /kisskb/src/include/linux/sh_intc.h: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]:  => 100:63

v5.18-rc5/sh4-gcc11/se7750_defconfig
v5.18-rc5/sh4-gcc11/sh-defconfig
v5.18-rc5/sh4-gcc11/se7619_defconfig
v5.18-rc5/sh4-gcc11/sh-allmodconfig
v5.18-rc5/sh4-gcc11/sh-allyesconfig
v5.18-rc5/sh4-gcc11/sh-allnoconfig

gcc-10/11 fallout, seen before for sh4-gcc10/se7750_defconfig and sh4-gcc10/se7619_defconfig

   + {standard input}: Error: branch to a symbol in another ISA mode:  => 1295

mips-gcc11/micro32r2_defconfig
mips-gcc11/micro32r2el_defconfig

gcc-11 fallout

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/672c0c5173427e6b3e2a9bbb7be51ceeec78093a/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af2d861d4cd2a4da5137f795ee3509e6f944a25b/ (96 out of 138 configs)

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

