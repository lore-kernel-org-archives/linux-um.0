Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBFFC87FDB
	for <linux-um@archiver.kernel.org>; Mon,  4 Aug 2025 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W2j21EdQ9+BzhX5K3jWbsgABY3uftB7nrDoPZVb6R/s=; b=XA9sDtsHYSvOtfB9wkVATSmEDA
	wPk1VJvQwUMjM4xPiK4MpCR3uoJLrlh5jyXoQiWN2RNyyaBP3/9eKo/XTlNe2d1vvXMycdf3G+NDH
	cuTIjJ2HhV0lf6wHp0e6Hn8tGe/Qs4NifY6JCXgXluP35XUibO1/w10dPGSQMj+VqDumPsg4TFt6i
	5GGfKFlBf5zrClr7D41GclaTPFI8yPz8F7ni2jlmyatxahkhAQh+NbStEiDHRxOdwl3DdObrkkTLx
	ZgBVfcW/8Z2ucXHyacmTBCMBMpxdwbNKKykcWq4GTLadQ1776L0Y1IEFgLCfM9Ks8A/Gov4fkAow3
	aaX5y/9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiqTQ-00000009vwl-0z8J;
	Mon, 04 Aug 2025 08:23:12 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiq6u-00000009sZ9-3JtI
	for linux-um@lists.infradead.org;
	Mon, 04 Aug 2025 07:59:57 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-31f314fe0aaso3202306a91.0
        for <linux-um@lists.infradead.org>; Mon, 04 Aug 2025 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754294396; x=1754899196; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2j21EdQ9+BzhX5K3jWbsgABY3uftB7nrDoPZVb6R/s=;
        b=Uy9cAC2atQKoSoZeqZaFxmVOaWJaZ9OAWsuAme+wCBadm+CNkupjNqYD+a6MzfUPNu
         QgJd3WkBNChgitiKQ0lT+xwlZiG1FQY53NztknMFdz/cf90sKOyo97ZjZ/deUpU3OHLW
         opfrBtZfgJuZm3Db6zA9wEJFL7f/a7G54GfZ69+Ng3iRywNutSxEt9GL514Y6B4bAbho
         IVLNpUvjsWrDpM7Tinup1ZxdX5/4iVc4qRjiWNhI5DfG7BsB6BVHfLEiJzEaQakJF7bj
         NBZNS51fD9ggiu8CkNhzttUbh28WSf73HH6xZb6hXUma0AwWTO3TDhU0PQvFb2kptC5S
         cK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754294396; x=1754899196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2j21EdQ9+BzhX5K3jWbsgABY3uftB7nrDoPZVb6R/s=;
        b=LHDDB+ZZ0qJut5X9dWLLImDWraGZkhRefneK3Tdwv/VQ08RqSnoU++2h7NyT0KYDXb
         CHRbSNmCOEJfpvezKKNGeZ5Ai3zVvug8hTLdtN3uQN9pUv36U6IkiHeAkGoC/KWI64xj
         o1r2osSYXNQY8MJ1vYuOg+wCsJoos7X7qd+y/LbBh+FYB/Ht1Rk51AKX/BVBCckPphtB
         WSDcLzf7ee3gH3/D2rSerYSBiFumF3FJsHlhaaR2BMJ2TKbIlQoahm8vg4Hg3f/0trxS
         JlMAZfRVow1IPEkmYgbKIeE/Ar3V8/m1pfH9RL4dDs05v5I3hUDr69g6Cb4fGdZE3eqf
         Q8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvr6cTFe5Znolwqbs6iLSTVt+97sm9su4U/jtXgrA+kNxg31mNfdFPOb0nhhjoX7hfbkRI1D6Pkw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLMgjp1xR1JXg9/LsvZ3OQOrZ4gOlgtF8VHEqlzkFVVRMxkGwT
	fkDba14g442OBdTNUTsATj8rQZJy5W6ctro3cxhTqIsqcuDwuUy9XcTxKDWCuLhA1M38TA==
X-Gm-Gg: ASbGncvtl6e4NLEj5t2t4sOxjGKdantzDNLFIemc4jkLPUX7Bj4d88TG+Xax0yQYIOM
	w01DhyBgxwITO6I8U+d0a+bFy+qxFOMOGOaaFZAmW47K8q/S9l9344AryZEGAmlHuuLDqgnYtTp
	cOdMFI8BixBbdyUo8zihgrSWX9gO/Fbvp9ObhQh7BABVb71wyV8cTIuq94UtvLNqZP7+5f0TH8w
	8ftHZWC5Chj8zyZ5uvZMea4BoqKSaai/epxyyL2Hds+eSwNZuT/Cqbfs0FpbFqaIpkM073UFyhP
	kcRdmt7vF934L2grlbw3VyFFOCrLm4pXksPNKkfpe7jAKRqLVwQybqrCLhzSDil6us9K3f74wut
	5dAtOkXmEz8lFCG0MOfj9BdOGTIdcrAMIFPA=
X-Google-Smtp-Source: AGHT+IF7alqB/6wZ98S0FEX+bkqM69+K+32EZW07YuWmetJ1TBK03m4jlJehXUkJP0iXJhxQOzaY0g==
X-Received: by 2002:a17:90b:4c4d:b0:321:43b2:4743 with SMTP id 98e67ed59e1d1-32143b248demr1268396a91.23.1754294395745;
        Mon, 04 Aug 2025 00:59:55 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31f63f0ba97sm13749540a91.29.2025.08.04.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:59:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: virtio_uml: Fix use-after-free after put_device in probe
Date: Mon,  4 Aug 2025 11:59:42 +0400
Message-Id: <20250804075944.3612712-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_005956_850365_D7041318 
X-CRM114-Status: GOOD (  12.23  )
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

When register_virtio_device() fails in virtio_uml_probe(),
the code sets vu_dev->registered = 1 even though
the device was not successfully registered.
This can lead to use-after-free or other issues.

Fixes: 04e5b1fb0183 ("um: virtio: Remove device on disconnect")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/um/drivers/virtio_uml.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ad8d78fb1d9a..c402c4cc908a 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1250,8 +1250,10 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
 
 	rc = register_virtio_device(&vu_dev->vdev);
-	if (rc)
+	if (rc) {
 		put_device(&vu_dev->vdev.dev);
+		return rc;
+	}
 	vu_dev->registered = 1;
 	return rc;
 
-- 
2.25.1


