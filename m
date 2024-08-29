Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AF9CA0EC0
	for <linux-um@archiver.kernel.org>; Thu, 29 Aug 2024 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wl27i+QCEeSJ8Ard5AEzz55VWiVll/cYb7Ss2F9Tqt4=; b=FU9998PNPIE4XFIV/r8H6s5BBp
	0nNXJEqOKtoEon/a8XK5kGTS4nLtWAXAPO9J0U++nrR084hHIYE+aGtDaN8bQFRl1ZPhUa9QLZcCw
	6ABFvDDEsq1RwcaLe0WShtBraPkAafVpTshXsB9LxRagIkFv+wR128UNlWn+m50ANkQBXm4irXCFe
	pi+Y/FVKKXb4EudeAhMwpN8qvL7mZ8dwot2Fg/LlWoLRD0pGXSY86DgvUlZLAyFEMohBbHLngnqTX
	zhyMjzvCvEfFfv79JRAAVFkiaoxJmtr1SndaXjJ4bcLWh7Wc0rmLmA3mwnGUuy37+yYWtxkQfE+Qy
	KN4B7wGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjlvG-00000003ZVL-40YP;
	Thu, 29 Aug 2024 20:39:14 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjluL-00000003ZGx-45fg;
	Thu, 29 Aug 2024 20:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724963898; x=1756499898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tscwRgI2saPDR7x1unDsFBI0xOp0fMmY1QDhyt+9PHk=;
  b=cQm4igAS49yxq7EgY10V3vTbokocyvdfwJA2qZO7Ci609uHIi1xqBCwz
   3L40+VEgYnZWsKWVUcA6nvAiE0lZFandEBIQddOKqB+1kHkpnnQEuCOns
   uN26713eJlUa9PkgmEPGdDNeSDwAQsWicvVUv9/zEzHX1Vmo9egMD7Jvv
   D2r1eS62j68JLoi/goUNR0HnRNJY4ckQ/dfSaIltNPSM9pelYpi2J4B3M
   v1uWAUusTKFvrQzad/Lv3Lw0QHddoNp4SEcZMNkRx7D+wLR55+3XPQPpw
   5txNqlmATodckcWBEex8iLa9ioYQM+pl5dXnmYyNneO6IYcTZBAFyn0vp
   A==;
X-CSE-ConnectionGUID: 02Mdb184R8eeHj2OPbxNqQ==
X-CSE-MsgGUID: GBAsdKigSwO8z3SpdbXX0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34200569"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34200569"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:37:41 -0700
X-CSE-ConnectionGUID: +2I+PKpfTEWO7ZhOV/mdjw==
X-CSE-MsgGUID: 9jFLsk+2R9icUo/uf7t0Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63325399"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2024 13:37:38 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjltg-0000iM-02;
	Thu, 29 Aug 2024 20:37:36 +0000
Date: Fri, 30 Aug 2024 04:37:35 +0800
From: kernel test robot <lkp@intel.com>
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-um@lists.infradead.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] kbuild: use objcopy to generate asm-offsets
Message-ID: <202408300438.xObK98m5-lkp@intel.com>
References: <20240828083605.3093701-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828083605.3093701-1-vegard.nossum@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_133818_057747_DF9B4825 
X-CRM114-Status: GOOD (  13.39  )
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

Hi Vegard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on masahiroy-kbuild/fixes soc/for-next kvmarm/next kvm/queue uml/next krzk-mem-ctrl/for-next bpf-next/master bpf/master linus/master v6.11-rc5 next-20240829]
[cannot apply to tmlind-omap/for-next kvm/linux-next uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vegard-Nossum/kbuild-use-objcopy-to-generate-asm-offsets/20240828-163854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240828083605.3093701-1-vegard.nossum%40oracle.com
patch subject: [PATCH] kbuild: use objcopy to generate asm-offsets
config: mips-loongson3_defconfig (https://download.01.org/0day-ci/archive/20240830/202408300438.xObK98m5-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300438.xObK98m5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300438.xObK98m5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mips64el-linux-objcopy: /dev/stdout[.data.kbuild]: Illegal seek
   In file included from include/linux/mm_types.h:18,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/compat.h:15,
                    from arch/mips/kernel/asm-offsets.c:12:
   include/linux/page-flags-layout.h:15:5: warning: "MAX_NR_ZONES" is not defined, evaluates to 0 [-Wundef]
      15 | #if MAX_NR_ZONES < 2
         |     ^~~~~~~~~~~~
   include/linux/page-flags-layout.h:58:19: warning: "LRU_GEN_WIDTH" is not defined, evaluates to 0 [-Wundef]
      58 | #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_SHIFT \
         |                   ^~~~~~~~~~~~~
   include/linux/page-flags-layout.h:59:28: warning: "NR_PAGEFLAGS" is not defined, evaluates to 0 [-Wundef]
      59 |         <= BITS_PER_LONG - NR_PAGEFLAGS
         |                            ^~~~~~~~~~~~
   include/linux/page-flags-layout.h:93:19: warning: "LRU_GEN_WIDTH" is not defined, evaluates to 0 [-Wundef]
      93 | #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + \
         |                   ^~~~~~~~~~~~~
   include/linux/page-flags-layout.h:94:64: warning: "NR_PAGEFLAGS" is not defined, evaluates to 0 [-Wundef]
      94 |         KASAN_TAG_WIDTH + LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
         |                                                                ^~~~~~~~~~~~
   include/linux/page-flags-layout.h:104:19: warning: "LRU_GEN_WIDTH" is not defined, evaluates to 0 [-Wundef]
     104 | #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + \
         |                   ^~~~~~~~~~~~~
   include/linux/page-flags-layout.h:105:63: warning: "NR_PAGEFLAGS" is not defined, evaluates to 0 [-Wundef]
     105 |         KASAN_TAG_WIDTH + LAST_CPUPID_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
         |                                                               ^~~~~~~~~~~~
   In file included from include/linux/mm_types.h:5:
   include/linux/mm_types_task.h:22:34: warning: "SPINLOCK_SIZE" is not defined, evaluates to 0 [-Wundef]
      22 | #define ALLOC_SPLIT_PTLOCKS     (SPINLOCK_SIZE > BITS_PER_LONG/8)
         |                                  ^~~~~~~~~~~~~
   include/linux/mm_types.h:478:5: note: in expansion of macro 'ALLOC_SPLIT_PTLOCKS'
     478 | #if ALLOC_SPLIT_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/dcache.h:14,
                    from include/linux/fs.h:8,
                    from include/linux/compat.h:17:
>> include/linux/lockref.h:23:36: warning: "SPINLOCK_SIZE" is not defined, evaluates to 0 [-Wundef]
      23 |          IS_ENABLED(CONFIG_SMP) && SPINLOCK_SIZE <= 4)
         |                                    ^~~~~~~~~~~~~
   include/linux/lockref.h:27:5: note: in expansion of macro 'USE_CMPXCHG_LOCKREF'
      27 | #if USE_CMPXCHG_LOCKREF
         |     ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13:
   include/linux/mmzone.h:842:29: error: 'MAX_NR_ZONES' undeclared here (not in a function); did you mean 'MAX_NR_GENS'?
     842 |         long lowmem_reserve[MAX_NR_ZONES];
         |                             ^~~~~~~~~~~~
         |                             MAX_NR_GENS
   include/linux/mm_types_task.h:22:34: warning: "SPINLOCK_SIZE" is not defined, evaluates to 0 [-Wundef]
      22 | #define ALLOC_SPLIT_PTLOCKS     (SPINLOCK_SIZE > BITS_PER_LONG/8)
         |                                  ^~~~~~~~~~~~~
   include/linux/mm.h:2889:5: note: in expansion of macro 'ALLOC_SPLIT_PTLOCKS'
    2889 | #if ALLOC_SPLIT_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/mips/kernel/asm-offsets.c:17:
   include/linux/memcontrol.h: In function 'mem_cgroup_get_zone_lru_size':
>> include/linux/memcontrol.h:914:31: warning: parameter 'lru' set but not used [-Wunused-but-set-parameter]
     914 |                 enum lru_list lru, int zone_idx)
         |                 ~~~~~~~~~~~~~~^~~
>> include/linux/memcontrol.h:914:40: warning: parameter 'zone_idx' set but not used [-Wunused-but-set-parameter]
     914 |                 enum lru_list lru, int zone_idx)
         |                                    ~~~~^~~~~~~~
   make[3]: *** [scripts/Makefile.build:244: arch/mips/kernel/asm-offsets.o] Error 1
   make[3]: Target 'missing-syscalls' not remade because of errors.
   make[2]: *** [arch/mips/Makefile:432: archprepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/SPINLOCK_SIZE +23 include/linux/lockref.h

57f4257eae33e0 Peter Zijlstra     2013-11-14  20  
57f4257eae33e0 Peter Zijlstra     2013-11-14  21  #define USE_CMPXCHG_LOCKREF \
57f4257eae33e0 Peter Zijlstra     2013-11-14  22  	(IS_ENABLED(CONFIG_ARCH_USE_CMPXCHG_LOCKREF) && \
597d795a2a786d Kirill A. Shutemov 2013-12-20 @23  	 IS_ENABLED(CONFIG_SMP) && SPINLOCK_SIZE <= 4)
0f8f2aaaab0b0f Waiman Long        2013-08-28  24  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

