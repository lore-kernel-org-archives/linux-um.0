Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1768F109B491
	for <linux-um@archiver.kernel.org>; Tue, 31 Mar 2026 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaWHSQLJA3A7YGz2UV+++lmOuZ72xwId097H5P6g/Lw=; b=ufXQThDACea6K3loewO8P3dsOk
	5p1Fo8Pt1DOQgpcEI07zmFlkWw5ysq226DmLnqCY9Zdyw/jQrNKk96sSu/UpyJocStWyF1H+XIMGW
	dmyVTkUoNsLHO9rQLu21V73bO7I/OGxcSCkXaIK5gwptVjaqxwZv79ZBaTLRXevwL+ElSEyHfh8s9
	3W3o/S1JEBLvb93kkZlAU6a2xbFaGtWR7tjqfcR2cl//ThvmUmDJRvy9z433h3ZNpvEAqZHwksoq1
	/bLqL/+imREb8+Bf/13CwQWZDmMqX5QELu+ZwutG3OKsH4sXPm0G6OvQ71SQKiBav9qyLEuxcUtYf
	066GsiTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7bC2-0000000DCEx-42d7;
	Tue, 31 Mar 2026 15:39:50 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7bC0-0000000DCEP-2Ksv
	for linux-um@lists.infradead.org;
	Tue, 31 Mar 2026 15:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774971588; x=1806507588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OItpxqU5oSqyN8bGRByxmZipjRxVPgdfQBBwjM5jNZI=;
  b=YaQ4jbpPix2pJDO5+3PNI1R0mLb7M6ez/otpFu5wOHHjNujUAPnaK3OS
   BlNhhZsxcPcwoaNFhpNoDNLwRHqqcGk7mkYfC7EqVG5qU5/q/j6nMgBfk
   bhdC3y9ZpdcM0NPH7StpkNy7ooiRyk/lrzqdzdjY0+ZrHoSWCL7ywUfPN
   0IzzZymN5ynfsGcxff87thOPItZgDWVWC5Di7q0cA7xDtKRVd5Ma/xrMQ
   VLuHjNxFI8XAH2ZM70qeznD2rXaCeDdDZSwB6Tucaa4ri1GXj3jRtho10
   mVmmo+Cd/0hiLX/SE1+nM/rvyDdh6hH6DpnKCgd+HScR56h9xp0E/uMoM
   g==;
X-CSE-ConnectionGUID: w5yB+yeBSdaE3xcTwBPneQ==
X-CSE-MsgGUID: Mgite7mjR+WCjpy+vYfcdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76103880"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76103880"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:39:47 -0700
X-CSE-ConnectionGUID: sB1v2yFzTUOJq8v7416Iqg==
X-CSE-MsgGUID: oFRpaSPpSniEPLV2ERbWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="226264303"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 31 Mar 2026 08:39:45 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7bBu-000000002or-19bA;
	Tue, 31 Mar 2026 15:39:42 +0000
Date: Tue, 31 Mar 2026 23:38:56 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: Re: [PATCH] um: mconsole: validate notify socket path length
Message-ID: <202603312307.FOQx0THR-lkp@intel.com>
References: <20260329030945.32368-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329030945.32368-1-pengpeng@iscas.ac.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_083948_637033_9B1EEACD 
X-CRM114-Status: GOOD (  10.89  )
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

Hi Pengpeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on uml/next]
[also build test ERROR on wireless-next/main wireless/main uml/fixes linus/master v7.0-rc6 next-20260330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/um-mconsole-validate-notify-socket-path-length/20260331-052930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20260329030945.32368-1-pengpeng%40iscas.ac.cn
patch subject: [PATCH] um: mconsole: validate notify socket path length
config: um-defconfig (https://download.01.org/0day-ci/archive/20260331/202603312307.FOQx0THR-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 2cd67b8b69f78e3f95918204320c3075a74ba16c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603312307.FOQx0THR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603312307.FOQx0THR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/um/drivers/mconsole_user.c:203:6: error: call to undeclared function 'snprintf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     203 |         if (snprintf(target.sun_path, sizeof(target.sun_path), "%s", sock_name) >=
         |             ^
   1 error generated.


vim +/snprintf +203 arch/um/drivers/mconsole_user.c

   180	
   181	int mconsole_notify(char *sock_name, int type, const void *data, int len)
   182	{
   183		struct sockaddr_un target;
   184		struct mconsole_notify packet;
   185		int n, err = 0;
   186	
   187		lock_notify();
   188		if (notify_sock < 0) {
   189			notify_sock = socket(PF_UNIX, SOCK_DGRAM, 0);
   190			if (notify_sock < 0) {
   191				err = -errno;
   192				printk(UM_KERN_ERR "mconsole_notify - socket failed, "
   193				       "errno = %d\n", errno);
   194			}
   195		}
   196		unlock_notify();
   197	
   198		if (err)
   199			return err;
   200	
   201		memset(&target, 0, sizeof(target));
   202		target.sun_family = AF_UNIX;
 > 203		if (snprintf(target.sun_path, sizeof(target.sun_path), "%s", sock_name) >=

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

