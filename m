Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DDCC4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UMByg3cjk4dNIWG+7FR1ywCtH7rpQe+uxSkEqin1HfU=; b=OosFVBag9peMbHYiGaIY+PZhwz
	8QPwWGl24oQJ0Kyib6bHs7U43dLIgYnxbhlejZ1ERW2HmXSFtD4VTRA9FCUGt47tbjooDZzlfAapr
	hcQF1+iHbpsZQCClTbtoYYtauw6dvxQANp5A8rJK0tffBeb0byzhMmvS2oRcI//+/XBJWMMCwTGWo
	09caGV2b+k4vHM6OUCDzFf/IN3nYw3H5hfZ08JlvsznTYehC000gYNm+m9Vo1vs8j1r/+FyWBOwtI
	WzCSDMdOMGqdPvCdzo7achQCknZMbidk9XbmI7LCLPTDvCnjwGeiWtPheVAukXDBBLiCdhLOvw0Nx
	qupCZx8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFk5-0000000HY2U-0oK2;
	Tue, 23 Apr 2024 12:59:25 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFju-0000000HXuy-3IwS
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877149; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=UMByg3cjk4dNIWG+7FR1ywCtH7rpQe+uxSkEqin1HfU=;
	b=doxxG2vo+X6gi6k9MJ7n80TQCyDBQXPqPiXG4kDeYxMO+wtk1YozPDzDyarrtWJAaureLyAjV736AvaKoioSpyrTElSFa9lEmoyCcf4riZ+t7mO1ezWbvytNGvq+cLEXoz6Hlz9aehJfU1XWGa0Zd9JlsWtFywF2GY01Um1Ysi0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjPz_1713877140;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjPz_1713877140)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:06 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/7] um: A follow-up series of -Wmissing-prototypes fixes
Date: Tue, 23 Apr 2024 20:58:51 +0800
Message-Id: <20240423125858.137709-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_055917_634634_5C1E0CB7 
X-CRM114-Status: UNSURE (   6.88  )
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

This is a follow-up series built on top of below series:
https://lore.kernel.org/linux-um/20240306101925.1088870-1-tiwei.btw@antgroup.com/

Changes since v1:
https://lore.kernel.org/linux-um/20240423112457.2409319-1-tiwei.btw@antgroup.com/
- include "internal.h" explicitly (Johannes);
- drop the "extern" (Johannes);

Tiwei Bie (7):
  um: Fix -Wmissing-prototypes warnings for (rt_)sigreturn
  um: Fix the -Wmissing-prototypes warning for __switch_mm
  um: Fix the -Wmissing-prototypes warning for get_thread_reg
  um: Fix the declaration of kasan_map_memory
  um: Add an internal header shared among the user code
  um: Fix -Wmissing-prototypes warnings for __vdso_*
  um: Remove unused do_get_thread_area function

 arch/um/include/asm/kasan.h             |  1 -
 arch/um/include/asm/mmu.h               |  2 --
 arch/um/include/asm/processor-generic.h |  1 -
 arch/um/include/shared/kern_util.h      |  2 ++
 arch/um/include/shared/skas/mm_id.h     |  2 ++
 arch/um/os-Linux/elf_aux.c              |  1 +
 arch/um/os-Linux/internal.h             | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c                 |  3 +--
 arch/um/os-Linux/mem.c                  |  2 ++
 arch/um/os-Linux/skas/mem.c             |  3 +--
 arch/um/os-Linux/skas/process.c         |  1 +
 arch/um/os-Linux/start_up.c             |  3 +--
 arch/x86/um/shared/sysdep/archsetjmp.h  |  7 +++++++
 arch/x86/um/signal.c                    |  5 +++--
 arch/x86/um/tls_32.c                    | 17 -----------------
 arch/x86/um/vdso/um_vdso.c              | 10 ++++++++--
 16 files changed, 49 insertions(+), 31 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

-- 
2.34.1


