Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433D8C5475B
	for <linux-um@archiver.kernel.org>; Fri,  1 Mar 2024 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjZPcA2DR7WJOW2lmE0IWlAhQJ+A7HMEq6PSDgApoEY=; b=39FUVbYeXfVrpJvXUvwlM8XE2C
	+jc2gx1HHJOD11B8Z7rp0eRJ5MQRjlDQ14UjbXruO0Vp5Cd1A7LwUsbnO0BsOmtdQodrKjGKGb3Mo
	g1HGai1/irwS+Lu/v9d2wn+fNztv2nH75S7OK4zDY6UEAyE0dtY5R9u2fx0RTlwZP6lh8ThkQfYSP
	EoAfipCc9KaTCCJD7fVCFHlP4y+3QeaAnNziYsDl2Kx54er6NLkRfiyZH3tBhXsv3p96Fo7mjITyF
	fQ6Px6dIY4JxpdrKj17V7zfUNT3paZoPCjNvyubBHMCi1juE4yHyiGqt1hThiiJXFYnY/HKSZ2RL7
	wk2ZN5SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg0gP-0000000HTib-3p9v;
	Fri, 01 Mar 2024 11:04:05 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg0gM-0000000HThm-1aoK
	for linux-um@lists.infradead.org;
	Fri, 01 Mar 2024 11:04:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709291042; x=1740827042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jNe/Uxf2dtNJ+TSKuJ5UUvXN6Zva3VEg28Sf51IxPB8=;
  b=ZHY/nx0lKJB9QddKfvvWu9VcYPZuS6R200BtvyxzRseH63s0wlSjGTjh
   tZfzGanMGl69mMxRSG5NErjAjTrpLkJeAmmQaknAayu4G3PQEvez25Y38
   0DeME+M9+2Ij+2AL4LTePn0LqY/RmhXDR60RzhKP6R1f9hfhtN46wnUSC
   +3ZHlI7QNf4VpSjOj0IB/KcbeBy/yhXU5OZ0de1MRFHysyl/fr6X0ZMNQ
   z4aSgczXdj7RzMtKVj71Q8W+ig81wt8o+QTTSEuyWUc/TLuqWrJcEPWjS
   Aj9rS+VmVlbb/ZgD2NSzfNRIyZsmEnZnhAX6nZ9mYwUj3A2uJpqGN/qJ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3986137"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3986137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8565542"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Mar 2024 03:03:54 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg0gA-000Dnj-32;
	Fri, 01 Mar 2024 11:03:50 +0000
Date: Fri, 1 Mar 2024 19:03:12 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 1/8] kunit: Run tests when the kernel is fully setup
Message-ID: <202403011856.cJe6do38-lkp@intel.com>
References: <20240229170409.365386-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-2-mic@digikod.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_030402_460696_D82002BC 
X-CRM114-Status: GOOD (  12.19  )
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

Hi Mickaël,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d206a76d7d2726f3b096037f2079ce0bd3ba329b]

url:    https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/kunit-Run-tests-when-the-kernel-is-fully-setup/20240301-011020
base:   d206a76d7d2726f3b096037f2079ce0bd3ba329b
patch link:    https://lore.kernel.org/r/20240229170409.365386-2-mic%40digikod.net
patch subject: [PATCH v1 1/8] kunit: Run tests when the kernel is fully setup
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240301/202403011856.cJe6do38-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 325f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403011856.cJe6do38-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011856.cJe6do38-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/kunit/executor.c:4:
   In file included from include/kunit/test.h:24:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> lib/kunit/executor.c:18:31: warning: unused variable 'final_suite_set' [-Wunused-variable]
      18 | static struct kunit_suite_set final_suite_set = {};
         |                               ^~~~~~~~~~~~~~~
   6 warnings generated.


vim +/final_suite_set +18 lib/kunit/executor.c

    17	
  > 18	static struct kunit_suite_set final_suite_set = {};
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

