Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE509C5321A
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Va1l5amOaE0g8CzLu9bUE4oGrzWkEXpaPMUsaBynTi0=; b=odwO9R6MZccaFqxJF3sAHz+3Ug
	B5S0zbCxr3dOELksJoj5q8NrjjtO3r4bPTEpWy2osfvtF36FwQNWyGPThjGixir8ONwLfzO2hlPkm
	+CxL7UOo4USwJW/6GtWWJbUH1YCWsQ3+Q29fv+OoRBwptM4Rb2Gdwo7Snx1CgnQR8AmlwjrwS79OP
	FFULXmZTaIlF4cWMHG3a/86fTAWiPPs9XNKKHjmu0DbKWCwVVseOY+7Wx1YExusfZg0+CT1OY3WPW
	qOrosPPb2MBsRjOXpeZMCcv6nkPlxp7EEzszDojtgPIrFZosUPNzY9qrtlbtykta/ijQqBQkt5S3b
	R8Q8en6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe4-0000000HGkw-38f4;
	Fri, 24 Jul 2026 21:41:28 +0000
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe0-0000000HGh2-3Tqk
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:27 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 217EFC0000FB;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 217EFC0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929282;
	bh=QbIyHuCTZXlWeF4J0dDRY0wdd72yASGiNYrryz+pe/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFbsERreLH4vaLK/6Wf3eBAZ59eS1Bk3UPqa3P5uvAKAjNEVkLiR+vON2Ne7fqezt
	 yGcsobjQNsttIoMqAh5d85oXKLtK7EwEzAOw94I2kASE0LXN/FmQ/58jtDzVvhEQuD
	 aCRflgvsZuKuxKAQ8/YjYNThvx9U0PJrGxcDRblQ=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E7A4AACE;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 4/9] um: Set parent-death signal for ubd io thread/process
Date: Fri, 24 Jul 2026 14:41:14 -0700
Message-Id: <20260724214119.1066665-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144124_938158_BFDB52E9 
X-CRM114-Status: GOOD (  10.14  )
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

commit 9b5e6c0f5a9199c69af81ac5bedc512ee7dc20b3 upstream

The ubd io thread is not really a traditional thread. Set the
parent-death signal for it to ensure that it will be killed if
the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-3-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/ubd_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 2bfb17373244..66c1a8835e36 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1501,6 +1501,7 @@ int io_thread(void *arg)
 {
 	int n, count, written, res;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 
 	while(1){
-- 
2.34.1


