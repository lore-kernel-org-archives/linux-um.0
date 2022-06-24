Return-Path: <openrisc-bounces@lists.librecores.org>
Date: Thu, 23 Jun 2022 22:09:39 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Message-ID: <YrVHEw6bjUf62Eh5@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-3-anshuman.khandual@arm.com>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu, hch@infradead.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

On Fri, Jun 24, 2022 at 10:13:15AM +0530, Anshuman Khandual wrote:
> This just converts the generic vm_get_page_prot() implementation into a new
> macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
> when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
> functional change.

mm.h is a huhe header included by almost everything in the kernel.
I'd rather have it in something only included in a few files.  If we
can't find anything suitable it might be worth to add a header just
for this even.

