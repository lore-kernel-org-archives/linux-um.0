Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 31 Mar 2021 12:28:57 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] mm: Move mem_init_print_info() into mm_init()
Message-ID: <YGRA2SU28yciN9xU@kernel.org>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
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
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Richard Henderson <rth@twiddle.net>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Huacai Chen <chenhuacai@kernel.org>, Jonas Bonn <jonas@southpole.se>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org

On Wed, Mar 17, 2021 at 09:52:10AM +0800, Kefeng Wang wrote:
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2:
> - Cleanup 'str' line suggested by Christophe and ACK
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

