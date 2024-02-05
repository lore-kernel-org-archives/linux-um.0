Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22961C48295
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Iwp97iSVLEtoHBqNC4xWeOJxQYX2G7rrOUPY5/Qy+uQ=; b=f9O7hs/GphfjbypzDrLjwkczl0
	GJWY2H54u3EsEdTzzNhM4UUHeD2cTLytOKMhULJksK1XAEZJWPQFgf9OEGPq5ylEKpsR78+Qrrebm
	sBym5pR3avmLwiADAJIDjuGKY8gfdBMPzlTGs5bmxo4rGtA/Vz8Vut5hUgVn6mEkhY+A2GIcsPtS5
	H5I0nGpTsXRh7A8KhAxsCoDqoTttNZlBaYdL+4OOfzi8lkFCBUJujV+b5dXN0lKiH0bNRpvfNZhAA
	sINfUibUsjC+k+T5m5vIbCEIbNR3c5JR4gZ6ArtyzGmsC42lPGlw/ZJAfywtjNmbS3Lz9ETD1d3lL
	omBlZEiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxRo-000000032tx-34Yy;
	Mon, 05 Feb 2024 11:47:36 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxRh-000000032pU-2mmN
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 11:47:33 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WNt.HlX_1707133633;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WNt.HlX_1707133633)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 19:47:17 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/6] um: Minor fixes and cleanups
Date: Mon, 05 Feb 2024 19:47:02 +0800
Message-Id: <20240205114708.25235-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_034729_938121_DD70DC2D 
X-CRM114-Status: UNSURE (   6.44  )
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

Changes since v1:
https://lore.kernel.org/lkml/20240123110347.1274217-1-tiwei.btw@antgroup.com/
- Add "um: Stop tracking host PID in cpu_tasks";
- Add missing headers for i386;

Tiwei Bie (6):
  um: Make local functions and variables static
  um: Fix the declaration of vfree
  um: Remove unused functions
  um: Fix the return type of __switch_to
  um: Add missing headers
  um: Stop tracking host PID in cpu_tasks

 arch/um/drivers/pcap_kern.c              |  4 +--
 arch/um/drivers/ubd_user.c               |  2 +-
 arch/um/include/shared/as-layout.h       |  1 -
 arch/um/include/shared/um_malloc.h       |  2 +-
 arch/um/kernel/kmsg_dump.c               |  2 +-
 arch/um/kernel/mem.c                     |  2 ++
 arch/um/kernel/process.c                 | 46 ++++++------------------
 arch/um/kernel/reboot.c                  |  1 +
 arch/um/kernel/skas/mmu.c                |  1 +
 arch/um/kernel/skas/process.c            |  5 +--
 arch/um/kernel/time.c                    |  6 ++--
 arch/um/kernel/tlb.c                     |  7 +---
 arch/um/os-Linux/drivers/ethertap_kern.c |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   |  2 +-
 arch/um/os-Linux/signal.c                |  4 +--
 arch/x86/um/bugs_32.c                    |  1 +
 arch/x86/um/bugs_64.c                    |  1 +
 arch/x86/um/elfcore.c                    |  1 +
 arch/x86/um/fault.c                      |  1 +
 arch/x86/um/os-Linux/mcontext.c          |  1 +
 arch/x86/um/os-Linux/registers.c         |  2 +-
 arch/x86/um/os-Linux/tls.c               |  1 +
 22 files changed, 35 insertions(+), 60 deletions(-)

-- 
2.34.1


