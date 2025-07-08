Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77C0C83F12
	for <linux-um@archiver.kernel.org>; Tue,  8 Jul 2025 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FX5hpB1/gRiUA2KprJB/2EnZqw4glnNIawGMhSMUi48=; b=Sxe49xBOgeNE9ULzs2dMRxnQXn
	RyX28HHm0AdB7p9VPjOJ7frOgVRYeBeozGseXkSX9JKBVmASm0KQK0bNGVXddioA6HWBuAnX3TZ/O
	EC9cdx8e20Ta1ii6oiIYZmUZUN1Ui8o8twKuQaZoweHWyBt0KBCT/LA3JwNQ2xeGaVDoJv7MmAB1c
	GgtKyRXIEHL2pDCJwyr7O8sbe2DDuVOQFCEAT4/9e1RlC3N3s8c0fPHQTRGNVkWqgLhmpfExWHR/R
	sm6j8WzYLYifjEDp+1x81h0amZPrqPEJSmANkTzrbUly4w+C1z5LDoFtIhPGUbWaDza+SDXHvWCYA
	fn6nuGRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4v5-00000004vXc-15D3;
	Tue, 08 Jul 2025 09:47:23 +0000
Received: from out-187.mta1.migadu.com ([95.215.58.187])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4Fo-00000004qMa-18eN
	for linux-um@lists.infradead.org;
	Tue, 08 Jul 2025 09:04:45 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751965470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX5hpB1/gRiUA2KprJB/2EnZqw4glnNIawGMhSMUi48=;
	b=lgIYO5gW2z/gqSUabRHT10qiQ5OEy6iwzaZ4FaJQ1AN+XUfI8GaJPt9InpTIrdJ/S/Vnib
	ZnuM22jtRi6DJMl9+z4vqWG/Bt0hB4I1DDuRgVArkWStMIA+qCIE490q/iq5/VSYbqhug5
	M/PTLEu4AI0FcJpBL0HDTNlTCrhozpY=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 1/4] um: Make unscheduled_userspace_iterations static
Date: Tue,  8 Jul 2025 17:04:00 +0800
Message-Id: <20250708090403.1067440-2-tiwei.bie@linux.dev>
In-Reply-To: <20250708090403.1067440-1-tiwei.bie@linux.dev>
References: <20250708090403.1067440-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_020444_455028_01B9DBC7 
X-CRM114-Status: UNSURE (   7.73  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

It's only used within process.c. Make it static.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/skas/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index e42ffac23e3c..d3dd4fb559cf 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -548,7 +548,7 @@ int start_userspace(struct mm_id *mm_id)
 	return err;
 }
 
-int unscheduled_userspace_iterations;
+static int unscheduled_userspace_iterations;
 extern unsigned long tt_extra_sched_jiffies;
 
 void userspace(struct uml_pt_regs *regs)
-- 
2.34.1


