Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC8606A333
	for <linux-um@archiver.kernel.org>; Fri,  6 Nov 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WkamhU/M;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kPBo6fGN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iz3HkQ8S5G/MQ2i6xDUU1DsVvSdEnv/maZkfcMkgzs8=; b=WkamhU/M+pe1sjj9Jx6oMORLJD
	2f5TV/FS4izNHIRebMEF25FVTFKtjQMt14gt5ahge9t+DRjajiPKstnRI/A8y/FIJrVMXg9aWPy5o
	9YbOylXI4isxZv6HUNDgDA7F/4LmXuWbCW+KxaX4aFRYnWZuPw5di/3FEurNx8Q8iMuo4AGQALyE8
	vZFJs+6sYRaQpHp9rBkkVBTNsQiyNJOtyfPePM2FQgFeSjqvgVh5AsayVIYTyaqlaq92knJoFBFUU
	8O5ahwcJ2KAQ1vPjr4fws8jHJMKQx9W+N4k0FaUH1rVbA2aiSVsW5LOWf1SjBAQUjVuoO6WGcvXRp
	vQhnsUKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9iP-0000000B5AZ-48dk;
	Fri, 06 Nov 2026 02:30:05 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9iM-0000000B58z-1b3y
	for linux-um@lists.infradead.org;
	Fri, 06 Nov 2026 02:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793932202; x=1825468202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2bnU+hnGrKYfloG+zTnJKn1FMGS0ygPDx+kuky5Yi54=;
  b=kPBo6fGNf2qtrwrFCV0OUitQcL/kiTbnHyfi0l3lXPYTHLugaerxhGn8
   7DBCQhjX09e42a6HkFveJHGs+/CYCp/XLwUMDVev6+v4mc6Rwl6un5Mbn
   J2PcZi3lRarDxQu0dnHejflbYv0+u2EDb0G8dtpXrtoqfE7WISvfgtxk8
   BfRvm6QSMgHlxI5EuhYjKcBD7jJnycJ6koKjssV2mWdtmOS4fMPcZyz9w
   GrmnnGGH7fIoIurwOWCAlTk4CGu+84dRt4Qm4tJ2E3OayjVKvTobkm0vm
   2voxf9HqeeJYre2R1pGdW1ylJIAz/rkdlpwivHCiY3yChueIeVvwsGutb
   g==;
X-CSE-ConnectionGUID: mrhRON6qT0+2BnP55elmTQ==
X-CSE-MsgGUID: NzEd6an8QJ6Pr3W48uVeNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2640268"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2640268"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 18:30:01 -0800
X-CSE-ConnectionGUID: oR5yJ2edRGelgA0+PDF/Ig==
X-CSE-MsgGUID: q0Qh1rswRDGuNJoMg9CT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6999021"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2026 18:29:53 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP9i7-00000000nCd-0Cju;
	Fri, 06 Nov 2026 02:29:47 +0000
Date: Fri, 6 Nov 2026 10:29:01 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 3/7] x86: make CX8 usage unconditional
Message-ID: <202611060951.0UkJ1SVg-lkp@intel.com>
References: <20261105163440.2381661-4-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105163440.2381661-4-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_183002_494763_5A7EB907 
X-CRM114-Status: GOOD (  11.53  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on uml/next linus/master v7.4-rc1 next-20261105]
[cannot apply to uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/x86-remove-AMD-lan-remnants/20261105-173432
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20261105163440.2381661-4-arnd%40kernel.org
patch subject: [PATCH 3/7] x86: make CX8 usage unconditional
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20261106/202611060951.0UkJ1SVg-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060951.0UkJ1SVg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060951.0UkJ1SVg-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/fork.o: in function `arch_atomic64_set':
>> arch/x86/include/asm/atomic64_32.h:108:(.text+0x5fd): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: kernel/ksysfs.o: in function `arch_atomic64_read':
>> arch/x86/include/asm/atomic64_32.h:117:(.text+0x58): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: kernel/sched/fair.o: in function `arch_atomic64_add':
>> arch/x86/include/asm/atomic64_32.h:165:(.text+0x1c52): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: kernel/sched/build_policy.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x2790): undefined reference to `atomic64_add_return_cx8'
>> /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:165:(.text+0x5310): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: kernel/printk/printk.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0xf41): undefined reference to `atomic64_set_cx8'
>> /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:108:(.text+0xf57): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: kernel/printk/printk.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x115f): undefined reference to `atomic64_read_cx8'
>> /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x1188): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: kernel/printk/printk.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x1228): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: kernel/printk/printk.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x242a): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x248d): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x2501): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x2560): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: kernel/printk/printk.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x25c3): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:108:(.text+0x25e4): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: kernel/time/timekeeping.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x32d3): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x339e): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: kernel/futex/core.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0xbf9): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: kernel/futex/core.o: in function `arch_atomic64_inc_return':
>> arch/x86/include/asm/atomic64_32.h:144:(.text+0xc13): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: fs/inode.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x4cd): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: fs/inode.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x1df4): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x1f3c): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/mballoc.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x253a): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: fs/ext4/mballoc.o: in function `arch_atomic64_inc':
   arch/x86/include/asm/atomic64_32.h:181:(.text+0x2ac8): undefined reference to `atomic64_inc_return_cx8'
>> /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x4d1a): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x4ee5): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x4f7b): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x523a): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: fs/ext4/mballoc.o:arch/x86/include/asm/atomic64_32.h:181: more undefined references to `atomic64_inc_return_cx8' follow
   /usr/bin/ld: fs/ext4/mballoc.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x5454): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x546c): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x5499): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x54be): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x54d9): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/mballoc.o:arch/x86/include/asm/atomic64_32.h:117: more undefined references to `atomic64_read_cx8' follow
   /usr/bin/ld: fs/ext4/mballoc.o: in function `arch_atomic64_sub':
>> arch/x86/include/asm/atomic64_32.h:173:(.text+0x651f): undefined reference to `atomic64_sub_return_cx8'
   /usr/bin/ld: fs/ext4/mballoc.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x6526): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: fs/ext4/super.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x850): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: fs/ext4/super.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x201a): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/super.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x87f9): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: fs/ext4/super.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x8a43): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: fs/ext4/sysfs.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x1fc): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: fs/ext4/sysfs.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x4f2): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o: in function `arch_atomic64_inc':
   arch/x86/include/asm/atomic64_32.h:181:(.text+0x3b0): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0xefd): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0xf18): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0xf69): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0xfa4): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o:arch/x86/include/asm/atomic64_32.h:181: more undefined references to `atomic64_inc_return_cx8' follow
   /usr/bin/ld: fs/ext4/fast_commit.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x12dc): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o: in function `arch_atomic64_inc':
   arch/x86/include/asm/atomic64_32.h:181:(.text+0x133c): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x17f7): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x1830): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:181:(.text+0x18fe): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x19db): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o: in function `arch_atomic64_inc':
   arch/x86/include/asm/atomic64_32.h:181:(.text+0x19e9): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x19fb): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x2bf4): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x2c06): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x2c17): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x2cd0): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/fast_commit.o:arch/x86/include/asm/atomic64_32.h:117: more undefined references to `atomic64_read_cx8' follow
   /usr/bin/ld: block/genhd.o: in function `arch_atomic64_inc_return':
   arch/x86/include/asm/atomic64_32.h:144:(.text+0x17d5): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:144:(.text+0x18c5): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: net/core/sock_diag.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x4a5): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: net/core/sock_diag.o: in function `arch_atomic64_dec_return':
>> arch/x86/include/asm/atomic64_32.h:155:(.text+0x4e7): undefined reference to `atomic64_dec_return_cx8'
   /usr/bin/ld: net/core/sock_diag.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x50d): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: lib/kobject_uevent.o: in function `arch_atomic64_inc_return':
   arch/x86/include/asm/atomic64_32.h:144:(.text+0x1d0): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:144:(.text+0x75e): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: fs/ext4/inline.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x1faf): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: io_uring/rsrc.o: in function `arch_atomic64_sub':
   arch/x86/include/asm/atomic64_32.h:173:(.text+0x480): undefined reference to `atomic64_sub_return_cx8'
   /usr/bin/ld: io_uring/rsrc.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x5ac): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: kernel/nstree.o: in function `arch_atomic64_inc_return':
   arch/x86/include/asm/atomic64_32.h:144:(.text+0x962): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x129): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x137): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x145): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x1b7): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: kernel/bpf/core.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x260b): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: kernel/bpf/core.o: in function `arch_atomic64_xchg':
>> arch/x86/include/asm/atomic64_32.h:96:(.text+0x2ba8): undefined reference to `atomic64_xchg_cx8'
   /usr/bin/ld: kernel/bpf/core.o: in function `arch_atomic64_dec':
   arch/x86/include/asm/atomic64_32.h:190:(.text+0x46dd): undefined reference to `atomic64_dec_return_cx8'
   /usr/bin/ld: fs/libfs.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x275): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x293): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x303): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/proc/task_mmu.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x272c): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/balloc.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x95): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/dir.o:arch/x86/include/asm/atomic64_32.h:117: more undefined references to `atomic64_read_cx8' follow
   /usr/bin/ld: fs/ext4/inode.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x5221): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: fs/ext4/ioctl.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x1746): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: fs/ext4/resize.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x1adf): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: fs/ext4/xattr.o: in function `arch_atomic64_read':
>> arch/x86/include/asm/atomic64_32.h:117:(.text+0x58): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: fs/ext4/xattr.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x9eb): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: block/blk-cgroup.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x1f9): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x254): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: block/blk-cgroup.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x2d2): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: block/blk-cgroup.o: in function `arch_atomic64_sub':
   arch/x86/include/asm/atomic64_32.h:173:(.text+0x2e6): undefined reference to `atomic64_sub_return_cx8'
   /usr/bin/ld: block/blk-cgroup.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x10dc): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:117:(.text+0x1a77): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: block/blk-cgroup.o: in function `arch_atomic64_add':
   arch/x86/include/asm/atomic64_32.h:165:(.text+0x1f64): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: block/blk-cgroup-rwstat.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x22): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:108:(.text+0x2a): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:108:(.text+0x32): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:108:(.text+0x3a): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: arch/x86/include/asm/atomic64_32.h:108:(.text+0x42): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: block/blk-cgroup-rwstat.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x1b7): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x254): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x265): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x112b): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `arch_atomic64_read':
   arch/x86/include/asm/atomic64_32.h:117:(.text+0x17e9): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `arch_atomic64_set':
   arch/x86/include/asm/atomic64_32.h:108:(.text+0x17fa): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_read_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_read_cx8+0x0): undefined reference to `atomic64_read_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_set_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_set_cx8+0x0): undefined reference to `atomic64_set_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_xchg_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_xchg_cx8+0x0): undefined reference to `atomic64_xchg_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_add_return_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_add_return_cx8+0x0): undefined reference to `atomic64_add_return_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_sub_return_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_sub_return_cx8+0x0): undefined reference to `atomic64_sub_return_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_inc_return_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_inc_return_cx8+0x0): undefined reference to `atomic64_inc_return_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_dec_return_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_dec_return_cx8+0x0): undefined reference to `atomic64_dec_return_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_dec_if_positive_cx8':
>> .vmlinux.export.c:(___ksymtab+atomic64_dec_if_positive_cx8+0x0): undefined reference to `atomic64_dec_if_positive_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_inc_not_zero_cx8':
   .vmlinux.export.c:(___ksymtab+atomic64_inc_not_zero_cx8+0x0): undefined reference to `atomic64_inc_not_zero_cx8'
   /usr/bin/ld: .vmlinux.export.o: in function `__ksymtab_atomic64_add_unless_cx8':
   .vmlinux.export.c:(___ksymtab+atomic64_add_unless_cx8+0x0): undefined reference to `atomic64_add_unless_cx8'
   collect2: error: ld returned 1 exit status


vim +108 arch/x86/include/asm/atomic64_32.h

276b893049e4cd Uros Bizjak    2024-04-10   90  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26   91  static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
a7e926abc3adfb Luca Barbieri  2010-02-24   92  {
79c53a83d7a31a Mark Rutland   2019-05-22   93  	s64 o;
a7e926abc3adfb Luca Barbieri  2010-02-24   94  	unsigned high = (unsigned)(n >> 32);
a7e926abc3adfb Luca Barbieri  2010-02-24   95  	unsigned low = (unsigned)n;
224788b63a2e42 Josh Poimboeuf 2025-03-02  @96  	alternative_atomic64(xchg,
224788b63a2e42 Josh Poimboeuf 2025-03-02   97  			     "=&A" (o),
224788b63a2e42 Josh Poimboeuf 2025-03-02   98  			     ASM_INPUT("S" (v), "b" (low), "c" (high)),
224788b63a2e42 Josh Poimboeuf 2025-03-02   99  			     "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  100  	return o;
a7e926abc3adfb Luca Barbieri  2010-02-24  101  }
37f8173dd84936 Peter Zijlstra 2020-01-24  102  #define arch_atomic64_xchg arch_atomic64_xchg
1a3b1d89eded68 Brian Gerst    2010-01-07  103  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  104  static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
a7e926abc3adfb Luca Barbieri  2010-02-24  105  {
a7e926abc3adfb Luca Barbieri  2010-02-24  106  	unsigned high = (unsigned)(i >> 32);
a7e926abc3adfb Luca Barbieri  2010-02-24  107  	unsigned low = (unsigned)i;
224788b63a2e42 Josh Poimboeuf 2025-03-02 @108  	alternative_atomic64(set,
224788b63a2e42 Josh Poimboeuf 2025-03-02  109  			     /* no output */,
224788b63a2e42 Josh Poimboeuf 2025-03-02  110  			     ASM_INPUT("S" (v), "b" (low), "c" (high)),
224788b63a2e42 Josh Poimboeuf 2025-03-02  111  			     "eax", "edx", "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  112  }
1a3b1d89eded68 Brian Gerst    2010-01-07  113  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  114  static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
1a3b1d89eded68 Brian Gerst    2010-01-07  115  {
79c53a83d7a31a Mark Rutland   2019-05-22  116  	s64 r;
224788b63a2e42 Josh Poimboeuf 2025-03-02 @117  	alternative_atomic64(read, "=&A" (r), "c" (v), "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  118  	return r;
1a3b1d89eded68 Brian Gerst    2010-01-07  119  }
1a3b1d89eded68 Brian Gerst    2010-01-07  120  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  121  static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  122  {
819165fb34b977 Jan Beulich    2012-01-20  123  	alternative_atomic64(add_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  124  			     ASM_OUTPUT("+A" (i), "+c" (v)),
224788b63a2e42 Josh Poimboeuf 2025-03-02  125  			     /* no input */,
224788b63a2e42 Josh Poimboeuf 2025-03-02  126  			     "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  127  	return i;
a7e926abc3adfb Luca Barbieri  2010-02-24  128  }
37f8173dd84936 Peter Zijlstra 2020-01-24  129  #define arch_atomic64_add_return arch_atomic64_add_return
1a3b1d89eded68 Brian Gerst    2010-01-07  130  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  131  static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  132  {
819165fb34b977 Jan Beulich    2012-01-20  133  	alternative_atomic64(sub_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  134  			     ASM_OUTPUT("+A" (i), "+c" (v)),
224788b63a2e42 Josh Poimboeuf 2025-03-02  135  			     /* no input */,
224788b63a2e42 Josh Poimboeuf 2025-03-02  136  			     "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  137  	return i;
a7e926abc3adfb Luca Barbieri  2010-02-24  138  }
37f8173dd84936 Peter Zijlstra 2020-01-24  139  #define arch_atomic64_sub_return arch_atomic64_sub_return
a7e926abc3adfb Luca Barbieri  2010-02-24  140  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  141  static __always_inline s64 arch_atomic64_inc_return(atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  142  {
79c53a83d7a31a Mark Rutland   2019-05-22  143  	s64 a;
224788b63a2e42 Josh Poimboeuf 2025-03-02 @144  	alternative_atomic64(inc_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  145  			     "=&A" (a),
224788b63a2e42 Josh Poimboeuf 2025-03-02  146  			     "S" (v),
224788b63a2e42 Josh Poimboeuf 2025-03-02  147  			     "memory", "ecx");
a7e926abc3adfb Luca Barbieri  2010-02-24  148  	return a;
a7e926abc3adfb Luca Barbieri  2010-02-24  149  }
9837559d8eb01c Mark Rutland   2018-06-21  150  #define arch_atomic64_inc_return arch_atomic64_inc_return
a7e926abc3adfb Luca Barbieri  2010-02-24  151  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  152  static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  153  {
79c53a83d7a31a Mark Rutland   2019-05-22  154  	s64 a;
224788b63a2e42 Josh Poimboeuf 2025-03-02 @155  	alternative_atomic64(dec_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  156  			     "=&A" (a),
224788b63a2e42 Josh Poimboeuf 2025-03-02  157  			     "S" (v),
224788b63a2e42 Josh Poimboeuf 2025-03-02  158  			     "memory", "ecx");
a7e926abc3adfb Luca Barbieri  2010-02-24  159  	return a;
a7e926abc3adfb Luca Barbieri  2010-02-24  160  }
9837559d8eb01c Mark Rutland   2018-06-21  161  #define arch_atomic64_dec_return arch_atomic64_dec_return
1a3b1d89eded68 Brian Gerst    2010-01-07  162  
dce2a224763ce9 Uros Bizjak    2024-06-05  163  static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  164  {
819165fb34b977 Jan Beulich    2012-01-20 @165  	__alternative_atomic64(add, add_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  166  			       ASM_OUTPUT("+A" (i), "+c" (v)),
224788b63a2e42 Josh Poimboeuf 2025-03-02  167  			       /* no input */,
224788b63a2e42 Josh Poimboeuf 2025-03-02  168  			       "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  169  }
1a3b1d89eded68 Brian Gerst    2010-01-07  170  
dce2a224763ce9 Uros Bizjak    2024-06-05  171  static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  172  {
819165fb34b977 Jan Beulich    2012-01-20 @173  	__alternative_atomic64(sub, sub_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  174  			       ASM_OUTPUT("+A" (i), "+c" (v)),
224788b63a2e42 Josh Poimboeuf 2025-03-02  175  			       /* no input */,
224788b63a2e42 Josh Poimboeuf 2025-03-02  176  			       "memory");
a7e926abc3adfb Luca Barbieri  2010-02-24  177  }
1a3b1d89eded68 Brian Gerst    2010-01-07  178  
7aab7aa4b4bed2 Peter Zijlstra 2023-01-26  179  static __always_inline void arch_atomic64_inc(atomic64_t *v)
a7e926abc3adfb Luca Barbieri  2010-02-24  180  {
224788b63a2e42 Josh Poimboeuf 2025-03-02 @181  	__alternative_atomic64(inc, inc_return,
224788b63a2e42 Josh Poimboeuf 2025-03-02  182  			       /* no output */,
224788b63a2e42 Josh Poimboeuf 2025-03-02  183  			       "S" (v),
224788b63a2e42 Josh Poimboeuf 2025-03-02  184  			       "memory", "eax", "ecx", "edx");
a7e926abc3adfb Luca Barbieri  2010-02-24  185  }
4331f4d5ada568 Randy Dunlap   2018-09-02  186  #define arch_atomic64_inc arch_atomic64_inc
1a3b1d89eded68 Brian Gerst    2010-01-07  187  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

