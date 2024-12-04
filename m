Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84505E7716D
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4WeSkORGh9VyYQxtLqyJiwUKkuvkWeHltWerw3aHL9E=; b=fHl5hcPeVcQ/vqbVy4jokHvgNo
	RbZJgTm8EpvpXbBG5IxU6SENTXRNRJlhafGuDumWRqmXbmFHykqvaRm6xhbp7R/3wevTDIAr1QJJO
	v582rCowO+GGmjUkvqlvY2/Ey8HY999fYOIeiryFseuUTofKXvkjIlAuwVqTTn2kU4naa+D1aerkA
	ydiu2gHYjEk9LznSvEYqu+CnJ3Yq5tNI0+dEOaYtpaWeZkB+kZDaC2EXopE+KTcP0XJOzxZU9zgtf
	Gy6rfI1YkdDo22WSI6zikoGLg4/NnxK7DzH1cRDNLLnwvSbF+st1J5SWpr+iVTCD8PhIvB9b5WPRN
	SA/MZ1fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIta3-0000000DSD7-3YkZ;
	Wed, 04 Dec 2024 17:54:31 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIta1-0000000DSC4-09x8
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 17:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733334870; x=1764870870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvAw/9dJQ/6HTECQuZckd+xqGF/wAGSMXvFAiLeBjaQ=;
  b=GuZNv91D5S+hKklSCf2GYQ9rI+ANCGunm0aZ4thNGhfnpv6pGRJqbmMZ
   peHV0KoXOXvLcJC322FTWDOZEmbJ5yfu2k8n+S5qzjRSykLT1HrI5Qv0a
   nBLkIgi7uUzEME4+m0yvR/XTb0rWg/EM2cxIoEWXlIK/pGW7TkvsMwOpT
   oCklBUl/94v24LrGopwNZosvPBj3Cq4JoaNjD51ZoeypihC5bvxbQ8xPA
   SMPNKPpUSx9BRfK7sKxIu0Vruo6FguMIx7g304XAonHsful0v8tVWkyMc
   +S79XEOIZ8wra+DruO7p3yM6HfgcGzl7Ib3akakw3ZtfL/rXMP3ytjq5l
   A==;
X-CSE-ConnectionGUID: u4xusXlLTVazW9M9kBLfUg==
X-CSE-MsgGUID: +S+iQhK5SpSfdplRodiVMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37277991"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="37277991"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 09:54:28 -0800
X-CSE-ConnectionGUID: 4DZLnZG4RcG7Sq1a2zoBTQ==
X-CSE-MsgGUID: yrjWW0SlTSaTjF5hfoRh3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93713234"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2024 09:54:25 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tItZv-0003MP-1N;
	Wed, 04 Dec 2024 17:54:23 +0000
Date: Thu, 5 Dec 2024 01:54:17 +0800
From: kernel test robot <lkp@intel.com>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, thehajime@gmail.com, ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: Re: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by
 seccomp filter
Message-ID: <202412050150.ZqbrNI0T-lkp@intel.com>
References: <f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_095429_117338_F0F9AE82 
X-CRM114-Status: UNSURE (   7.43  )
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

Hi Hajime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bed2cc482600296fe04edbc38005ba2851449c10]

url:    https://github.com/intel-lab-lkp/linux/commits/Hajime-Tazaki/fs-binfmt_elf_efpic-add-architecture-hook-elf_arch_finalize_exec/20241203-163016
base:   bed2cc482600296fe04edbc38005ba2851449c10
patch link:    https://lore.kernel.org/r/f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime%40gmail.com
patch subject: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by seccomp filter
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050150.ZqbrNI0T-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> arch/um/os-Linux/process.c: sys/prctl.h is included more than once.

vim +15 arch/um/os-Linux/process.c

  > 15	#include <sys/prctl.h>
    16	#include <sys/wait.h>
    17	#include <asm/unistd.h>
    18	#include <init.h>
    19	#include <longjmp.h>
    20	#include <as-layout.h>
    21	#include <os.h>
  > 22	#include <sys/prctl.h>
    23	#include <linux/filter.h>
    24	#include <linux/seccomp.h>
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

