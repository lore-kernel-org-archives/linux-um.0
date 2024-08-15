Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED40C52D7C
	for <linux-um@archiver.kernel.org>; Thu, 15 Aug 2024 04:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NVDP1udvJo79ygBjuGCpYKk0L2EXPUaNPmwey8xY4J8=; b=v7ymg2rRoLzJyyFMA83EuvCBGi
	4C5jD+tvg5tvT0cFuNjl1Rs9+OWJBuSlskPAT5XPJfF1Sygw4JYneVA9ebI3UbzRsFUIoNWr54z7V
	UXfxe2QbsecLsdfCZy/nIUpXzJfoKO6x1dX2UDnXf0PeTffski1SSzjG44zAhn0TypyALlrMT7K5/
	AC/W1B7QQ6Hm5K58GPeiX8cSyBCNgoQDK+yRKggnzHuoCMyXz3oJsKvVgKedUOfzU3sgVMWyr7nIn
	PQxBDekRPV4gtdXaGl5cDe71ZmHNN8137YadC2fYFU5/Ry+PGOk6ifYtR7KfZ1We08Mjvexdao8dS
	GvmYfsQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seRnO-00000008xUa-1CRa;
	Thu, 15 Aug 2024 04:09:06 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seRnK-00000008xTH-09EU
	for linux-um@lists.infradead.org;
	Thu, 15 Aug 2024 04:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723694942; x=1755230942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9z4AfTVcoGr13kMqfy68br6N15Zt4R0Ze/WP37ZrMSw=;
  b=FOS2QmcjV2Wkydxb0iifMDYMASYnfPmEJZg6lLY54c9CoIyngBKrBlsx
   BhlEX++aMZOa0Tr5RqhMBKd4DIu8bTRRN+FRpxJzzd0/xURawSZqY7QHH
   uy4GSLC+wU01JaxTdNdgytRZ/h+OSSx1SMWcd9WA0jE95MMuJC8hUpo9/
   qdFhFwhQ3T5zqPvxsIbMUw4YPxQWAgA9uZk05SYEW8FAUZko0Iu4khwAs
   Sx2g10XU86D/hFjpzunaBOA0DqweIGqYYKG/2at/+S5maD3ByryXcExmy
   CF6/PqDmyJt+HVeia4krU7CZu+MmcM6BXkwfgx3jhu7/s050xDL/0/0yK
   g==;
X-CSE-ConnectionGUID: tgXMYXBuS+2GhENlGbnTAQ==
X-CSE-MsgGUID: DsjDe5LJSsu3TjUmpnuTqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="47344022"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="47344022"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:08:57 -0700
X-CSE-ConnectionGUID: GN/Tr+wuRC2pLnQX3oZfVQ==
X-CSE-MsgGUID: PeZUkHPzRwGOa+UQ1jnVog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="96751066"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Aug 2024 21:08:55 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seRnA-0003Ak-17;
	Thu, 15 Aug 2024 04:08:52 +0000
Date: Thu, 15 Aug 2024 12:08:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH 2/5] x86: Remove custom definition of mk_pte()
Message-ID: <202408151133.BaOdxDkR-lkp@intel.com>
References: <20240814154427.162475-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-3-willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_210902_100885_CD86E8AE 
X-CRM114-Status: GOOD (  11.83  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on geert-m68k/for-linus uml/next linus/master v6.11-rc3 next-20240814]
[cannot apply to uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Introduce-a-common-definition-of-mk_pte/20240815-001852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
patch link:    https://lore.kernel.org/r/20240814154427.162475-3-willy%40infradead.org
patch subject: [PATCH 2/5] x86: Remove custom definition of mk_pte()
config: x86_64-buildonly-randconfig-003-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151133.BaOdxDkR-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151133.BaOdxDkR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151133.BaOdxDkR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:30:
>> include/linux/pgtable.h:47:17: error: call to undeclared function 'page_to_section'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^
   include/asm-generic/memory_model.h:64:21: note: expanded from macro 'page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^
   include/asm-generic/memory_model.h:47:14: note: expanded from macro '__page_to_pfn'
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^
   include/linux/pgtable.h:47:17: note: did you mean '__nr_to_section'?
   include/asm-generic/memory_model.h:64:21: note: expanded from macro 'page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^
   include/asm-generic/memory_model.h:47:14: note: expanded from macro '__page_to_pfn'
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^
   include/linux/mmzone.h:1853:35: note: '__nr_to_section' declared here
    1853 | static inline struct mem_section *__nr_to_section(unsigned long nr)
         |                                   ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
>> include/linux/mm.h:1904:29: error: static declaration of 'page_to_section' follows non-static declaration
    1904 | static inline unsigned long page_to_section(const struct page *page)
         |                             ^
   include/linux/pgtable.h:47:17: note: previous implicit declaration is here
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^
   include/asm-generic/memory_model.h:64:21: note: expanded from macro 'page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^
   include/asm-generic/memory_model.h:47:14: note: expanded from macro '__page_to_pfn'
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^
   2 errors generated.
   make[3]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=262036656
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2 shuffle=262036656
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=262036656
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=262036656
   make: Target 'prepare' not remade because of errors.


vim +/page_to_section +47 include/linux/pgtable.h

1c2f7d14d84f767 Anshuman Khandual       2021-06-30  43  
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14  44) #ifndef mk_pte
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14  45) static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14  46) {
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14 @47) 	return pfn_pte(page_to_pfn(page), pgprot);
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14  48) }
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14  49) #endif
9353c36cfa235ae Matthew Wilcox (Oracle  2024-08-14  50) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

