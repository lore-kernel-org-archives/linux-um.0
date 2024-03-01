Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE8FC5478C
	for <linux-um@archiver.kernel.org>; Fri,  1 Mar 2024 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gwtjtt2Gk/Tv+5xM/A6P+aUVhd1MhGUQpewlF1WJuJ0=; b=Bq7rUMnrN0pO8k47Yr5GtACKXl
	kqr/rpqAgv/0R/OXC9YqAhfN24tg6aVcVPv+1W0RDC+Uwx0gtyeK2NveArDbuEO3Cdb2ixg7M4o9X
	+/0lO51P9ftuQXhxU+fvucvAnk+ZeVrG7/I/Hbz4T5F1bfT9NvPtevuPVat/+SrbuzirXHH/C9IsN
	CwXsLgpEUrl9O2rLKDESbzcjY+GUGGf6a8quCy4OCRHHc6C/LF9Yih2NkNzWUIcw11zSfeQVAGAbS
	8YhHVFkEVfKD4T8zah14MTWRHeFL9oYb8AiusW1KIPmRSr/Ddg7utpMmHqnvfT3/2JSDTGrQbUD8h
	ldGlyILw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfvTF-0000000GRX7-2pJg;
	Fri, 01 Mar 2024 05:30:09 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfvTC-0000000GRVW-3aye
	for linux-um@lists.infradead.org;
	Fri, 01 Mar 2024 05:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709271006; x=1740807006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yUOV0dq5JKRNnbJJINmDoCKpgeqYWZeaU6kZotwZpuI=;
  b=PcHSuiWSpHKSsbT/bbeuM5XF90v86Ghqz09JnjVeohPROvlnfrAsvk4w
   Zs0nPSJ8D/g6FMyFXNMWifdozOOQrrYSbjRcOslGVOIC9FGye9V5uUQNZ
   9QzCISYwdEHBUK6g/kmfTfRVGNVzGC6J53epGa1fAsovQqwW0EV0Dc5zR
   cNveEbIkieTCGHGNrSV7XT9p3ajFVzBrqZJxeBJ2sndfGtTU+l6LHdSRC
   Qxy1wxVRCMbKSseES8zbetEfyfNehog8Rwzq8EytR5T2Kla1UgeoJcppk
   PokHMqyqB9BbaTP+3x0Z/miVCLWY0OXa9Z/Dy8Kt7FOc6UubSW2OLilNu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15226248"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15226248"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 21:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12766605"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Feb 2024 21:29:59 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfvT2-000DZ8-2R;
	Fri, 01 Mar 2024 05:29:56 +0000
Date: Fri, 1 Mar 2024 13:29:40 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202403011330.telj6BqQ-lkp@intel.com>
References: <20240229170409.365386-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-2-mic@digikod.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_213006_970233_1E2527CD 
X-CRM114-Status: GOOD (  11.18  )
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
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20240301/202403011330.telj6BqQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403011330.telj6BqQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011330.telj6BqQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/executor.c:18:31: warning: 'final_suite_set' defined but not used [-Wunused-variable]
      18 | static struct kunit_suite_set final_suite_set = {};
         |                               ^~~~~~~~~~~~~~~


vim +/final_suite_set +18 lib/kunit/executor.c

    17	
  > 18	static struct kunit_suite_set final_suite_set = {};
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

