Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EFAC83F2D
	for <linux-um@archiver.kernel.org>; Thu, 29 Aug 2024 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKmSo9LAS5flNNXPXvF0G2+OvSrW3HArpAikErWUHgI=; b=XlX768S5hyCtfK2k8P8xcxJ1PK
	FC2l0AXC8kkAm5inKcJ/QHj4IZDozohdiE4ZRgmnbZIooUTi60nF0NS3azqYXV3meLKgjeeJDUrb9
	cWF6CfUyWL5YwgwLR3xmfMifwvoHDPc5MXd/FTt0mnpa529WNlq6N8AycB7Phss766UpzqwT/BjNQ
	5VB6xunQLiEYQqSbFnbLITKwd7z4LdmJz1BF+cSdJBNALcWui0JeGh7pYpDGnF0rTH3eWmUMv5Sq1
	M8NBi3OiNlWwWIG68vOOFBUQjwzDENdItQd84GHfgANjLvveKXnYMP7PA6Qhkg3bkEYrnFDC7Atam
	w+3ZCj3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjhRM-00000002hXN-3VMe;
	Thu, 29 Aug 2024 15:52:04 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjhPr-00000002h6s-0XCU;
	Thu, 29 Aug 2024 15:50:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724946631; x=1756482631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MXbs9o4JsCqnOHzV2NkYU9Q0uIU+cS5hql1pqmeZMs8=;
  b=brZmY7atZgVb8/qr2bhXSYU56jxl4n5zmEA8lVuq9JqMnoOeZ+fvo7t5
   1cJV8YdvZEIMzkQfrvaJJIhUdp4kALNbxK0/lcoA/enxJu6EXPkOxALHG
   vznckwlGgkNtwzE0QREN3tQTMxnU4E0a7lZC9xasYYuoqL/Kg6ZaWgChY
   tkV1wMOkktK4iJIYgwLPZxIxCwXjTAP85FbaG8am7mZNtrEWTcrek21g/
   QBfK1RqXPl6bTJiM+P7LWUqgLyXNaaPYoBi2a2Qb8H/GvNJI1UPXhwExw
   IIkGVqcHIvlc1uBd/i2b9qBMwkwjGdSu99Bt6F+Oq44b/lwZOVZtMaknA
   g==;
X-CSE-ConnectionGUID: a8LP9eKOT6WACTJJCwnPZw==
X-CSE-MsgGUID: R5xUkCv8StKziNT16JYqYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23505189"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23505189"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:50:30 -0700
X-CSE-ConnectionGUID: J83LXIxzSzmT98GJ4pj8/A==
X-CSE-MsgGUID: Z+lyrEAUTdejag2LclzVgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63943997"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Aug 2024 08:50:27 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjhPl-0000Py-0J;
	Thu, 29 Aug 2024 15:50:25 +0000
Date: Thu, 29 Aug 2024 23:50:06 +0800
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
Message-ID: <202408292301.KMuvybe3-lkp@intel.com>
References: <20240828083605.3093701-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828083605.3093701-1-vegard.nossum@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_085031_282459_9CC6DF0D 
X-CRM114-Status: GOOD (  11.56  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on masahiroy-kbuild/fixes soc/for-next kvmarm/next kvm/queue uml/next krzk-mem-ctrl/for-next bpf-next/master bpf/master linus/master v6.11-rc5 next-20240829]
[cannot apply to tmlind-omap/for-next kvm/linux-next uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vegard-Nossum/kbuild-use-objcopy-to-generate-asm-offsets/20240828-163854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240828083605.3093701-1-vegard.nossum%40oracle.com
patch subject: [PATCH] kbuild: use objcopy to generate asm-offsets
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240829/202408292301.KMuvybe3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408292301.KMuvybe3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408292301.KMuvybe3-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}: Error: .size expression for main does not evaluate to a constant
   make[3]: *** [scripts/Makefile.build:244: scripts/mod/devicetable-offsets.o] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1192: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

