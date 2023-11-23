Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6D1C27C40
	for <linux-um@archiver.kernel.org>; Thu, 23 Nov 2023 01:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ugwuVJEQvPhoOM59LwKqZ7CSeMInZP8i5/Kf56BxAEk=; b=dVew9gD+5Q5Vn2
	aRcC2YyLais/9bKeRRMeZZVNoyGgkwWRCjFOJEygniu+L7WVyq7bfrnZ9b2UiPRbNUqIIcENfPYrc
	fCQ2cj8xzLSrcqJwcDlhEUIyZ1F3si8HRKMn0yW1QDDBHfwGCgtohLDyEL3aNvtWJfrqZyNschAZX
	WPrFU/C9iyCYVzvvp6iN7Gf0cTKvmiERH5cK0cvEIDmJB1CE3yKNMaaGNvdrM0+UJ/McVyokNZWbS
	KawbrNc/nliy51lc5+qLegTMtop76CApw/4MaV8PPwac9oImVtItBhZGzTSVKTZnu/IyMn2HERw0x
	oIr5iJpV72mW58Tu+9xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5yw4-003Y29-08;
	Thu, 23 Nov 2023 01:55:20 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5yw0-003Y0Y-2A
	for linux-um@lists.infradead.org;
	Thu, 23 Nov 2023 01:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700704516; x=1732240516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tv124qrk/IgCGAlbtvyJsHJxF3modJvGb4pfuyL/oPc=;
  b=AOpPHicETN9ItR0wNdZiWm7ow8D6pWsYUmVlBbeHuBw4Yb4vL/glGDz4
   kNdu28vTnF2ZbBRMhmMe6TOXhrgrMlzwhPZ2bOoqIEruxTiGwLBS2A0BR
   VKp0EHh63+C+3OxjTuvFD03ddSQMLStvTUSFz4DsPh+aopSCrGHssOOaw
   JEEezSH/p8NkSwRNDZUFKAf/tSiSZXOVWqqTBz6gE96yTd8l93A9l6QPw
   WximIhbvNWAUJwbRAqJ7U5AD+aN5PCoMXNYlsb13ku0Wa1rUpXr3mUnlk
   0LwfnMXt9Fgd6CtIW04Hd4PRF2jhA353q5NC8ouITwm8RTWgmNmq0yQcU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13737187"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13737187"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801909598"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801909598"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2023 17:55:12 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5yvu-00016N-0q;
	Thu, 23 Nov 2023 01:55:10 +0000
Date: Thu, 23 Nov 2023 09:54:38 +0800
From: kernel test robot <lkp@intel.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] um: Use swap() instead of open coding it
Message-ID: <202311230538.6Fd2FqkL-lkp@intel.com>
References: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_175516_721605_29E21174 
X-CRM114-Status: GOOD (  15.40  )
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

Hi Jiapeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/um-Use-swap-instead-of-open-coding-it/20231122-113031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20231122032518.53305-1-jiapeng.chong%40linux.alibaba.com
patch subject: [PATCH] um: Use swap() instead of open coding it
config: um-randconfig-001-20231122 (https://download.01.org/0day-ci/archive/20231123/202311230538.6Fd2FqkL-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230538.6Fd2FqkL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230538.6Fd2FqkL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/um/os-Linux/sigio.c:80:5: error: call to undeclared function 'swap'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                                   swap(current_poll, next_poll);
                                   ^
   arch/um/os-Linux/sigio.c:80:5: note: did you mean 'swab'?
   /usr/include/unistd.h:1168:13: note: 'swab' declared here
   extern void swab (const void *__restrict __from, void *__restrict __to,
               ^
   1 error generated.


vim +/swap +80 arch/um/os-Linux/sigio.c

    50	
    51	static int write_sigio_thread(void *unused)
    52	{
    53		struct pollfds *fds;
    54		struct pollfd *p;
    55		int i, n, respond_fd;
    56		char c;
    57	
    58		os_fix_helper_signals();
    59		fds = &current_poll;
    60		while (1) {
    61			n = poll(fds->poll, fds->used, -1);
    62			if (n < 0) {
    63				if (errno == EINTR)
    64					continue;
    65				printk(UM_KERN_ERR "write_sigio_thread : poll returned "
    66				       "%d, errno = %d\n", n, errno);
    67			}
    68			for (i = 0; i < fds->used; i++) {
    69				p = &fds->poll[i];
    70				if (p->revents == 0)
    71					continue;
    72				if (p->fd == sigio_private[1]) {
    73					CATCH_EINTR(n = read(sigio_private[1], &c,
    74							     sizeof(c)));
    75					if (n != sizeof(c))
    76						printk(UM_KERN_ERR
    77						       "write_sigio_thread : "
    78						       "read on socket failed, "
    79						       "err = %d\n", errno);
  > 80					swap(current_poll, next_poll);
    81					respond_fd = sigio_private[1];
    82				}
    83				else {
    84					respond_fd = write_sigio_fds[1];
    85					fds->used--;
    86					memmove(&fds->poll[i], &fds->poll[i + 1],
    87						(fds->used - i) * sizeof(*fds->poll));
    88				}
    89	
    90				CATCH_EINTR(n = write(respond_fd, &c, sizeof(c)));
    91				if (n != sizeof(c))
    92					printk(UM_KERN_ERR "write_sigio_thread : "
    93					       "write on socket failed, err = %d\n",
    94					       errno);
    95			}
    96		}
    97	
    98		return 0;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
