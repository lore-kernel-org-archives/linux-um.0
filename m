Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYDA-00EOr6-Bc
 for linux-um@lists.infradead.org; Mon, 14 Feb 2022 10:04:01 +0000
Subject: Re: [PATCH 23/30] um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
References: <1644805853-21338-24-git-send-email-anshuman.khandual@arm.com>
 <202202141426.Q2fKI6yq-lkp@intel.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4063465a-126d-9bef-5831-d8340cb9aaec@arm.com>
Date: Mon, 14 Feb 2022 15:33:56 +0530
MIME-Version: 1.0
In-Reply-To: <202202141426.Q2fKI6yq-lkp@intel.com>
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
To: kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org



On 2/14/22 12:10 PM, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    arch/x86/um/mem_32.c: In function 'gate_vma_init':
>>> arch/x86/um/mem_32.c:20:26: error: '__P101' undeclared (first use in this function)
>       20 |  gate_vma.vm_page_prot = __P101;
>          |                          ^~~~~~
>    arch/x86/um/mem_32.c:20:26: note: each undeclared identifier is reported only once for each function it appears in

Also the following instance still has reference to __PXXX symbols.

arch/arm/lib/uaccess_with_memcpy.c:     user_ptr = vmap(&dst_page, 1, VM_IOREMAP, __pgprot(__P010));

Will fix both.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

