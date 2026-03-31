Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BB1FF60F0
	for <linux-um@archiver.kernel.org>; Tue, 31 Mar 2026 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6KdLgCGNoGiJCHVKn3CEmUMRZFdMC7KYYSnelOoBx0=; b=4w6+MtLx7BZzka9V7sZs3O8hv/
	gVYA5Q9PSTmDNczQVGutu7NE9W8CJ1ihRAbiAUjfeG7qLZX4V2BrC0olUVtpA8JX6uPyOP0qwnL2r
	ujd2zz/Bzsn6FeCBjS15tppObpue5xy+9ArL9b63k0VTiVm4ixai0XJERrE6kyQcIDqIrZ+idbxmp
	r7OcxooAxKBScuKjT5ycgjw2R+sSMIrl6B8ZYx4hocS/VZCgyj6pMv9NmMxoM9rgJduRRiFZor6vc
	aZVS75R91Bv+aRdcib9Phva6RxG8l1pj5uDanadyll9nI5DBv4EsAX1VXBoT0M6AdgVwFwOwu0Sbd
	Ka1lN7zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7apm-0000000D9xR-082L;
	Tue, 31 Mar 2026 15:16:50 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7apj-0000000D9ws-1Ssa
	for linux-um@lists.infradead.org;
	Tue, 31 Mar 2026 15:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774970207; x=1806506207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsW1N9WT2ID9oJMzACJzBddesMiBDzlZf4pdPRbOW2U=;
  b=J3QQNbvCEGQr9gVc/iD81CqP4MxVGT1YzDMnWJDe9XjGYaPICFMsdkNx
   ZwwSERowzAgapTHvGSOtaD9Yx2dzA39BdGUewldPkEeNPJhrycIxAlZ2z
   7G16a+j4D7kOSlzqstHIHLOUPuMK/puWSpAHVAeNm5zeHLp0OTW+juDn0
   fOO4ialInyDTTnAqESkP75qPMvSSp032mQn8WIoUqEv46TpzJZSgM+Ad1
   Yq9A+KJQbRY2Kzmc25CLNNkzFoDt2ODLim5CGN9+6YGpR4nXh/DxmeLH5
   MN+cqREKRDS7NBC3GSZPKgZJ+m+HbsfJabiBOQfrF2J19S4pFytlyADmO
   A==;
X-CSE-ConnectionGUID: u1NR+tNnTjKQR5Ji7HrDkg==
X-CSE-MsgGUID: rJqJS7mNSSSV+rR1DRfFOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="63539394"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="63539394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:16:46 -0700
X-CSE-ConnectionGUID: Y+3x6NRoQReOsR9Ar1v3FQ==
X-CSE-MsgGUID: 0O1dDmciTx+c3uIU00ykYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223091922"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 31 Mar 2026 08:16:44 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7apd-000000002nn-2EqM;
	Tue, 31 Mar 2026 15:16:41 +0000
Date: Tue, 31 Mar 2026 23:16:23 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] um: mconsole: validate notify socket path length
Message-ID: <202603312336.UUqJ8pFo-lkp@intel.com>
References: <20260329030945.32368-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329030945.32368-1-pengpeng@iscas.ac.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_081647_437850_5A4CA439 
X-CRM114-Status: GOOD (  11.14  )
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20260331/202603312336.UUqJ8pFo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603312336.UUqJ8pFo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603312336.UUqJ8pFo-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/um/drivers/mconsole_user.c: In function 'mconsole_notify':
>> arch/um/drivers/mconsole_user.c:203:13: error: implicit declaration of function 'snprintf' [-Wimplicit-function-declaration]
     203 |         if (snprintf(target.sun_path, sizeof(target.sun_path), "%s", sock_name) >=
         |             ^~~~~~~~
   arch/um/drivers/mconsole_user.c:14:1: note: 'snprintf' is defined in header '<stdio.h>'; this is probably fixable by adding '#include <stdio.h>'
      13 | #include "mconsole.h"
     +++ |+#include <stdio.h>
      14 | 


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

