Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJV2Y-00DUlV-Nz
 for linux-um@lists.infradead.org; Mon, 14 Feb 2022 06:40:52 +0000
Date: Mon, 14 Feb 2022 14:40:39 +0800
From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 23/30] um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <202202141426.Q2fKI6yq-lkp@intel.com>
References: <1644805853-21338-24-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1644805853-21338-24-git-send-email-anshuman.khandual@arm.com>
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
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-mmap-Drop-protection_map-and-platform-s-__SXXX-__PXXX-requirements/20220214-103534
base:   https://github.com/hnaz/linux-mm master
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220214/202202141426.Q2fKI6yq-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f96d6fa064e3f24686f111d1b4c06b865ca103ec
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-protection_map-and-platform-s-__SXXX-__PXXX-requirements/20220214-103534
        git checkout f96d6fa064e3f24686f111d1b4c06b865ca103ec
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/mem_32.c: In function 'gate_vma_init':
>> arch/x86/um/mem_32.c:20:26: error: '__P101' undeclared (first use in this function)
      20 |  gate_vma.vm_page_prot = __P101;
         |                          ^~~~~~
   arch/x86/um/mem_32.c:20:26: note: each undeclared identifier is reported only once for each function it appears in


vim +/__P101 +20 arch/x86/um/mem_32.c

548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  10  
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  11  static int __init gate_vma_init(void)
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  12  {
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  13  	if (!FIXADDR_USER_START)
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  14  		return 0;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  15  
2c4541e24c55e2 arch/x86/um/mem_32.c   Kirill A. Shutemov 2018-07-26  16  	vma_init(&gate_vma, NULL);
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  17  	gate_vma.vm_start = FIXADDR_USER_START;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  18  	gate_vma.vm_end = FIXADDR_USER_END;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  19  	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25 @20  	gate_vma.vm_page_prot = __P101;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  21  
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  22  	return 0;
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  23  }
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  24  __initcall(gate_vma_init);
548f0a4e02f6fa arch/um/sys-i386/mem.c Richard Weinberger 2011-07-25  25  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

