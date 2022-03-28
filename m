Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <808b18df-bc24-9eeb-005e-7e38c451ced1@infradead.org>
Date: Mon, 28 Mar 2022 07:59:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] um: use asm-generic/dma-mapping.h
Content-Language: en-US
References: <20220328094625.662ac14072bc.I1a0d087aeafbbf363b49f149371d67677a33544f@changeid>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220328094625.662ac14072bc.I1a0d087aeafbbf363b49f149371d67677a33544f@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 3/28/22 00:46, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If DMA (PCI over virtio) is enabled, then some drivers may
> enable CONFIG_DMA_OPS as well, and then we pull in the x86
> definition of get_arch_dma_ops(), which uses the dma_ops
> symbol, which isn't defined.
> 
> Since we don't have real DMA ops nor any kind of IOMMU fix
> this in the simplest possible way: pull in the asm-generic
> file instead of inheriting the x86 one. It's not clear why
> those drivers that do (e.g. VDPA) "select DMA_OPS", and if
> they'd even work with this, but chances are nobody will be
> wanting to do that anyway, so fixing the build failure is
> good enough.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  arch/um/include/asm/Kbuild | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index e5a7b552bb38..a8c763c296b4 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -4,6 +4,7 @@ generic-y += bug.h
>  generic-y += compat.h
>  generic-y += current.h
>  generic-y += device.h
> +generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
>  generic-y += extable.h

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

