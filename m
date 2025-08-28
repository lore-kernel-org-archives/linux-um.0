Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE0CCA0FF6
	for <linux-um@archiver.kernel.org>; Thu, 28 Aug 2025 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1aOcVnvWN8g6UfQh+XzURaGBPWpWkDYdfcs5GE0kaLU=; b=0nDK1xiJn1hZqttncyih+0cipB
	53q5Pv7FurDw7Md/sKWCgyIztvgIc75YkR7IhuyMnJqNKccGLThiPVbUMagZXq632QEpbn9iSonKT
	memDajv/uT4SNZY8QbB3qEtE0IkCEx+ksoeSR9ayDMjJ3UcuVyxOiA+SKT3MnyEe5X4gbSshxbNsn
	TQ53m718Qv2b4au1iTptmt0Jy5AybmxMQ1oxIx2daJWpMEsPBrBNGDWMjId9fHPlz59Wfh16mxxkC
	OW1zLWSoDszzd6ed0ScmV1OJctl9tOse3a7/j+DCMsyqBotXWthmsW27a6y7rmASErpdThrAcTKuE
	onXWCwWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urWdA-00000000WKT-2HAJ;
	Thu, 28 Aug 2025 07:01:08 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urWd8-00000000WJP-3XGJ
	for linux-um@lists.infradead.org;
	Thu, 28 Aug 2025 07:01:08 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso467644a12.1
        for <linux-um@lists.infradead.org>; Thu, 28 Aug 2025 00:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756364465; x=1756969265; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aOcVnvWN8g6UfQh+XzURaGBPWpWkDYdfcs5GE0kaLU=;
        b=TKyONAYGW3GR3KR9AQ2n6nisIze6b65s/AIOn8ymvVvGWAW8YbRruVflY6enDQVdv1
         nBm3CRU1diMZFoKB2j1hZExdqhDiqat3JX7Z0M2qPdAPLLl4UOyrcDtI1tnw3dgjqgXL
         ZKgXsqoiKHbrNFTb8EqwRuGkCong8TmEsDR8fe8Gtym/93whVs/8fYOW0fL2Ve8HbB+x
         IuolzjzWGmjFX4xRWxnxuyTNuxUOV6igG0R0i7c/jkqT6VnEMJJHPsOXpFXZRjust2vI
         zPXSEy4C1XO/7ABlwjURUBis8Ly9AqkTI61/R5BSygdYiLGv3gb9i9HG3nCb41gQwy26
         ti7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364465; x=1756969265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aOcVnvWN8g6UfQh+XzURaGBPWpWkDYdfcs5GE0kaLU=;
        b=xJd1OlDlbv5tB2Z+jSxaUm/FamXvuE5d1ZQhwlZSGm55g0CKyaGC6dfVSTYuyZIJeh
         Wl51uSm3YSCU1xTR0cqqzmyNYI7bfES4NzXDFOkMw109Zzw++gVXPW1XoZovJGeavr+i
         TCqOUFZ8XjUy+C15+zs665xwWgWxFihiutm15r6EdS0YWiA8WGBsKCNPo3h3GsqQGgeo
         0HaC/7vHhmQR/2wizh8Ki6uFGGQxaEc+eza+BmcD+bRPT2/868kKBQtXt1Dq7eIky1TY
         SI3h0hGWWeek6saWOWotA8DEA/yxBEeUNktmaxyaoXox4az8MVU3Ksw4yzjaEitT/WJm
         C1hw==
X-Forwarded-Encrypted: i=1; AJvYcCVdggAwD1pSbmFRnoVZfxdIERTYPs5bOlX4HSm/OsPQJNTAN2ACD36YPY3a7Jcr9Zs4avj2P6vEMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyIZPVLqbxuTf2DsUOk7THtmK96rLRuWABiwTe7pwhDtDLt4k5F
	rt+46uEynG/kUsLE55tsON9qiI7LGf3aToD+zXNkNvpER8JFqqQOENgk
X-Gm-Gg: ASbGncskEZy5oVnnqI15rHVnlDZ7tGR4afevl5a9fs9fzqZIgr94Z1S3h6C8t3ViLX9
	dLVaKoJijttPsSFbQ37G9F+EUwRQKiTccYxPZLMbbd2XyBsuoNmGCIBe76VQrsgfZm7fBm/13oB
	Df3q3KWVUDY42JMVYgHNMN4iHAy/JtEJZxxm2czt8W1DtEhxJzb75vPfdPaHxVQwEbZXSvYzNw0
	AVyczOG+OIonqWr3i/wzpXhb/B9b8xnG7SMKvjoAru5NC/hUffj5+1l0SBZNvsCNhZo5ExPss4I
	ChQfH6sIh2+0HX876RLt0t/zWT2YAwx16dtLnv9cu5znCgjc7qjSkRa3l6EjWq+wMHv5MbjwiOX
	s8D9aImgFNakXmUO9Igd6ZHil5aDN1mA5fL8Ma9Zk/PD704beOw8jqTuItpIeLviBLf1lRj4bxw
	npJwrxowrV5d8=
X-Google-Smtp-Source: AGHT+IFGQQsK30mCIpp68bAN9dNCGp0foY/SytgIaAfNqbLTP9wA1efm42gK0s3lba/qv0EaQY9UEQ==
X-Received: by 2002:a17:90b:3905:b0:323:7e80:881a with SMTP id 98e67ed59e1d1-32518b82606mr32688817a91.37.1756364465327;
        Thu, 28 Aug 2025 00:01:05 -0700 (PDT)
Received: from localhost.localdomain ([112.97.61.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32787c455b8sm1632608a91.1.2025.08.28.00.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 00:01:04 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH v2] um: virtio_uml: Fix use-after-free after put_device in probe
Date: Thu, 28 Aug 2025 15:00:51 +0800
Message-Id: <20250828070052.23606-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_000106_881468_8E997E67 
X-CRM114-Status: GOOD (  11.93  )
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
changes in v2:
- statically 'return 0' in the normal path.
- v1 link: https://lore.kernel.org/all/20250804075944.3612712-1-linmq006@gmail.com/
---
 arch/um/drivers/virtio_uml.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ad8d78fb1d9a..de7867ae220d 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1250,10 +1250,12 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
 
 	rc = register_virtio_device(&vu_dev->vdev);
-	if (rc)
+	if (rc) {
 		put_device(&vu_dev->vdev.dev);
+		return rc;
+	}
 	vu_dev->registered = 1;
-	return rc;
+	return 0;
 
 error_init:
 	os_close_file(vu_dev->sock);
-- 
2.39.5 (Apple Git-154)


