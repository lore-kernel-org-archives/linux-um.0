Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F9606A33A
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pHGvYuLO;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=JZsVxCR8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kgM+JZmk+JTJXu5eEd3u9YLeOP8WsDALXRGb3BApf3U=; b=pHGvYuLOrSbioq
	/LT+e9qAqyAYDpVqierEssrtqDVZlFx549NXvjbo9Ek0e5maa0+QYkpcBRZLuOUAegyRuDCl+sww1
	MLoovq98yopIAWkWr1nAvCDug5f7btPs6wxaPcHcaXSNF+Dp0diuKqTDxYqVfgUoQHtn3l3ujeD2c
	qrDNr1snWKpswS1eAjFByZgk6ZNbDFYSczR9DcW35B+JP49hAsR8xMgFcZFIWae3u+gIXirHW65t3
	8DWc7VzDp4F6c43+aAEaR/fjNLQm0OcdzApts8eKdpNCsGaW4tJAnuWVbkfmf+fRlOHnWNEZt9SDd
	9h75s8OCamYBNarRWS/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27F-0000000C1Lx-1I9b;
	Thu, 19 Nov 2026 13:23:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27B-0000000C1J5-46XG
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kgM+JZmk+JTJXu5eEd3u9YLeOP8WsDALXRGb3BApf3U=;
	t=1795094629; x=1796304229; b=JZsVxCR8pHHLR+/P2MYqghivzMGMOG9TDQFVwPwgurim4jX
	ybFD/o0ummYL95nKVsRF7wTtwRrPJ4tH+U2rzFMf2jsZ42iL6Xmk79I9kM/oPmJVm+q36qazjUm/p
	yfIEC0ijjcbXOyT/Qmj5m7j619+uVu5gV4X+huOsX6KbWkp6GpMDnKLLBoC/0jLqsXszgXbh98YSz
	GCMe77NUSdChjZxAyRJzhhdqNWzNwUwe8WzNhaaBCkA56ojNhojt3SUPM741zVo2vAw2BoDTDP1OL
	cIRece8tr7RP0lxD7W9hR4pad8Dfi5aWpZTdJx2YP7m8299g2ZSI8U4V/oWrPDgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU278-00000004LIl-1pUy;
	Thu, 19 Nov 2026 14:23:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 3/3] random: disable interrupt random source
Date: Thu, 19 Nov 2026 14:19:14 +0100
Message-ID: <20261119142340.0280b299abb7.Ied0c2820d0610563d2ccd3bfeece63afc49d0fd8@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132340.225696-5-johannes@sipsolutions.net>
References: <20261119132340.225696-5-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052350_150959_D8FE0BFB 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

Interrupts in our UML environment are signals, which can be delivered at
somewhat random times depending on host scheduling. Disable these as a
source to make the random reproducible between runs.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/char/random.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 64d0cfc99ac4..be9f744f3e72 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1104,6 +1104,9 @@ void add_interrupt_randomness(int irq)
 	struct pt_regs *regs = get_irq_regs();
 	unsigned int new_count;
 
+	/* UML seems to not always get the signals entirely at the same time */
+	return;
+
 	fast_mix(fast_pool->pool, entropy,
 		 (regs ? instruction_pointer(regs) : _RET_IP_) ^ swab(irq));
 	new_count = ++fast_pool->count;
-- 
2.56.1


