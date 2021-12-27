Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1nU8-00GXmh-Gl
 for linux-um@lists.infradead.org; Mon, 27 Dec 2021 10:44:10 +0000
Date: Mon, 27 Dec 2021 11:44:01 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.16-rc7
In-Reply-To: <20211227083126.1153239-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2112271142250.1704790@ramsan.of.borg>
References: <20211227083126.1153239-1-geert@linux-m68k.org>
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
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org

On Mon, 27 Dec 2021, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.16-rc7[1] to v5.16-rc6[3], the summaries are:
>  - build errors: +2/-1

   + /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 109:1

sparc64-gcc11/sparc-allmodconfig

   + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10

um-x86_64/um-all{mod,yes}config

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

