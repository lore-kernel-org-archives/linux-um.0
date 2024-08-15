Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A78DC531DE
	for <linux-um@archiver.kernel.org>; Thu, 15 Aug 2024 02:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0crSSUOdVm/ONTNl572cKlDTQy43CVTA3GjM9r04a8=; b=1/Gf4bTi9wgmNjsLUHUAjhAvRN
	9QTjsnSyXsqn9Vb4t5M46wT1w0Oytcp5FHeIvZsV8aH3L+H/gFWsh/xl1jQ5pFK//jMFRc+W2ku9l
	quqR9OyIc5r8cEppMzPKC8pX1qxLG2M+IcUF/+Hvxz2bxynSprCcKtZsvzmsrjA2jRbYv72XLPnJP
	UwCE8IhA0/rONn+s2nym4mdCj071uFyt5vnHamTSVtbcCHzqUymvGwk8hlgOC210aRplznMotNzQZ
	Kr3BMncN7ChSl8aBV3ADDH7uqItBWnGJffesNgVL1ve9H1VjN33K73hra82mTqFWNewjiIz7CXyRu
	EfTsz2CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seQUv-00000008qiy-2fSC;
	Thu, 15 Aug 2024 02:45:57 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seQUs-00000008qiF-3bK6
	for linux-um@lists.infradead.org;
	Thu, 15 Aug 2024 02:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723689955; x=1755225955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wN1lGSgwOBVxwBXCDXoWhdwRlgzBubcOETAKBJXANJw=;
  b=NSp4M9mIoNWuiCg/dw6BmxBDBlcWfeGCm8mjU5UVbUuJX9FoMz/3uSQ/
   bMN0PYUxxg0jajMJPFN9DkqnfccUIKo0o39ucL0lfeJWKyrp221k0ga31
   +PGcdrmT3wuJM5DZ//+uLEBx4w97yzyKDV+wWLjygEwgaY/TuCcLLtqkC
   Gv7cVYz7ItYrRBRK9M7We4pOlByrivIihPZab9wZYd5iEE00bXdsh/KgO
   OS3GbTTxczvQupOwJahk797C1kGUyRsEoebTJDqaG9DlhXaDSJKLwvtVm
   /L0yLQVq8j34tsaQ1KtkmCrm0+pVNzwjmtbVTrYpjEzzyPHJNIkNgKo5U
   Q==;
X-CSE-ConnectionGUID: xkY+4sDfRpm+b7B+0/lP9Q==
X-CSE-MsgGUID: 3gbje/voRnmdAb1GRhFEvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21905409"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21905409"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:45:53 -0700
X-CSE-ConnectionGUID: S51CQW4bREuH/ZKw2p5iCw==
X-CSE-MsgGUID: g1bJHEwdRuebaVjuE0SO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="89918474"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 19:45:52 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seQUn-00036S-0t;
	Thu, 15 Aug 2024 02:45:49 +0000
Date: Thu, 15 Aug 2024 10:45:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
Message-ID: <202408151008.zU4OfDoL-lkp@intel.com>
References: <20240814154427.162475-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-2-willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_194555_004858_DE09A0F1 
X-CRM114-Status: GOOD (  13.21  )
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
config: alpha-randconfig-r051-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151008.zU4OfDoL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151008.zU4OfDoL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151008.zU4OfDoL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/alpha/include/asm/page.h:89,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:23,
                    from arch/alpha/kernel/asm-offsets.c:10:
   include/linux/pgtable.h: In function 'mk_pte':
>> include/asm-generic/memory_model.h:47:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/alpha/kernel/asm-offsets.c:11:
   include/linux/mm.h: At top level:
>> include/linux/mm.h:1904:29: error: conflicting types for 'page_to_section'; have 'long unsigned int(const struct page *)'
    1904 | static inline unsigned long page_to_section(const struct page *page)
         |                             ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:47:21: note: previous implicit declaration of 'page_to_section' with type 'int()'
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:117: arch/alpha/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +47 include/asm-generic/memory_model.h

8f6aac419bd590f Christoph Lameter 2007-10-16  39  
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  40  #elif defined(CONFIG_SPARSEMEM)
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  41  /*
1a49123b3434615 Zhang Yanfei      2013-10-03  42   * Note: section's mem_map is encoded to reflect its start_pfn.
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  43   * section[i].section_mem_map == mem_map's address - start_pfn;
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  44   */
67de648211fa041 Andy Whitcroft    2006-06-23  45  #define __page_to_pfn(pg)					\
aa462abe8aaf219 Ian Campbell      2011-08-17  46  ({	const struct page *__pg = (pg);				\
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27 @47  	int __sec = page_to_section(__pg);			\
f05b6284ee5d3be Randy Dunlap      2007-02-10  48  	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec)));	\
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  49  })
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

