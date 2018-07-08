Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH 6/9] kconfig: include kernel/Kconfig.preempt from
 init/Kconfig
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-7-hch@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e007f24e-fea0-9238-73e3-9d8e10290e6c@infradead.org>
Date: Sun, 8 Jul 2018 09:30:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180708152004.21679-7-hch@lst.de>
Content-Language: en-US
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
To: Christoph Hellwig <hch@lst.de>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

On 07/08/2018 08:20 AM, Christoph Hellwig wrote:
> Almost all architectures include it.  Add a ARCH_NO_PREEMPT symbol to
> disable preempt support for alpha, hexagon, non-coldfire m68k and
> user mode Linux.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/Kconfig            | 3 +++
>  arch/alpha/Kconfig      | 1 +
>  arch/arc/Kconfig        | 2 --
>  arch/arm/Kconfig        | 2 --
>  arch/arm64/Kconfig      | 1 -
>  arch/c6x/Kconfig        | 2 --
>  arch/h8300/Kconfig      | 6 ------
>  arch/hexagon/Kconfig    | 1 +
>  arch/ia64/Kconfig       | 2 --
>  arch/m68k/Kconfig       | 5 +----
>  arch/microblaze/Kconfig | 2 --
>  arch/mips/Kconfig       | 2 --
>  arch/nds32/Kconfig      | 1 -
>  arch/nios2/Kconfig      | 2 --
>  arch/openrisc/Kconfig   | 1 -
>  arch/parisc/Kconfig     | 1 -
>  arch/powerpc/Kconfig    | 1 -
>  arch/riscv/Kconfig      | 2 --
>  arch/s390/Kconfig       | 2 --
>  arch/sh/Kconfig         | 2 --
>  arch/sparc/Kconfig      | 2 --
>  arch/um/Kconfig         | 1 +
>  arch/unicore32/Kconfig  | 2 --
>  arch/x86/Kconfig        | 2 --
>  arch/xtensa/Kconfig     | 2 --
>  init/Kconfig            | 1 +
>  kernel/Kconfig.preempt  | 2 ++
>  27 files changed, 10 insertions(+), 43 deletions(-)


-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

