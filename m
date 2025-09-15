Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AB9CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjp4s9xZQymNxiWaKlAFLgVGn+1Lv/NvW2L6+EuPWwA=; b=NQ+EYVHR7Q5a30uDnclSNmqpGx
	Oe/op157q/bmtrPeffwFCL6vygydPze4rdQzzH8zwNcYcpwPUJjEZ0v+DSVULKe7ai6lQaUJEfvZF
	jPPxcJOH9LwQ/eiPG0asd3zIIpBjYz2OKDPqUeYo/mzwiIBWycUh/UKavMCJ/Myv4aRDnhbSjshQg
	rLHipuGpBRpzdMtf2u3AQ6Ae8sXVXmyD3NZGjpUqD78x4NlTbo4hhsNB6JgzchgX+NW3Xoxgi6Nk0
	dzQA24IJd94/SXiZINVstZjbKcLM4HNk4E8PtE2Zi6aN60SLettRSH7zvlLC+5GU9qIb0sgqJU6K6
	oxmkTPBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6dJ-00000003jOE-4120;
	Mon, 15 Sep 2025 10:40:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6dI-00000003jMf-1j1a
	for linux-um@bombadil.infradead.org;
	Mon, 15 Sep 2025 10:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qjp4s9xZQymNxiWaKlAFLgVGn+1Lv/NvW2L6+EuPWwA=; b=S7P1Hh+L/nyMVQEtz/7iwCbKFW
	GC2bVOljbYnxOp1PAtFCAtO/j/hIb2O0DCcsNmGEmLkKKnnyUtHv89akpOf0qk/Jnl6/NJjL0ooMP
	urkqncfjzNKbAqssr5u07Vqf27SVhvzcwY2Ar9eIMlQQNpqF1J2cK+IGItVWAIZj4v8zF7jwy7Xx8
	cNHs2hEh5KaitCbl4bVykL31Q0cCQB26qV3dN8qDUxdqzmsIMF0E1t5CfodGFM9LvnDJBASFir2mJ
	4yk5wKGR3k6un1Poj4AQQXzlinWsnqDXTq4E0Ddei7QPFSwd+xnaE4v1L0JJrUnqMRYxkl2RomsQW
	3u7oAE/Q==;
Received: from mgamail.intel.com ([198.175.65.19])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6dE-00000006w5k-3Anw
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 10:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757932825; x=1789468825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nzk/WGSFbYXU/3XfPyxSdJhM2+qxUftU2FcBdAr8OJY=;
  b=BewIyd4znwv6WQYjrZkrFAreZJnu4qbBSI8fo3iw+7mip8P2Kq4hVauS
   k5Lvd/gpbhQbNDNpZ2jCBVyVpQumuS3YYkDSm+1+ZyobtE34oERPkv7D4
   UTI7Qt+aZeAaolVISsHusaXhsNCmVoI9XoOdR8LgZ7k5PqfMI9CJUYaH/
   12btbX7KedSnea9VTUKloycOyMEC8B2+pdEWgF9/s2lDmlnqm9D3+wmB1
   aT/L4SsabdFWsdi2jzoyhcLg3IIHonQ++p3i7Ie5sF6pSA0fSLN27gJcu
   oQ8KmnZyhJjv50dbj3g5IOHHGkTPkEn8AzZYE2RNav85qqLriNepW/bHh
   A==;
X-CSE-ConnectionGUID: tcvI4txYT529ZhFexbti+w==
X-CSE-MsgGUID: J3q/qEx2RM6dE3469swAEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="60051248"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60051248"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 03:40:20 -0700
X-CSE-ConnectionGUID: 8iJJl0gJQhq5nxP18SkwKw==
X-CSE-MsgGUID: zy0r3AIKSySNYAJ2rb6mUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173881637"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Sep 2025 03:40:17 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uy6d4-00008h-1O;
	Mon, 15 Sep 2025 10:40:14 +0000
Date: Mon, 15 Sep 2025 18:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/9] um: use tools/include for user files
Message-ID: <202509151828.S0qPk6Du-lkp@intel.com>
References: <20250915071115.1429196-3-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-3-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_114025_239421_A8FBDC5D 
X-CRM114-Status: GOOD (  10.78  )
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

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on uml/next]
[also build test ERROR on uml/fixes linus/master v6.17-rc6 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-compiler-h-fix-__used-definition/20250915-152550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250915071115.1429196-3-benjamin%40sipsolutions.net
patch subject: [PATCH 2/9] um: use tools/include for user files
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20250915/202509151828.S0qPk6Du-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 65ad21d730d25789454d18e811f8ff5db79cb5d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250915/202509151828.S0qPk6Du-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509151828.S0qPk6Du-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <built-in>:3:10: fatal error: 'include/generated/autoconf.h' file not found
       3 | #include "include/generated/autoconf.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: arch/x86/um/user-offsets.s] Error 1
   make[3]: Target 'include/generated/user_constants.h' not remade because of errors.
   make[2]: *** [arch/um/Makefile:121: archprepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

