Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC145C77B6F
	for <linux-um@archiver.kernel.org>; Tue, 11 Apr 2023 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7FnE54BeUM8v9nfhJLWgrPWH83wj4N4v0ZoHs+saFk=; b=RuVnsWeSfAlp8y
	Ux97RXgGnFbvbyKWFvvMO0UGuYBPVRkhRf2KrSoP34QyDolQSgWgwY9euKNy5fptZVl7GgJMfpRFr
	8DhqacqSwPR/93lN51NsATClMxK9Fy4zNUCQJ9XELUYQMfxXiPLJPjF7lE6BbKCb1wAOCzVliOQ3Q
	kRIbqAyPjTxz/6EHtS37a2HyR9sUJrCcEvYM3sqorxOtVZq3o6uaWHOrM2lx7oXvcFds1zAfPRRez
	b3BJJ1HTZzOGkEgmWaCTeVCh7/XmaOafMGOw2hLFhNmHT8hYRde0fkIb9jIT0/qlSVgvoGI/qv++p
	OkV6bsIpnmZ1htcFlpJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmHN5-000eVi-2D;
	Tue, 11 Apr 2023 17:01:31 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmHN2-000eU7-1v
	for linux-um@lists.infradead.org;
	Tue, 11 Apr 2023 17:01:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681232488; x=1712768488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=djm8bQ+Qt9WvMFf87Ox1tbM+gNLQTqi3MwetRSRW8Fk=;
  b=Bd+vxTuV4f0yuVtmlsGS/97gxrTk9wrT9Ah7QYUA/EI6tX+8eYgRTmXg
   hS7ktYF4gYpJSb/S4RPim3ktimsVz4YtfCHyEOpVSwa1Hwd8X2u3rljzX
   ZvY1jKDQfswkgJ52GgaevevQ8zDnkqdNiUTqklANaIU2VurNAaprzFCbv
   7awhV30XAaYyH8vf5r1xcGvRsTj3gog/Ml+QtuTU/DDKKCxkGMbcQV8Y/
   bAi+Qbz/MIaJ6kpoYhzECqNYsGreyWqEdBXpSmPlRPY8GJ12jrlREG5SF
   J35swfxgmCyvtEELPYs7oZPp2MocXKN2jwwB9KT2XXMNztzgGsy3sSfUd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323305930"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323305930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="638898583"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638898583"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2023 10:01:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pmHMt-000WVv-0s;
	Tue, 11 Apr 2023 17:01:19 +0000
Date: Wed, 12 Apr 2023 01:01:16 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Message-ID: <202304120048.v4uqUq9Q-lkp@intel.com>
References: <20230410011325.26850-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230410011325.26850-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_100128_652437_84A33069 
X-CRM114-Status: GOOD (  13.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Randy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on uml/next]
[also build test WARNING on uml/fixes wireless-next/main wireless/main linus/master v6.3-rc6 next-20230411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randy-Dunlap/UML-pata_cs5536-fix-build-for-X86_32-UML-with-TRACEPOINTS/20230410-091733
base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20230410011325.26850-1-rdunlap%40infradead.org
patch subject: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230412/202304120048.v4uqUq9Q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2782ce24954318f1698ec910691250f4d287d817
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Randy-Dunlap/UML-pata_cs5536-fix-build-for-X86_32-UML-with-TRACEPOINTS/20230410-091733
        git checkout 2782ce24954318f1698ec910691250f4d287d817
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120048.v4uqUq9Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/um/../lib/msr.c:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Read an MSR with error handling
   arch/x86/um/../lib/msr.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Write an MSR with error handling
   arch/x86/um/../lib/msr.c:91: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set @bit in a MSR @msr.
   arch/x86/um/../lib/msr.c:104: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Clear @bit in a MSR @msr.


vim +30 arch/x86/um/../lib/msr.c

22085a66c2fab6 Borislav Petkov 2014-03-09  28  
22085a66c2fab6 Borislav Petkov 2014-03-09  29  /**
22085a66c2fab6 Borislav Petkov 2014-03-09 @30   * Read an MSR with error handling
22085a66c2fab6 Borislav Petkov 2014-03-09  31   *
22085a66c2fab6 Borislav Petkov 2014-03-09  32   * @msr: MSR to read
22085a66c2fab6 Borislav Petkov 2014-03-09  33   * @m: value to read into
22085a66c2fab6 Borislav Petkov 2014-03-09  34   *
22085a66c2fab6 Borislav Petkov 2014-03-09  35   * It returns read data only on success, otherwise it doesn't change the output
22085a66c2fab6 Borislav Petkov 2014-03-09  36   * argument @m.
22085a66c2fab6 Borislav Petkov 2014-03-09  37   *
22085a66c2fab6 Borislav Petkov 2014-03-09  38   */
3e7bbe15ed84e3 Zhao Xuehui     2021-04-08  39  static int msr_read(u32 msr, struct msr *m)
22085a66c2fab6 Borislav Petkov 2014-03-09  40  {
22085a66c2fab6 Borislav Petkov 2014-03-09  41  	int err;
22085a66c2fab6 Borislav Petkov 2014-03-09  42  	u64 val;
22085a66c2fab6 Borislav Petkov 2014-03-09  43  
22085a66c2fab6 Borislav Petkov 2014-03-09  44  	err = rdmsrl_safe(msr, &val);
22085a66c2fab6 Borislav Petkov 2014-03-09  45  	if (!err)
22085a66c2fab6 Borislav Petkov 2014-03-09  46  		m->q = val;
22085a66c2fab6 Borislav Petkov 2014-03-09  47  
22085a66c2fab6 Borislav Petkov 2014-03-09  48  	return err;
22085a66c2fab6 Borislav Petkov 2014-03-09  49  }
22085a66c2fab6 Borislav Petkov 2014-03-09  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
