Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE4AC531CD
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8j+H3zbWqe20luSpknTFDlNhVMOPGGPrnIiF4G2qhM=; b=tp++9OaFs3ZRrcPuRTiT0wlJJu
	txl6948Dcl/deeL81Q4sFAiNfQZWWR776jwodI7LnDnae+YYcrMhQSUfTl0BmaE5AOIFIJTgk9q8M
	xHio+E4WM11Z271HHXwVaT8zn74bt2MlNlmA+iw2A2Fq5nZNhbZf93Jpp+/GyCZH+/qZHenmBTZd6
	dH8NoLO2XDlQGZZ+ESXJDOsdS0y+FdOS8WeyWmCmbx+DgpzfDFQZhRLp5o0uvi9lFzINL3W8m7ErA
	pgLfOpLmRg3hVL9UuVHZiZAxDbOVOQQb55K4JAf1dC43GluNj4fybW/dVvaDNIjwQtOHbXMaag5Ga
	Pz/CyJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprA-0000000DrpD-34cc;
	Thu, 23 Jul 2026 09:36:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmpr7-0000000Drku-1JON
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z8j+H3zbWqe20luSpknTFDlNhVMOPGGPrnIiF4G2qhM=;
	t=1784799401; x=1786009001; b=wa5HKsiLMDQt1XcCmAR4rHR1hSsrrmXQydafe7DrWxuXrwH
	YRdJ74Uw3k8k5d1r3VWDB66fHXjxymRaMmXz1QW/lCjKyd9V8DYiy00sFXSIn0vACZ+rZJn2hMJ0N
	n2YAWWAAXLTvE7IpIlqSqv4jFEzqyrwnxE2K157my7qom100eNcTL3Ehvp8nSQeDTSctInt8fJql2
	9uf6E+RIAomK2EyTfI8SWm2RQXvEBaL+ePQyyk3Hb80ITjLusrC4nGvjaO8erh9q453R0zRATv6WI
	dkHa5Z3nR+Yj+CVC+24dTXXsygqb0AGJXpC7yxGjLRDVzp24JDrQAB+biC226fnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmpr4-0000000Aeqq-489I;
	Thu, 23 Jul 2026 11:36:39 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>
Subject: [PATCH v2 04/10] um: change machine name for uname output
Date: Thu, 23 Jul 2026 11:35:45 +0200
Message-ID: <20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023641_374646_64980E43 
X-CRM114-Status: UNSURE (   8.01  )
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

From: Hajime Tazaki <thehajime@gmail.com>

This commit tries to display MMU/!MMU mode from the output of uname(2)
so that users can distinguish which mode of UML is running right now.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
[remove / to fix regression with systemd userspace]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: regression fix

---
 arch/um/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 937639edc295..1f85b73d4abb 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -148,6 +148,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 CLEAN_FILES += linux x.i gmon.out
 MRPROPER_FILES += $(HOST_DIR)/include/generated
 
+ifeq ($(CONFIG_MMU),y)
+UTS_MACHINE := "um"
+else
+UTS_MACHINE := "um\(nommu\)"
+endif
+
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
-- 
2.53.0


