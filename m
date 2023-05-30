Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E02DC77B73
	for <linux-um@archiver.kernel.org>; Tue, 30 May 2023 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ma/FF0HKt2RWCl/AOwTmrP89KwPJQ8YWNTBKz406d7Y=; b=3ysOvbQ0QWDcuY
	u73RFkQt2Vb8OJHTz80fFLUGFTltBZNshc/q/TsMNv9Z/ZbCZ3qPcqh6ueCXJMmbL04g6REKF37GJ
	GXs6MRFA3SEzXZ+DZnOvqw3k8TxTbj3fLPtrtcwkRMIBjrNQYCaqDhXHbSXysE9Sdu6P/lbUBsf6x
	vxmEIaBVudLqVk4kVcycml20ut+57XdvnpONUdPxDBnRWeQVwaaI0wqkbVEPVoLtSBfw1zvVXIp56
	MkDmzMdkmlNQi8GFWC1D9blm1CKLI7TuultcAjWuzNhceSPZiG3rQ9V5jo1i+jAxbNOeMDIIy7TLq
	NcbdpB1HXaMT4daUoa/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q42OL-00EbXM-2w;
	Tue, 30 May 2023 16:40:13 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q42OI-00EbWV-2y
	for linux-um@lists.infradead.org;
	Tue, 30 May 2023 16:40:12 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7773a735bf8so46703239f.1
        for <linux-um@lists.infradead.org>; Tue, 30 May 2023 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464809; x=1688056809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9agsz9BdjIrnVIxMaWFsK/cg3sewH3cif2PKAjY54I=;
        b=A4n+XhPujTRI+NiRmDmvoi3Hoq6SkXjqZHO7TUcoOpafJPQqCKiZSaZkESe4mrOBDo
         pdla6Kmb1acTOmDCpBKITbAbdjuXF/ZQ9OSn1yrD6ExSuADNkkHVefu2zMfCepFibH/y
         X/GD3wN5lTeNDOVKW2oXNOZcnMvXte5ZQtzkiDqeMiL4PHyUNC8piFNmGzzmZ6yZ//Do
         GZTsTNdhEcsuudsZR7zyiE23IHQKzf2+7xFujVaD+7XM0n3LyEGSiocbVsXbN4WMeyP+
         3lesFI3FS6EF1VMM3Oj2fhmjD8Xb2k9TJNjomesUswmn8T0pBs7UfsOpyVeobKPY8d1y
         bO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464809; x=1688056809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9agsz9BdjIrnVIxMaWFsK/cg3sewH3cif2PKAjY54I=;
        b=d9V0YDmOL6Qa4BczdJHyUKW5aHSVrucp+UrKfZEB+Wayr+iJkd7vcj4JRxXKs3dOMF
         CssWWNiJidP6KmqaVhPEXAQWgimQapbnd3V2cZhLmrMKORypc5tTa2Y7ZwKcoc0mRk9r
         eNoXrWCFT/1VzXiZ+GSBdvdRLhn4jqCzj7eCswyD5qVHIXMh8F4t7mDMMLs8E0RNqWLe
         ZcLUk29Dk3ndasA5FOEGtORCv5D026r2LmSJZ5mjs5hNL6v3+XLh3Pi286uIDRcd+GzT
         +rnzc7jR6XEz0BGEF+djVAO2UcSyof+6Ft6l2oMdJnDvtRCq62rzCTw95tXHTHNxUjwY
         U0HQ==
X-Gm-Message-State: AC+VfDyMCQWPGc1KA9JA28otjYt4McuKV8D9mfHWcp8y4BsVitbMJBjJ
	dnH8awgWAqPdL942f8MK/z0=
X-Google-Smtp-Source: ACHHUZ5MI/JShx0lc4b7BjKuSUS7T9wjVGEPE6GI2tCvjroHoHLFi6oGYoUUd77mQWSytwYcuyvKkA==
X-Received: by 2002:a05:6602:2598:b0:760:ed78:a252 with SMTP id p24-20020a056602259800b00760ed78a252mr2054989ioo.9.1685464808981;
        Tue, 30 May 2023 09:40:08 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id l13-20020a6b700d000000b0076c81bf2731sm3330165ioc.20.2023.05.30.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:40:08 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Maxim Krasnyansky <maxk@qti.qualcomm.com>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH] uml: Replace all non-returning strlcpy with strscpy
Date: Tue, 30 May 2023 16:40:04 +0000
Message-ID: <20230530164004.986750-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_094011_001191_00ACBAD8 
X-CRM114-Status: GOOD (  11.80  )
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 arch/um/os-Linux/drivers/tuntap_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
index 53eb3d508645..2284e9c1cbbb 100644
--- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -146,7 +146,7 @@ static int tuntap_open(void *data)
 		}
 		memset(&ifr, 0, sizeof(ifr));
 		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
-		strlcpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
+		strscpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
 		if (ioctl(pri->fd, TUNSETIFF, &ifr) < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "TUNSETIFF failed, errno = %d\n",


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
