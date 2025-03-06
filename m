Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2E0C282EC
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H1unbdlYF9MquzEX5A1mQupFrQ4KbqU6nmaxk8XcAQo=; b=njJUnBlmcp/2227SMMniHdxW2x
	m/BKbju+1DOwayHw/pq4FpJi1iCBmjb2680pqNsX2d7GnMzVsQiAaeew+0q184fvi4QtqkMPM4C3D
	2mvzmuq9XS+zsJrjkujUFc+MP8Q+ldc9z9b4Z4JBc6nVfhXvFEB0oDIApXAEfDv+PMwiUt6ow0J3t
	Jcucdcsgt0uYDyFTaxzc7H4DQVWygnwhGZWAg69bhWhuu1GQAHIyr0l1Gt2IrFns5/nRueb2hpQiA
	yJxRsd6V3ImnRnf8X8o/afZQtCsaiCxyEFAeloacz7MdIe1g1D2ijg2PIItyQJmLn+GYtlkSLDLlc
	LPJciA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCpR-0000000BHPq-1uIu;
	Thu, 06 Mar 2025 15:08:05 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCpO-0000000BHNd-0o51
	for linux-um@lists.infradead.org;
	Thu, 06 Mar 2025 15:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1741273675; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=H1unbdlYF9MquzEX5A1mQupFrQ4KbqU6nmaxk8XcAQo=;
	b=BzIkVrTPvOZJCApVswZchIXmPbI0vEMJRjlRG3R0j3jwhJ4VIrFuEmoi+It7pmlp/3y6QdTcKKQn2AK997LQiVal6wRIhKww/3EU/Lw38hR+gLQbP6Me8wZEb3elBe4BrAn3GyYVQRjT2uXLYjPm3LpGVkVFLnrZ43rEm7UNsnM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.blx0wBc_1741273669 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 23:07:54 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/4] um: Make errno multi-thread safe
Date: Thu, 06 Mar 2025 23:07:43 +0800
Message-Id: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_070802_742252_7562D0EF 
X-CRM114-Status: UNSURE (   3.80  )
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

v2:
- Do not define the thread handle type as void *;
- Minor tweaks to commit messages, log and comments;

v1:
https://lore.kernel.org/all/20250221084049.1332318-1-tiwei.btw@antgroup.com/

Tiwei Bie (4):
  um: Add pthread-based helper support
  um: ubd: Switch to the pthread-based helper
  um: Switch to the pthread-based helper in sigio workaround
  um: Prohibit the VM_CLONE flag in run_helper_thread()

 arch/um/drivers/ubd.h       |  6 ++--
 arch/um/drivers/ubd_kern.c  | 25 ++++++--------
 arch/um/drivers/ubd_user.c  | 14 ++++----
 arch/um/include/shared/os.h |  5 +++
 arch/um/os-Linux/helper.c   | 67 +++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/sigio.c    | 44 +++++++++++-------------
 6 files changed, 113 insertions(+), 48 deletions(-)

-- 
2.34.1


