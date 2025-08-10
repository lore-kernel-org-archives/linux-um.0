Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B3C87FCF
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OmbZmbhr+0ZI0gOeOhnAFsn9UxEIJewNQ5e1iT8c4o=; b=ksQOoKjQxLiZVqvYoEGJccKawS
	XE4h7PvnPhdq4IcY3KHxyN48TTtOL68pRBbXmXqbFstppBvUYMlzph9F9odexTmMICrkO+xbMRpPK
	hZo+UYU8Cvit5A4l27X7cmbeWoYTivTcZdKduD2kmfoekWOpMsOYyNAmQURg2Ns0Qx0cgs3hoh0m6
	QfEBwMstrIfwo5aJ9cWdY0RRCL1jvVBon+NG0DHxCQYPZC7wvREuI9vYw18gT2zQXq/LmYGZ5mezO
	oDqtCgZgRjs41zVc8J8cs1azSRJ23Ckfd/rRFPm9giz+zFl8YmAElNvn5X5CvbEHlHHKhd+LGVro+
	nKfdDhPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul2gr-00000005VF2-35lb;
	Sun, 10 Aug 2025 09:50:09 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul2go-00000005VEe-1xge
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 09:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754819407; x=1786355407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5iYfEFmgkv1YdH2jyiFWAX3ClrOAVHmKPAAv0Mx9lg=;
  b=Q5HGTVMkC06kOaclh2zqNfQpziqCYpxcSJqVbBQpyFpU55THKO7vp9Wi
   PV5zJrGbxIgjSgwp0ApHBTloDV6H9uCV1BVpLhut+JSCGGpoWVfzDelZY
   2FRg0b2sylhXqh2BNJYMgAf4qddt2UdNpe490o7ivg6aUiiXy4i2Allg7
   SeD70DR+CWSD0SminnG59Bm+090QVKjb83ph/6/9Q3RpnniXH56H30zHB
   RhbYBFA2JMwI8Kjtwby4vg8NEexAZsKc8JfnjOppMZaqTkXUWN2wggR7z
   xIuVxuRAjEeKTDIHf34cnmFJm/qfzAp9XafLJIdz7i2NW+Fg0GC0I8XdR
   w==;
X-CSE-ConnectionGUID: OoOAdtSkRamklZ/k3H1+7A==
X-CSE-MsgGUID: HQy1BiA4S4O7epcVAAsHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11516"; a="74549302"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="74549302"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 02:50:03 -0700
X-CSE-ConnectionGUID: WpdJDaenSfWkgqXhx9TUEQ==
X-CSE-MsgGUID: gtmWuhJYSYahXYGG2Rz1bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165985762"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 10 Aug 2025 02:50:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ul2gc-0005FM-0w;
	Sun, 10 Aug 2025 09:49:54 +0000
Date: Sun, 10 Aug 2025 17:49:25 +0800
From: kernel test robot <lkp@intel.com>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin@sipsolutions.net,
	arnd@arndb.de, tiwei.btw@antgroup.com, tiwei.bie@linux.dev
Subject: Re: [PATCH v2 06/10] um: Define timers on a per-CPU basis
Message-ID: <202508101712.K4PzKDp3-lkp@intel.com>
References: <20250810055136.897712-7-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810055136.897712-7-tiwei.bie@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_025006_555835_5D5EA2D3 
X-CRM114-Status: GOOD (  10.56  )
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

Hi Tiwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on uml/next]
[also build test WARNING on linus/master next-20250808]
[cannot apply to uml/fixes arnd-asm-generic/master v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiwei-Bie/um-Stop-tracking-virtual-CPUs-via-mm_cpumask/20250810-135542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250810055136.897712-7-tiwei.bie%40linux.dev
patch subject: [PATCH v2 06/10] um: Define timers on a per-CPU basis
config: um-randconfig-001-20250810 (https://download.01.org/0day-ci/archive/20250810/202508101712.K4PzKDp3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250810/202508101712.K4PzKDp3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508101712.K4PzKDp3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/um/os-Linux/time.c:90 function parameter 'cpu' not described in 'os_timer_disable'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

