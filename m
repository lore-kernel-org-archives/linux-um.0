Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F49C3DA4A
	for <linux-um@archiver.kernel.org>; Thu, 15 Aug 2024 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kcuJs9Ksa+/Moo1EY1XmKgqdeeBuop9HE91YVi68Nw=; b=waMP1tAftWShFUiVvrZj903gcf
	WylZGmGIE7jbGfDPIZ7QatpW/5IoHBjiWg7Y7f0c9G5HUV7ZpplUy5r/NkNcZiY6lAQdMGB78VETk
	ufsmkHeU77nHBAmO3tbnU4RQWqMjrcCFCxo+yZvKS0kAVkyC1T/m4/UAhnZu3prU6C3dyI8lBPdQ8
	OlZPlS2vpnyuy7zVieAE/lJaJTqJLCEUGgAL9ZrSse26pUDeSVZeRhhYm5TH3osMMk55HaHd2LcTM
	qJcev9p9UAvIWRyAcaAWGRvx2uZJrGzhTh5P3Nf0bILNsgein2Py1lHoRCEN1on/8OQ/Y8DahJvTi
	EKWbPwQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seQUy-00000008qjz-08WU;
	Thu, 15 Aug 2024 02:46:00 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seQUu-00000008qiF-3dQX
	for linux-um@lists.infradead.org;
	Thu, 15 Aug 2024 02:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723689957; x=1755225957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+u3XTavjkbuxY8GKnvcN2PMrpWamDcirFx/TdBwdhs8=;
  b=DuAsBR6535lSJtmHwRfKaqKQenme+xkNR/iQUJIKaj9/7DFKynaQMma6
   u5vBZDJqH/8VoOkbGQDzOq/qZom0pq1/ke9BvTJDuQkw9LeW9BPWNdd5O
   H3WpuHJeiYqxJB6auoY9BX4SqsLq7u4RcF25uSajhf7qo/CrYMvmg4P6J
   zSIvmb3HhOU26ONobPOLndVwCRHNQTCnHipasJa+pEbn3wmrPTkFYmYpB
   d0KEQZ3rYUK/wrRq1+DD57BXLcfDJ4N3f6vLb1fJN889q0mzeCj89WzR9
   d/uZZileJCE7dyqJp66MVF0+sHQufoDPanuTv05Rnze2snIgl5wzh0FiZ
   A==;
X-CSE-ConnectionGUID: WsgFjD4RRVqrsq4tdabt8w==
X-CSE-MsgGUID: Zsb33CuURTCAJx0nNlFFYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21905402"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21905402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:45:53 -0700
X-CSE-ConnectionGUID: e6+ZbYP3Rg6XynfxE0oMGQ==
X-CSE-MsgGUID: SO6r+U/QSlKKQ7j3nvsDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="89918473"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 19:45:51 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seQUn-00036Q-0m;
	Thu, 15 Aug 2024 02:45:49 +0000
Date: Thu, 15 Aug 2024 10:45:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
Message-ID: <202408151035.TtR6QRvZ-lkp@intel.com>
References: <20240814154427.162475-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-2-willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_194557_081529_B4533CD1 
X-CRM114-Status: GOOD (  14.40  )
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
patch link:    https://lore.kernel.org/r/20240814154427.162475-2-willy%40infradead.org
patch subject: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240815/202408151035.TtR6QRvZ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151035.TtR6QRvZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151035.TtR6QRvZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/io.h:11,
                    from include/linux/io.h:14,
                    from lib/iomap_copy.c:7:
   include/linux/pgtable.h: In function 'mk_pte':
>> include/asm-generic/memory_model.h:19:59: error: 'mem_map' undeclared (first use in this function); did you mean 'memcmp'?
      19 | #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
         |                                                           ^~~~~~~
   arch/arc/include/asm/page.h:75:37: note: in definition of macro '__pte'
      75 | #define __pte(x)        ((pte_t) { (x) })
         |                                     ^
   include/asm-generic/memory_model.h:62:33: note: in expansion of macro 'PFN_PHYS'
      62 | #define __pfn_to_phys(pfn)      PFN_PHYS(pfn)
         |                                 ^~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:179:39: note: in expansion of macro '__pfn_to_phys'
     179 | #define pfn_pte(pfn, prot)      __pte(__pfn_to_phys(pfn) | pgprot_val(prot))
         |                                       ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:16: note: in expansion of macro 'pfn_pte'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                ^~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~
   include/asm-generic/memory_model.h:19:59: note: each undeclared identifier is reported only once for each function it appears in
      19 | #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
         |                                                           ^~~~~~~
   arch/arc/include/asm/page.h:75:37: note: in definition of macro '__pte'
      75 | #define __pte(x)        ((pte_t) { (x) })
         |                                     ^
   include/asm-generic/memory_model.h:62:33: note: in expansion of macro 'PFN_PHYS'
      62 | #define __pfn_to_phys(pfn)      PFN_PHYS(pfn)
         |                                 ^~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:179:39: note: in expansion of macro '__pfn_to_phys'
     179 | #define pfn_pte(pfn, prot)      __pte(__pfn_to_phys(pfn) | pgprot_val(prot))
         |                                       ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:16: note: in expansion of macro 'pfn_pte'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                ^~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~


vim +19 include/asm-generic/memory_model.h

a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  17  
67de648211fa04 Andy Whitcroft    2006-06-23  18  #define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
67de648211fa04 Andy Whitcroft    2006-06-23 @19  #define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  20  				 ARCH_PFN_OFFSET)
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  21  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

