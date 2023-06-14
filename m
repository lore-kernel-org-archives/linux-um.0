Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CACEEB64D7
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 00:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=y+5KETKqmpwUsD/9Cj/zDy/24WT4O8qO4uHkMewapxk=; b=DxBRwQb0oltzea
	nC91iuTKdvIPVo7x5x+AK83uStOOKQi8rCZL8fHNkyMwViF3rTAarFm25++our7q4sJG/kHqZZbwI
	6ANsYGUiFS5v9kwMpdA7++AqUpp/HefnzG9/S5VKNQiL7YJQjtnoP/c6DWJZDp4mxXpqMQSP3iZva
	uWbAWTcPnX1JiLclW76VOqW+kTJDwaJ/gXKwKpVPZneVSjkLFo5ENDS80X1Xn519LQXDeC4KyMdAH
	jyfPYmm7sl7QA07R+87KOWjIxFEZ5qqPONdoPMnLfrtPh72PWpuQ/JHCrlXcduzm5eDcP6rYiNJEW
	UIC6Z8KWGSurS17JodAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9EUl-009Y3B-20;
	Wed, 14 Jun 2023 00:36:19 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9EUe-009Y1i-0D
	for linux-um@lists.infradead.org;
	Wed, 14 Jun 2023 00:36:17 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33bb16ac2e9so25452635ab.3
        for <linux-um@lists.infradead.org>; Tue, 13 Jun 2023 17:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686702967; x=1689294967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqWV/pnyyDUYkwTA+7Sh2AJ6YJrRKoUQXxS4iBU19zk=;
        b=NCdkRND0uC2XlA7YPldjVoBxqUJXvAxX7EBgqaLCwuIE8u6vezjwlRYBPCd27LPDe7
         IQPBonjnPAyfxfdB5Dcz/5eJSuoOPJxNja+LFwip4HxQ/92Y/HnfUiWrTXeptg9Ln3Di
         Wpnbi5+1op2bx6K3IVIKJaczm6oe1uaiCJq5HA+2F5A2koZeG4Wqx79co2Jj5B9MqZlt
         uYi22nj2CTpJLiSaXNDtdEQ4WhvmmeIQjw+QzbtvZ+X2DgW0ouQheD/ax8HxZO2Z9x60
         jiPSN6NZv+Gh1KtGjKm5O2UurZN5ySGNk92P/embGIhWX4PqaZ3yxuusBfX/95562kKF
         CO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702967; x=1689294967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqWV/pnyyDUYkwTA+7Sh2AJ6YJrRKoUQXxS4iBU19zk=;
        b=BhE1KGAyrAGC/Dhjays/1FaVPMsLNlC2J6BRIBXhZmWHXPdTuK8B2PA8iAcZvqwZMD
         U7sENYKPD/QdPOGeLqlvyI5u/kNuL8suIkNhkwE1OCbum0lwWilKqNeJBKSk+zRm3tbf
         SS/r5Z0EY716LMyKjrEjBAdv/NmcW01rWd2GbtQk64cGWNpWn3S7spJYXeN1JPv8f/y+
         8xHFTbtbYaHlXS6KJtrT/cL4O/IAQksjB/wEG8/nPTSfHw6IXKLfP1/dsasjOUyTLHzB
         H/KAl5c5CztI2YkvmcOTNxkP20qxVMREvZENdsERM7maV4TnmlaWTvVsNV//rXFBi63d
         QlPA==
X-Gm-Message-State: AC+VfDwl10ElTbN3TaHym/X6eplsxoM7MlN9s89Ym8E0zJOmS1GMZ60u
	0AkD6zmLi8eB8KaH6cDBgto=
X-Google-Smtp-Source: ACHHUZ49GziAH6p4LMsFcDvEgpV5WbArcvQ1nZ7RKW63pE36shMn/iEVZa5UqboftYUVTUBdPn2lIw==
X-Received: by 2002:a92:d44d:0:b0:335:a70:5e4d with SMTP id r13-20020a92d44d000000b003350a705e4dmr11322786ilm.16.1686702967478;
        Tue, 13 Jun 2023 17:36:07 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q18-20020a920512000000b0033b2c178254sm4131604ile.22.2023.06.13.17.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:36:07 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Maxim Krasnyansky <maxk@qti.qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3] uml: Replace strlcpy with strscpy
Date: Wed, 14 Jun 2023 00:36:04 +0000
Message-ID: <20230614003604.1021205-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_173612_106779_47E91AA9 
X-CRM114-Status: GOOD (  13.18  )
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
v1: https://lore.kernel.org/all/20230530164004.986750-1-azeemshaikh38@gmail.com/
v2: https://lore.kernel.org/all/20230606182410.3976487-1-azeemshaikh38@gmail.com/

Changes from v1 - added strscpy declaration. v1 does not build.
Changes from v2 - removed Reported-By: and Closes: tag from commit log.

 arch/um/include/shared/user.h          | 1 +
 arch/um/os-Linux/drivers/tuntap_user.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bda66e5a9d4e..0347a190429c 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -52,6 +52,7 @@ static inline int printk(const char *fmt, ...)
 extern int in_aton(char *str);
 extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
+extern size_t strscpy(char *, const char *, size_t);
 
 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")
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
-- 
2.41.0.rc0.172.g3f132b7071-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
