Return-Path: <cmarinas@kernel.org>
Date: Tue, 26 May 2020 18:11:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 03/20] mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option
Message-ID: <20200526171159.GJ17051@gaia>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429121126.17989-4-rppt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-um.lists.infradead.org>

On Wed, Apr 29, 2020 at 03:11:09PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The CONFIG_HAVE_MEMBLOCK_NODE_MAP is used to differentiate initialization
> of nodes and zones structures between the systems that have region to node
> mapping in memblock and those that don't.
> 
> Currently all the NUMA architectures enable this option and for the
> non-NUMA systems we can presume that all the memory belongs to node 0 and
> therefore the compile time configuration option is not required.
> 
> The remaining few architectures that use DISCONTIGMEM without NUMA are
> easily updated to use memblock_add_node() instead of memblock_add() and
> thus have proper correspondence of memblock regions to NUMA nodes.
> 
> Still, free_area_init_node() must have a backward compatible version
> because its semantics with and without CONFIG_HAVE_MEMBLOCK_NODE_MAP is
> different. Once all the architectures will use the new semantics, the
> entire compatibility layer can be dropped.
> 
> To avoid addition of extra run time memory to store node id for
> architectures that keep memblock but have only a single node, the node id
> field of the memblock_region is guarded by CONFIG_NEED_MULTIPLE_NODES and
> the corresponding accessors presume that in those cases it is always 0.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .../vm/numa-memblock/arch-support.txt         |  34 ------
>  arch/alpha/mm/numa.c                          |   4 +-
>  arch/arm64/Kconfig                            |   1 -

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

