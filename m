Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CABC47DDB
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3IZ1picJ8kSIWKUpDdTkrsS1CXDAKSl/yzg+DV4FTBY=; b=qqBWErgupcz8ov16J7qDo/Kk7m
	oE1YiDxVINCsffUZWVVE4t1gWBilZzWjYLGBac2qqsdWdKC4vWRyAIgq+FgvEx1a5PfasquFQQUak
	pi/nUIGLtP+j3W2X+1cFQOF1oc8+RfOaFWrJNQufNFmyK5gVhf0qoH11QTX4RACDfqPz7Q4jOvBfs
	XCGiry46XF3GAYc0q/oEpX/PtlWzQqxRzK90yDl7pW5/h0dv7XewbVeNBjt0arZ7yfbx9CGUhAOLd
	szhZ3jLxMwGinQkXgSRjzd+oiNTHW18kM9VizHWfP/86Ui0xWSTX3qw+8pLgwXXy8bhIQVA882ei0
	nw556eXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZY-00G3nL-2S;
	Tue, 23 Jan 2024 11:04:04 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZU-00G3jP-0D
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 11:04:03 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKThV_1706007828;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKThV_1706007828)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/5] um: Minor fixes and cleanups
Date: Tue, 23 Jan 2024 19:03:42 +0800
Message-Id: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_030400_254943_1A3C4405 
X-CRM114-Status: UNSURE (   5.42  )
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

Tiwei Bie (5):
  um: Make local functions and variables static
  um: Fix the declaration of vfree
  um: Remove unused functions
  um: Fix the return type of __switch_to
  um: Add missing headers

 arch/um/drivers/pcap_kern.c              |  4 +--
 arch/um/drivers/ubd_user.c               |  2 +-
 arch/um/include/shared/um_malloc.h       |  2 +-
 arch/um/kernel/kmsg_dump.c               |  2 +-
 arch/um/kernel/mem.c                     |  2 ++
 arch/um/kernel/process.c                 | 34 ++++++------------------
 arch/um/kernel/reboot.c                  |  1 +
 arch/um/kernel/skas/mmu.c                |  1 +
 arch/um/kernel/skas/process.c            |  1 +
 arch/um/kernel/time.c                    |  6 ++---
 arch/um/kernel/tlb.c                     |  7 +----
 arch/um/os-Linux/drivers/ethertap_kern.c |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   |  2 +-
 arch/um/os-Linux/signal.c                |  4 +--
 arch/x86/um/bugs_32.c                    |  1 +
 arch/x86/um/bugs_64.c                    |  1 +
 arch/x86/um/fault.c                      |  1 +
 arch/x86/um/os-Linux/mcontext.c          |  1 +
 arch/x86/um/os-Linux/registers.c         |  2 +-
 19 files changed, 31 insertions(+), 45 deletions(-)

-- 
2.34.1


