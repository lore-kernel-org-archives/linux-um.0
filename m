Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3C0C27C77
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d89DrUEs1kIDLyhtwQqJqL6IksFgShhaBWcU6xLTz3Q=; b=aGBm2VGu5LiDsa1bJjDlFcIGde
	KDBsbCO69BGJgre2zvuWqAZOjABeUp89cAY8UxEQVFU0ghIAI1GIGmfcPnH0Q4vYx9/NSz3I2VUfc
	Tocpyaatldq8zADsieKI7AdTLteWaGO00mvw7mtE9HZ/lI3a2GQzrVUuEIboltdJoose8XmiuqEdO
	mIIoM7/nVPISDPz16bl6rwcacnwj3iZvmu/gtl4GbBMI3QZWdAAT/0w3wS64Boo+ohsTIW82qP7H9
	hKBOAQof2bLsPxIHY+40Etcu4SUeMz0FO7Mbw9WMLm3nv/CfJFr0xZ2ZWC6qwXYOOs+GaJXT3QXa/
	iVGHNwbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2d-0000000DPuH-2vz1;
	Wed, 12 Jun 2024 16:41:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHR2Y-0000000DPs8-3v4v
	for linux-um@lists.infradead.org;
	Wed, 12 Jun 2024 16:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d89DrUEs1kIDLyhtwQqJqL6IksFgShhaBWcU6xLTz3Q=;
	t=1718210498; x=1719420098; b=pGr7OdQFmFVaXIfi0TYfr0qDs6V3RLEeX46xAoof/WLlM06
	LBNLZkdUT39EDpnlNgqZW4MONGXzhilWSaPZNhaVqrZW3YSlpDaiPJ9m/f9Exs0B6fC5uQsjkdTMf
	OUpfznTQ0xrHBlr8G6z7QLqFu3CSjn4H1iaF/ricmFXbEgY/GXphgWZCH2Pt+1JCt7Gf4Jbgr8W+f
	OpGgQrBY4COFqY4mI6tLDInc2DpWSN+DInQRfewiFt5vgiYYQjd3msW6lV4+N5GpDUSUBWwTQT6+Y
	ytQK9STBZueatPrnV7fVQcJ7bF+yKXvfOLJqNSPngt2N2ukd/+BvafJAwGPd/ISQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sHR2V-0000000AUQy-2rvN;
	Wed, 12 Jun 2024 18:41:36 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 1/5] um: Fix stub_start address calculation
Date: Wed, 12 Jun 2024 18:41:04 +0200
Message-ID: <20240612164108.1742106-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612164108.1742106-1-benjamin@sipsolutions.net>
References: <20240612164108.1742106-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_094138_984158_9F5AC50F 
X-CRM114-Status: UNSURE (   9.51  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The calculation was wrong as it only subtracted one and then rounded
down for alignment. However, this is incorrect if host_task_size is not
already aligned.

This probably worked fine because on 64 bit the host_task_size is bigger
than returned by os_get_top_address.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/um_arch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e95f805e5004..0d8b1a73cd5b 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -331,7 +331,8 @@ int __init linux_main(int argc, char **argv)
 	/* reserve a few pages for the stubs (taking care of data alignment) */
 	/* align the data portion */
 	BUILD_BUG_ON(!is_power_of_2(STUB_DATA_PAGES));
-	stub_start = (host_task_size - 1) & ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
+	stub_start = (host_task_size - STUB_DATA_PAGES * PAGE_SIZE) &
+		     ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
 	/* another page for the code portion */
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
-- 
2.45.1


