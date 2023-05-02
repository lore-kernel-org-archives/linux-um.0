Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10400C77B73
	for <linux-um@archiver.kernel.org>; Tue,  2 May 2023 03:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GggpdcPSAptl8CMgKhrXuFKMi8nbas8kQ96DuSBSR2E=; b=RgjB77KGMAu6Q5
	uhxtg/iFgnqpKlzfAHZ0mWbWeBg1PprzDwvfukcQO2W7xlYgreAVoPdzSDVHVJO3EzJIGAYrzfOMB
	p0vHY5QWokeh+6pMd94wA5XaSvon/4i1GAkvQigH0l/3UERgfv7P+HaLKhpajSy9/52hdCRVbVHTl
	BFt5I4Te0Ng4oPM+42DVvfB4ttgdQEaxdpQZ9fTOeTMmrIl3SHyQA0mUKubONSX+3uV6qhwFqLCxH
	68vnPCdC5kuJCgj7q2C7xZYcmpnYiOTr1DrQLATJLhvRSxQinI9xLYCOy0ZCw/RrzvK0vhlxEh1q+
	kMp+e/2zLfln+SB6be+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptgtI-0000My-17;
	Tue, 02 May 2023 03:41:24 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptgtF-0000Kx-1G;
	Tue, 02 May 2023 03:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lk75ZjE2r9RBa6YqJgQtuPl1oEa00Vf2+DuensGVbTE=; b=qQ2uYSJQvRohLOGWSCln6IEO14
	AWS5p2O5ZTd5ODiPI6F0vsohKqMjVkXkGAe4VlNE+2MQE2GP3Gw4uoe3qIqOHYPC7X0mxAhOhinfp
	5/L1JXuFNUf+Lljoim297rJ6IwxywLWxnXzWcPAPYKLyjmOA+7NsyXaOFViw2j6vCDdb4Hu4YrEs1
	CpIghGhmOqDjR2CaqPwAGpWEbyAFphEH2Y+Kf4iOiSko9ROTvRG9Nf3pzvEm0jewZz1VFDirplDxy
	fXB0Gux1YpIAjfI46Ja2kzeNad2d6vpgCAlhCoaRKt4yhek8JULiYUND/IGbAUyW2zlXQNf6P5+NT
	ojvWEO1w==;
Received: from mga17.intel.com ([192.55.52.151])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptf94-00F5xk-2m;
	Tue, 02 May 2023 01:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682992174; x=1714528174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=atYvzhPCCZ/tytx2DE7s23i4jWidElWSRjsH6cc5aEY=;
  b=kCFZGvegUtAtWwRrLAHMUj2nyW+KW5Ss5SyScvB5cwlyZ0tJfJoVvwmc
   OF/0GmmevwLHpkVuNho4Zp4PGV012FRBO75wtAFdApMFYdjwzrN4A4tDV
   8mNuEBEdN7fV7nQbvINirZkprqSpCTzqXWNyUPBjHMizt6KunR1X4dHa7
   DDyyMUx1PQHBM24sBkvSivuAtcg3ykbmRdROhRAxETA7gC56ayPiCiSuQ
   bPuahHfboOV4YTkge/T0SSCLLRZz6TOa6bl9v/ViZfep3/iqpwk6pdqHa
   NUnqOThzoalrLEIiRORoosV4QG0z8mqrX3/z5s+J134OqaE6sAQNzwdPB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="328651232"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="328651232"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 18:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="698763727"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="698763727"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 May 2023 18:49:20 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ptf8q-0000ke-0J;
	Tue, 02 May 2023 01:49:20 +0000
Date: Tue, 2 May 2023 09:48:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 21/34] arm64: Convert various functions to use ptdescs
Message-ID: <202305020914.OGRWcEG1-lkp@intel.com>
References: <20230501192829.17086-22-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230501192829.17086-22-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_024937_634227_7FD88398 
X-CRM114-Status: GOOD (  13.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Vishal,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20230428]
[cannot apply to s390/features powerpc/next powerpc/fixes geert-m68k/for-next geert-m68k/for-linus v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/mm-Add-PAGE_TYPE_OP-folio-functions/20230502-033042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230501192829.17086-22-vishal.moola%40gmail.com
patch subject: [PATCH v2 21/34] arm64: Convert various functions to use ptdescs
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230502/202305020914.OGRWcEG1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8e9481b63b5773d7c914836dcd7fbec2449902bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/mm-Add-PAGE_TYPE_OP-folio-functions/20230502-033042
        git checkout 8e9481b63b5773d7c914836dcd7fbec2449902bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305020914.OGRWcEG1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:21,
                    from include/linux/bitops.h:6,
                    from arch/arm64/include/asm/cache.h:39,
                    from include/linux/cache.h:6,
                    from arch/arm64/mm/mmu.c:9:
   arch/arm64/mm/mmu.c: In function 'pgd_pgtable_alloc':
>> arch/arm64/mm/mmu.c:440:24: error: invalid use of void expression
     440 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                        ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/arm64/mm/mmu.c:440:17: note: in expansion of macro 'BUG_ON'
     440 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                 ^~~~~~
   arch/arm64/mm/mmu.c:442:24: error: invalid use of void expression
     442 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                        ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/arm64/mm/mmu.c:442:17: note: in expansion of macro 'BUG_ON'
     442 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                 ^~~~~~


vim +440 arch/arm64/mm/mmu.c

   425	
   426	static phys_addr_t pgd_pgtable_alloc(int shift)
   427	{
   428		phys_addr_t pa = __pgd_pgtable_alloc(shift);
   429		struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
   430	
   431		/*
   432		 * Call proper page table ctor in case later we need to
   433		 * call core mm functions like apply_to_page_range() on
   434		 * this pre-allocated page table.
   435		 *
   436		 * We don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK if pmd is
   437		 * folded, and if so ptdesc_pte_dtor() becomes nop.
   438		 */
   439		if (shift == PAGE_SHIFT)
 > 440			BUG_ON(!ptdesc_pte_dtor(ptdesc));
   441		else if (shift == PMD_SHIFT)
   442			BUG_ON(!ptdesc_pte_dtor(ptdesc));
   443	
   444		return pa;
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
