Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209FBCAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ly8P/gvweOAUEwLkXDAlnGLaZSwz8nYmhlcvlC066xs=; b=o8QV7VAlEPiVIJdxDqpvMCbCmf
	/WZFnwn25iQM3jCEl30hydpnEcBYl5azqscQEnnMYTJBIkisamDuMcSPAzcSMMFgRo8O1qwND/Xat
	AHWQrU9OwybIVzUyoBlWiD0QgXrH4oGAba4Km6bOWJAx+0tK+QvOoYHOg9HBQPOFXsAr7xhDijiUX
	dJf5g1A7cjpNvLftgmbPZtOW8Tt9OPM71clekcB86X3WUWQm35P4o8HW5jyjkarxjnpOL6l8c41Ek
	GAFFcUcOXQ9rmV6yShjMJMTGEPfdOB2+3Y960Ccz1h8sskVPspmtMgrdDAO0iNtVVGBPez3eFiPw4
	HmgMeM6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzi4s-0000000416D-0YQj;
	Fri, 19 Sep 2025 20:51:34 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzi4p-0000000414n-0ALb
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 20:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758315091; x=1789851091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WT/AtW2xlYNnS+78n8UELvwDofVsJ6EkkO2i5EOJ8R8=;
  b=N2NQgmcHffMqRiL6aT4sVzqoaZRpEzgHD1eoS0a72ibQzIhldrCbS1sh
   hTjeclIz1CcxMmBTudvjyemf9IdzcpsCpB3CVrchZ/lls/QAhTUNQpqvq
   fRZJGYd+HMSbPU9yGUligwxxlogXpush4EBRlFHfi5pqQLkrsIQGMOIBj
   hLP0Ds5eZeZxa5E/F6quZCXYJ0vrzuzkc1B+gEk1MrmQI08nKGBUREiFi
   B57tcIH32kM3h5owESaDNUKvQEkWmXAPhFAcRcLsW6biH7L6kSttov6/C
   Iv0uEscxpepiHCD3aPQAwcjsAiuYfdX75pNEBeg3dcOBZZhJUPtGW+S1H
   Q==;
X-CSE-ConnectionGUID: rN5mjtEGTtW/54QSfhf8Kg==
X-CSE-MsgGUID: L9cMZV0TRhGjhLH7OU7csA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64469598"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64469598"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 13:51:29 -0700
X-CSE-ConnectionGUID: XwD47sDGR+igIFw7EOnX+A==
X-CSE-MsgGUID: mlNyeTdkTUyEuCqKl1bt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="175847193"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Sep 2025 13:51:27 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzi4i-0004nP-3C;
	Fri, 19 Sep 2025 20:51:24 +0000
Date: Sat, 20 Sep 2025 04:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 11/11] um: switch ptrace FP register access to nolibc
Message-ID: <202509200433.l6pWDPhh-lkp@intel.com>
References: <20250919153420.727385-12-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-12-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_135131_155380_9A164C44 
X-CRM114-Status: GOOD (  11.62  )
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
[also build test ERROR on uml/fixes shuah-kselftest/next shuah-kselftest/fixes linus/master v6.17-rc6 next-20250919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-compiler-h-fix-__used-definition/20250919-233959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250919153420.727385-12-benjamin%40sipsolutions.net
patch subject: [PATCH v2 11/11] um: switch ptrace FP register access to nolibc
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20250920/202509200433.l6pWDPhh-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200433.l6pWDPhh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509200433.l6pWDPhh-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> arch/x86/um/os-Linux/registers.c:11:10: fatal error: 'sys/user.h' file not found
      11 | #include <sys/user.h>
         |          ^~~~~~~~~~~~
   1 error generated.
--
>> clang: warning: no such include directory: './arch/um/include/shared' [-Wmissing-include-dirs]


vim +11 arch/x86/um/os-Linux/registers.c

14c8a77e1bbd69 arch/um/os-Linux/sys-i386/registers.c Jeff Dike          2008-06-12 @11  #include <sys/user.h>
38b64aed786d59 arch/x86/um/os-Linux/registers.c      Richard Weinberger 2011-08-18  12  #endif
37185b33240870 arch/x86/um/os-Linux/registers.c      Al Viro            2012-10-08  13  #include <longjmp.h>
37185b33240870 arch/x86/um/os-Linux/registers.c      Al Viro            2012-10-08  14  #include <sysdep/ptrace_user.h>
a78ff1112263fd arch/x86/um/os-Linux/registers.c      Eli Cooper         2016-03-20  15  #include <sys/uio.h>
a78ff1112263fd arch/x86/um/os-Linux/registers.c      Eli Cooper         2016-03-20  16  #include <asm/sigcontext.h>
a78ff1112263fd arch/x86/um/os-Linux/registers.c      Eli Cooper         2016-03-20  17  #include <linux/elf.h>
dbba7f704aa0c3 arch/x86/um/os-Linux/registers.c      Al Viro            2021-09-20  18  #include <registers.h>
3f17fed2149192 arch/x86/um/os-Linux/registers.c      Benjamin Berg      2024-10-23  19  #include <sys/mman.h>
^1da177e4c3f41 arch/um/os-Linux/sys-i386/registers.c Linus Torvalds     2005-04-16  20  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

