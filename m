Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60239C3600D
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/hSiE2712rnv6nkqOZF47WE7j8sN9Oxcu8SeU1kf72w=; b=GlfcBaYgIaaod295rQvV6ZagB3
	CuT8DDCl/T2oKe99jpdXB3O+kFMisHmigcUJ8Pu9RcDls6gnG2PpKeltP6TVUtn4zehwspvUU1kJJ
	gJjK/DLKXNs9Ff1+yfrIQ1b3oIfi5uTFCSVmh84p/kj8PI9RiXVhSAx0XkgTWUsO04uhvE76weG0p
	zGpgmaSknol/Co2E+FWBKVFWfXNnaTQ4LRkccLUQ4iiEPpG9Y0id5/9yNVw2HYr5caPQQLHaClRwf
	CvP+fJ28lAvd5+2swFdCgFQiEtKOWXvj6fM/S08LMujMVJ1HZy7Nzeo8jlo6euHlFVZQ3lguHvoTP
	CjS9+yHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKlX-00000007ixi-0Yag;
	Wed, 26 Mar 2025 07:01:31 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKlT-00000007iw1-3VTc
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 07:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742972485; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/hSiE2712rnv6nkqOZF47WE7j8sN9Oxcu8SeU1kf72w=;
	b=eJuSUqgGwoxugMFbiDumFdTTg0ddUY4x0eLjCrRj+gMfKSJ9F3TADlqHctfZld7PbYvk1bTn6hG3DWmidX6BeXIWtXaDiEUK171wPc7lW3zjMMCC7AifIH1/diD0FjESiWQ8wl98KmTC4SAZo4RngyJUIPvZAvptn7CD4tIgEB8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.c3eI03y_1742972481 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 15:01:22 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: xterm: Update options for gnome-terminal
Date: Wed, 26 Mar 2025 15:01:13 +0800
Message-Id: <20250326070113.401857-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250326070113.401857-1-tiwei.btw@antgroup.com>
References: <20250326070113.401857-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_000128_017459_E9429B60 
X-CRM114-Status: UNSURE (   7.05  )
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

The -x option is deprecated and might be removed in a future release
of gnome-terminal. Let's recommend using -- instead.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/xterm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index f607af738eac..d05918e422f9 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -81,7 +81,7 @@ __uml_setup("xterm=", xterm_setup,
 "    '<switch> command arg1 arg2 ...'.\n"
 "    The default values are 'xterm=" CONFIG_XTERM_CHAN_DEFAULT_EMULATOR
      ",-T,-e'.\n"
-"    Values for gnome-terminal are 'xterm=gnome-terminal,-t,-x'.\n\n"
+"    Values for gnome-terminal are 'xterm=gnome-terminal,-t,--'.\n\n"
 );
 
 static int xterm_open(int input, int output, int primary, void *d,
-- 
2.34.1


