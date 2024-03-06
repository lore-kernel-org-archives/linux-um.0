Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEB8C54E5F
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XGXxcRXiSFSlEVDs0wpig5xEkbMMXVzGjVpdKv2fDjM=; b=4T/dtfkw5fC2k0ORmDO72WGqHF
	Dz/QjJKlpqhsIKHFTm6l12FgWv4zSnoEOp1BrPVSyOZtiqZO2CzGSHmszOtE3ymHnrdNiA79qsrLU
	M0LL03oJACu+XdytiyAPwGmLMtYmlNlCQsoxwTwnhe53YSMVR+Al42Q9889nUd+BdJsEMf5r9jwJH
	VmPSVldihrkGnE3FMQWM1LqazukjSJ/w0j+B7dnh57OXQrKLD+wqvcLN/dwKgfHFVhpl2fqZfYi50
	ddfedj/8hSAadQT4rDVT6+SWI7leS/5+SQKWxhbjev1V6JwOhr+1qbB68qyKeMPURxE6NZT3K5Ld/
	qYszmR0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNK-0000000HNCe-2tPV;
	Wed, 06 Mar 2024 10:19:50 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNF-0000000HN7r-1Jsq
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 10:19:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-I5_1709720375;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-I5_1709720375)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:40 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 0/9] um: Minor fixes and cleanups
Date: Wed, 06 Mar 2024 18:19:16 +0800
Message-Id: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_021945_514907_E220C08B 
X-CRM114-Status: UNSURE (   8.09  )
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

A series of minor fixes and cleanups for UML.

Most changes in this series are very straightforward. Please consider
picking this series for v6.9.

There are still some remaining -Wmissing-prototypes warnings. I plan to
send a followup RFC series first to fix those warnings.

Feedbacks on this series would be appreciated. Thanks!

Changes since v2:
https://lore.kernel.org/lkml/20240205114708.25235-1-tiwei.btw@antgroup.com/
- Add "um: Move declarations to proper headers";
- Add "um: Fix -Wmissing-prototypes warnings for text_poke*";
- Add "um: Fix -Wmissing-prototypes warnings for __warp_* and foo";
- Make do_set_thread_area() static;
- Add the missing header for calibrate_delay_is_known;

Tiwei Bie (9):
  um: Make local functions and variables static
  um: Fix the declaration of vfree
  um: Remove unused functions
  um: Fix the return type of __switch_to
  um: Add missing headers
  um: Stop tracking host PID in cpu_tasks
  um: Move declarations to proper headers
  um: Fix -Wmissing-prototypes warnings for text_poke*
  um: Fix -Wmissing-prototypes warnings for __warp_* and foo

 arch/um/drivers/pcap_kern.c                |  4 +-
 arch/um/drivers/ubd_user.c                 |  2 +-
 arch/um/include/asm/ptrace-generic.h       |  3 ++
 arch/um/include/shared/as-layout.h         |  1 -
 arch/um/include/shared/kern_util.h         |  1 +
 arch/um/include/shared/um_malloc.h         |  2 +-
 arch/um/kernel/kmsg_dump.c                 |  2 +-
 arch/um/kernel/mem.c                       |  2 +
 arch/um/kernel/physmem.c                   |  3 +-
 arch/um/kernel/process.c                   | 48 +++++-----------------
 arch/um/kernel/ptrace.c                    |  3 --
 arch/um/kernel/reboot.c                    |  1 +
 arch/um/kernel/skas/mmu.c                  |  1 +
 arch/um/kernel/skas/process.c              |  5 +--
 arch/um/kernel/time.c                      |  7 ++--
 arch/um/kernel/tlb.c                       |  7 +---
 arch/um/kernel/um_arch.c                   |  1 +
 arch/um/kernel/um_arch.h                   |  2 +
 arch/um/os-Linux/drivers/ethertap_kern.c   |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c     |  2 +-
 arch/um/os-Linux/main.c                    |  5 +++
 arch/um/os-Linux/signal.c                  |  4 +-
 arch/um/os-Linux/start_up.c                |  1 +
 arch/x86/um/asm/ptrace.h                   |  6 +++
 arch/x86/um/bugs_32.c                      |  1 +
 arch/x86/um/bugs_64.c                      |  1 +
 arch/x86/um/elfcore.c                      |  1 +
 arch/x86/um/fault.c                        |  1 +
 arch/x86/um/os-Linux/mcontext.c            |  1 +
 arch/x86/um/os-Linux/registers.c           |  2 +-
 arch/x86/um/os-Linux/tls.c                 |  1 +
 arch/x86/um/ptrace_32.c                    |  2 -
 arch/x86/um/shared/sysdep/kernel-offsets.h |  3 ++
 arch/x86/um/tls_32.c                       |  2 +-
 arch/x86/um/user-offsets.c                 |  3 ++
 35 files changed, 63 insertions(+), 70 deletions(-)

-- 
2.34.1


