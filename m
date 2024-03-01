Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2312CC5478C
	for <linux-um@archiver.kernel.org>; Fri,  1 Mar 2024 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8Q0csK5HQzmAPKP2INf0XTuxWQ9dCfXwnf5+0LDkIY=; b=CR4E3DIKXYgTc6kXXfT6n6MaYW
	o+2hTz69MMALfVCQMTeFADgVRZMq848yEhlO0HBA9p/5ALgSW2Fsh48re1DY8vOrkzurEoR/DngEu
	DutiWvxbA9HGwIyRGXLwusY0+aLmRhXaOW7QRWv0MqakSNUwYKb80cVFpPOweEfbqRGfdMmlRx8YO
	U7fI8hja77wK61H0UJQYbXtfKuZgWBzrPR6i6xPHkn2qVjZzYdLYTdJZm5eSX/PfqCXAN7c9PeppH
	git5Bqev5VtGm7YK6R3u6V/IhaEj/ytMDo9IHWtEhyc1dYt2NgfogQvqi8dcencKBtwo+RNxR64o7
	9irkrLQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg9jW-00000001vBJ-0vqx;
	Fri, 01 Mar 2024 20:43:54 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg9jT-00000001vAl-2lNS
	for linux-um@lists.infradead.org;
	Fri, 01 Mar 2024 20:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709325832; x=1740861832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kUyMdHkVkpeJxiyTY9gwfrRpGuWeFO/2yLcwV4ze4PY=;
  b=J7sdiITJ1kAZr8sgz50mVhoWucZdfvkoFsu+OXac+ZYGYPkQFX5OPufN
   GYcmyMdCwuJePDNkldKBwQ6Phco2fJwTUK2a/EYPGiSOa6dTn5qX5w9/w
   CROt2hwL/xvur3IU3TOkt5EJb7dPdWtOr06eQ3UiXhTGSTMmZ6lUzvNpT
   D+4P4zIm2il4OlYlml1+oBehYmh+3/dx5FXGBN/UfMgwIx+r9AaOG4YTA
   jSKPPtaCV5JYuqmCgCIxKjCPVLwsnronNpJzofoZ/sbagtThIMm4oXZ+O
   JCuLQ7HKbUTVjG3yx+nnYsf8kbPkClwW+teTUG1nqvpO7nCvbuGsZxFXc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3808087"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3808087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8374083"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 01 Mar 2024 12:43:42 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg9j3-000E5D-2e;
	Fri, 01 Mar 2024 20:43:32 +0000
Date: Sat, 2 Mar 2024 04:42:59 +0800
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
Subject: Re: [PATCH v1 8/8] kunit: Add tests for faults
Message-ID: <202403020418.NnNnFElm-lkp@intel.com>
References: <20240229170409.365386-9-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-9-mic@digikod.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_124351_764062_9B6643B7 
X-CRM114-Status: GOOD (  10.01  )
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
patch link:    https://lore.kernel.org/r/20240229170409.365386-9-mic%40digikod.net
patch subject: [PATCH v1 8/8] kunit: Add tests for faults
config: x86_64-randconfig-122-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020418.NnNnFElm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020418.NnNnFElm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403020418.NnNnFElm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/kunit/kunit-test.c:142:11: sparse: sparse: symbol 'test_const' was not declared. Should it be static?

vim +/test_const +142 lib/kunit/kunit-test.c

   141	
 > 142	const int test_const = 1;
   143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

