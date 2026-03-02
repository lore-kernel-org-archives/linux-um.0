Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA87EB3645
	for <linux-um@archiver.kernel.org>; Mon,  2 Mar 2026 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IQNBS7fxKbYZ+CQmWflqpM16Imr7eQur7gH5xF1oSkA=; b=TD05TneVC42T/TQdOGpwrpxl5M
	DKorJI5trFHl6Zp+jAPeZ1C2XqL/OUyv83J8NzJCnJgMbZ/QMoy443mWUevazYtbFXzusnOEyGyWg
	v0hT8+6WNz9UjQdkvRqoq03H1Na2DpcTQdyrou5widLVTPFCLbizErtrv9AbKexlfXQ14Mcc/HRG1
	2o+xYkYrNFvTKGfEN+kKw9yBsZP5Ng2QzWYlHUvv9AyI0nhQgvoul6YaLTpxsqIl6Ifc+YrSH7WGs
	WzvCYsUhJqSe2FX7vi60ztqkl4LIOq/ExOjWCtbjxmrMg1yWnkCDZm8TkA/NbT0rXrO7SLxDkqR8m
	vowoiMpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxD4V-0000000EER5-1w0A;
	Mon, 02 Mar 2026 23:53:07 +0000
Received: from out28-5.mail.aliyun.com ([115.124.28.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxD4R-0000000EEP8-1Z3U
	for linux-um@lists.infradead.org;
	Mon, 02 Mar 2026 23:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1772495574; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IQNBS7fxKbYZ+CQmWflqpM16Imr7eQur7gH5xF1oSkA=;
	b=pAvYSKinM0NS1QIOBB9HZSdQrBNuF2BBZCCgT8CLxnv5QxgsFEVYLMQfiNjkJ+Z+0fDC63ps72HW5/KzA4xLh9pykFrmscTrhU50k97vtLv6BwxoTZMQjQufH8+GH1hGd5uJUBeVqUEZQLUHshzVyPwrG5DxZvUQpvSPZBJ7TCM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.gj968Lj_1772495551 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 07:52:53 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] um: Minor pgtable fixes
Date: Tue,  3 Mar 2026 07:52:22 +0800
Message-Id: <20260302235224.1915380-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_155303_916989_8B9D48B6 
X-CRM114-Status: UNSURE (   4.70  )
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

Tiwei Bie (2):
  um: Fix potential race condition in TLB sync
  um: Fix pte_read() and pte_exec() for kernel mappings

 arch/um/include/asm/pgtable.h | 9 ++++-----
 arch/um/kernel/tlb.c          | 4 ++--
 mm/Kconfig                    | 1 +
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1


