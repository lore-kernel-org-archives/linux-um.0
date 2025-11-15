Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4026ECE8D6B
	for <linux-um@archiver.kernel.org>; Sat, 15 Nov 2025 01:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YHiX1X/OH2B97KYDjNGeXl/+3uOQJEMtQdEIGNbLMqM=; b=czi/iHC7mqZyqxFTirohCwJym9
	l7O0FixCfLEF7aw5rgeoq8y9YDUbNVdCY1K8Az9V3i5lS8eXjC8fqj5mYyS82wqSpihx+Aishrq4E
	Y6rfebHz/JtthcmGAYXjEluad0aG+qFzSb65fdlZQI1EL4vXNL7Yz/0g+fCzGigYKfeDBoIw5XxL/
	J7g9zmh25KbsruAuZa0+Qr6xe7bwORAdfVxX3ZcvD2rN39iQ3h0RBR4OWnX2+nD4g+xkcCLow57UO
	TxLTDlX/DgjxYuVBW0RoZbIYYfQ7byy9xjeWkJ8JA4Mi6xI66s6e9lN/fQcdjPCMp6WCd0rRHvLXy
	Yy3RtSxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK4qi-0000000DK6d-3CgJ;
	Sat, 15 Nov 2025 01:13:08 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK4qf-0000000DK67-1Cz8;
	Sat, 15 Nov 2025 01:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763169186; x=1794705186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZYpyydEIKJdUZcKYOQA153wYBuCQw3r8OGWjWBD7bf0=;
  b=dPqc7lYJluAen6/03LeiCqZityRJO6jJ/yRTs4vS+1KkSQRt1ppG9TQh
   beTpnfmhE2Ilss+FmwiRb7cpDFXzLuN+UYZaCrDWGnTxq3Yhrsi3yh52d
   wsXwI5Nu0cdMu/+kRNvHhGK1Mo3eefKqiaokkjetqJCZznGweVFIaq0I3
   kdzxf4YumjRV+23zBfGAD/cseeemRfJ20iOwWlGXYdWEd5bz6Dp+AP/Qe
   DxaVfKZ2sCgryKFAeZzyLqocyYI+jkNz7SFDqTg20Tg2gFi13VJabP4nC
   AefZNA1nvrR1nv+yEeYrzZm9Y/XwVciytZJ074df4awS9at9t+WqdV4mM
   g==;
X-CSE-ConnectionGUID: +hCVuBiuQDygqwVFV/cjBw==
X-CSE-MsgGUID: ejaD8FF9QxOL2MIPk1pT0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="65152399"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="65152399"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 17:13:03 -0800
X-CSE-ConnectionGUID: OyXkE+18SIC4r9bUHnq2cQ==
X-CSE-MsgGUID: 7wNDei3wRnCT1vSqROvBmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="194228351"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Nov 2025 17:12:59 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vK4qW-0007Zv-1X;
	Sat, 15 Nov 2025 01:12:56 +0000
Date: Sat, 15 Nov 2025 09:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
	akpm@linux-foundation.org, david@redhat.com, ioworker0@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
Message-ID: <202511150832.iAyO0SAW-lkp@intel.com>
References: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_171305_374404_21BCBF0E 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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

Hi Qi,

kernel test robot noticed the following build errors:

[auto build test ERROR on deller-parisc/for-next]
[also build test ERROR on uml/next tip/x86/core akpm-mm/mm-everything linus/master v6.18-rc5 next-20251114]
[cannot apply to uml/fixes vgupta-arc/for-next vgupta-arc/for-curr]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/alpha-mm-enable-MMU_GATHER_RCU_TABLE_FREE/20251114-191543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
patch link:    https://lore.kernel.org/r/0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch%40bytedance.com
patch subject: [PATCH 7/7] mm: make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE && 64BIT
config: arm64-randconfig-002-20251115 (https://download.01.org/0day-ci/archive/20251115/202511150832.iAyO0SAW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511150832.iAyO0SAW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511150832.iAyO0SAW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/pt_reclaim.c:31:2: error: call to undeclared function '__pte_free_tlb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      31 |         pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
         |         ^
   include/asm-generic/tlb.h:731:3: note: expanded from macro 'pte_free_tlb'
     731 |                 __pte_free_tlb(tlb, ptep, address);             \
         |                 ^
   1 error generated.


vim +/__pte_free_tlb +31 mm/pt_reclaim.c

6375e95f381e3d Qi Zheng 2024-12-04  27  
6375e95f381e3d Qi Zheng 2024-12-04  28  void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
6375e95f381e3d Qi Zheng 2024-12-04  29  	      pmd_t pmdval)
6375e95f381e3d Qi Zheng 2024-12-04  30  {
6375e95f381e3d Qi Zheng 2024-12-04 @31  	pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
6375e95f381e3d Qi Zheng 2024-12-04  32  	mm_dec_nr_ptes(mm);
6375e95f381e3d Qi Zheng 2024-12-04  33  }
6375e95f381e3d Qi Zheng 2024-12-04  34  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

