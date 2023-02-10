Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1112C6379F
	for <linux-um@archiver.kernel.org>; Fri, 10 Feb 2023 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sbWGdh21Ml8xq9QQg+IKLGtJcbwiK8Ssgah3a+Kms2k=; b=PQIwMGPb5y9Jr6
	fajKc92wDDU4na7xVzR9EuvsMrMF7xzlaHgG4b9ywl3xXCACniscn36Al32WlnYf/+9UWE4jGeW56
	HE3/ITlUtx6JaY3Dm4lS9k0zXTIjgK2x5cnW44KwW9aXq4XSeA90widqfYrJS33lE6ZnRtX9bL7P6
	GTg7PJL5ZTTy69SsqC7qqoKcF2FIs0l88IHC2q/6VaEoPKB7VarYcpu/YyHpMTfkZLb3tmH+bzHy7
	zvhNaEALyjBqU+KAwRPwYI1FTaGQ1axxaYPWQjoUpkiKKNGdBBO9cEO6lETDdBii5TW694ZDlZ5mm
	Csg08+g6u3KOkf2C8UKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQagl-007aor-4W; Fri, 10 Feb 2023 21:12:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQaaG-007YSv-FA
	for linux-um@lists.infradead.org; Fri, 10 Feb 2023 21:05:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W/YOyxZ+titf5Kb3R6b8/MI7nhw6CQSFf3pMsEHwchc=;
	t=1676063125; x=1677272725; b=QA668Mh5wLA35kmAIyH8P9FxkOsHqWvdUqw5Mj61hyQtDQi
	LTa7prBpNBh4pTdF327kdiQNNG04EORMqkvTbvZw3JB3JTfZRmtOrNDKXTGMPQFxsEtcRLZUU4YUe
	uIIGYmhr3dF+hu7J6v4q6JHZ/pC9UHkMOB7K6MQo5L/BDJBfygGFGo+d1R5mraKVrzIN6e3AR0Fx7
	hNhfVP4PRs/oxpuBWd1He30g3YhRquONkTwFC89qn3k50hHMbV91QmG4FCQ7c6JmA8lAVCvQOKz6v
	AxydVnnLhLpRWf2Qh0ExZIlzdaEle7nfMHuf0j/ctTC2cBnxdN8OFspHSIWiE1nw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pQaa9-008R0g-1Y;
	Fri, 10 Feb 2023 22:05:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/4] um: prevent user code in modules
Date: Fri, 10 Feb 2023 22:05:11 +0100
Message-Id: <20230210220511.7d1f0bac072e.Ie6305500df467812917a2db78c53b8fd3434e7d5@changeid>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
References: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_130528_591054_94453C0F 
X-CRM114-Status: UNSURE (   9.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

By not doing the user code cflags mangling we can simply
break the build for any user code sneaking into modules.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/scripts/Makefile.rules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index a4dfa7d7636e..a8b7d9dab0a6 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -4,8 +4,8 @@
 # ===========================================================================
 
 USER_SINGLE_OBJS := \
-	$(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
-USER_OBJS += $(filter %_user.o,$(obj-y) $(obj-m)  $(USER_SINGLE_OBJS))
+	$(foreach f,$(patsubst %.o,%,$(obj-y)),$($(f)-objs))
+USER_OBJS += $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
