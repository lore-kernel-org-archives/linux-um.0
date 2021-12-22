Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 22 Dec 2021 12:12:00 +0800
From: kernel test robot <lkp@intel.com>
Subject: [rw-uml:linux-next 28/29] arch/x86/kvm/mmu/spte.c:85:6: error:
 implicit declaration of function 'pat_enabled'; did you mean
 'kasan_enabled'?
Message-ID: <202112221002.dpWf8YCs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Christoph Hellwig <hch@lst.de>
Cc: kbuild-all@lists.01.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
head:   5d0f822da145a87c38bf9162bebdce865e6ad359
commit: 59a49f02bbc8b44ed1a8b9603b1a6aa620cca3b4 [28/29] x86/mtrr: remove the mtrr_bp_init stub
config: x86_64-randconfig-a001-20211220 (https://download.01.org/0day-ci/archive/20211222/202112221002.dpWf8YCs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git/commit/?id=59a49f02bbc8b44ed1a8b9603b1a6aa620cca3b4
        git remote add rw-uml https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
        git fetch --no-tags rw-uml linux-next
        git checkout 59a49f02bbc8b44ed1a8b9603b1a6aa620cca3b4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/mmu/spte.c: In function 'kvm_is_mmio_pfn':
>> arch/x86/kvm/mmu/spte.c:85:6: error: implicit declaration of function 'pat_enabled'; did you mean 'kasan_enabled'? [-Werror=implicit-function-declaration]
      85 |    (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
         |      ^~~~~~~~~~~
         |      kasan_enabled
>> arch/x86/kvm/mmu/spte.c:85:23: error: implicit declaration of function 'pat_pfn_immune_to_uc_mtrr' [-Werror=implicit-function-declaration]
      85 |    (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +85 arch/x86/kvm/mmu/spte.c

5a9624affe7c74 Paolo Bonzini 2020-10-16  70  
5a9624affe7c74 Paolo Bonzini 2020-10-16  71  static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
5a9624affe7c74 Paolo Bonzini 2020-10-16  72  {
5a9624affe7c74 Paolo Bonzini 2020-10-16  73  	if (pfn_valid(pfn))
5a9624affe7c74 Paolo Bonzini 2020-10-16  74  		return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn)) &&
5a9624affe7c74 Paolo Bonzini 2020-10-16  75  			/*
5a9624affe7c74 Paolo Bonzini 2020-10-16  76  			 * Some reserved pages, such as those from NVDIMM
5a9624affe7c74 Paolo Bonzini 2020-10-16  77  			 * DAX devices, are not for MMIO, and can be mapped
5a9624affe7c74 Paolo Bonzini 2020-10-16  78  			 * with cached memory type for better performance.
5a9624affe7c74 Paolo Bonzini 2020-10-16  79  			 * However, the above check misconceives those pages
5a9624affe7c74 Paolo Bonzini 2020-10-16  80  			 * as MMIO, and results in KVM mapping them with UC
5a9624affe7c74 Paolo Bonzini 2020-10-16  81  			 * memory type, which would hurt the performance.
5a9624affe7c74 Paolo Bonzini 2020-10-16  82  			 * Therefore, we check the host memory type in addition
5a9624affe7c74 Paolo Bonzini 2020-10-16  83  			 * and only treat UC/UC-/WC pages as MMIO.
5a9624affe7c74 Paolo Bonzini 2020-10-16  84  			 */
5a9624affe7c74 Paolo Bonzini 2020-10-16 @85  			(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
5a9624affe7c74 Paolo Bonzini 2020-10-16  86  
5a9624affe7c74 Paolo Bonzini 2020-10-16  87  	return !e820__mapped_raw_any(pfn_to_hpa(pfn),
5a9624affe7c74 Paolo Bonzini 2020-10-16  88  				     pfn_to_hpa(pfn + 1) - 1,
5a9624affe7c74 Paolo Bonzini 2020-10-16  89  				     E820_TYPE_RAM);
5a9624affe7c74 Paolo Bonzini 2020-10-16  90  }
5a9624affe7c74 Paolo Bonzini 2020-10-16  91  

:::::: The code at line 85 was first introduced by commit
:::::: 5a9624affe7c7498fb395879d9bb613628e89e60 KVM: mmu: extract spte.h and spte.c

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

