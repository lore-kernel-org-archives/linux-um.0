Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnpNH-00069V-9z
 for linux-um@lists.infradead.org; Thu, 09 Aug 2018 18:09:28 +0000
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so7489122qtp.11
 for <linux-um@lists.infradead.org>; Thu, 09 Aug 2018 11:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180809174444.31705-1-paul.burton@mips.com>
 <20180809174444.31705-4-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-4-paul.burton@mips.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Aug 2018 20:08:59 +0200
Message-ID: <CAK8P3a2AxGr2_r2jsrf3S+xAqaszXGozWwV7tc16VjmP6yx3fg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] compiler.h: Allow arch-specific overrides
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Paul Burton <paul.burton@mips.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>

On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Include an arch-specific asm/compiler.h and allow for it to define a
> custom version of barrier_before_unreachable(), which is needed to
> workaround several issues on the MIPS architecture.
>
> This patch includes an effectively empty asm-generic implementation of
> asm/compiler.h for all architectures except alpha, arm, arm64, and mips
> (which already have an asm/compiler.h) and leaves the architecture
> specifics to a further patch.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> [jhogan@kernel.org: Forward port and use asm/compiler.h instead of
>  asm/compiler-gcc.h]
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-um@lists.infradead.org

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

