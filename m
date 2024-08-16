Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF004C52D7D
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NRfAU3ymm8Wxy/p6rbnCYROMpjpqmee7bWrNxlEfXps=; b=fdHdO8ZGCRfWhxBRQgEARMVcxb
	F/9den2H4fk4akFnDdee4kkUqkzDldpC2yQAloG212ZG06/4SwyPNSLvoWQjiW6IrG1o5Z3le7/Q/
	ZbB3nSHRgsS1EC/e9w071ACZ+KVcQM+HEXWMmEfh5UYtxt3HkkhNypRfI0Rrj2wSs5aqleXRxKO4r
	DCawjmQr1xRbyNUh92fXnqx9zaYwPj9OLdoUUDyO9Jhpo2GxHHndasDCVHp497SJ56gRM1ZnaEjP0
	fpB/vR0NqXu+rf4oGEijtySU5baJ/SijfmyYAjxwjpzMBKl1Our5HccbtGDgb8EZZombHTJ68JE8+
	HLEb3hFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBM-0000000BWkP-1Ysh;
	Fri, 16 Aug 2024 01:55:12 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBD-0000000BWbZ-0jpf
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 01:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773298; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NRfAU3ymm8Wxy/p6rbnCYROMpjpqmee7bWrNxlEfXps=;
	b=HXGE8tZ9GHkScThi9IH2Z5NX6xD6I4T5kHjB+OaZ0Ivd1MCNcGWLjnyTRkShAMuVNOVjDWn8dcqES/n81VmCN6ZFdSNwfKP8M3S+vcV7UmiOhWvtkrlTI7OQ8aTdy3QjEHWhGwtPUPq2bW1upbMmjznNid/7cYXrqH/EkQJOPb8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBof7_1723773290)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/6] Some minor cleanups for UML
Date: Fri, 16 Aug 2024 09:54:41 +0800
Message-Id: <20240816015447.320394-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_185503_372041_70321C08 
X-CRM114-Status: UNSURE (   4.15  )
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

Tiwei Bie (6):
  um: Remove unused kpte_clear_flush macro
  um: Remove the redundant newpage check in update_pte_range
  um: Remove unused fields from thread_struct
  um: Remove unused mm_fd field from mm_id
  um: Remove the call to SUBARCH_EXECVE1 macro
  um: Remove declarations of undefined functions

 arch/um/include/asm/pgtable.h           |  7 -------
 arch/um/include/asm/processor-generic.h | 10 +---------
 arch/um/include/shared/skas/mm_id.h     |  1 -
 arch/um/include/shared/skas/skas.h      |  2 --
 arch/um/kernel/exec.c                   |  3 ---
 arch/um/kernel/tlb.c                    | 17 +++++++----------
 6 files changed, 8 insertions(+), 32 deletions(-)

-- 
2.34.1


