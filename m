Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CF9C7EE24
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mc8u4LkUhcQ0+rypfrdWa8dIgIkYNJU0wdsBRYixg9M=; b=Yd9K5GByW2TnKZ
	PdlzCVRsPSgf14IAQEu1jS7VfSxVVi/Q4FsYwCfBXeE2/VbOjxLODIqqrvEfppOK3Rv9lshtaJnW8
	mE8Qk884xnI/yWM2Xwy5qAr1Fj1CAh2j2t0IaSSJPlZAymCyxRR4ucTMayY2nCzZ5Dh/C38tuQZec
	RoqbFvQs8SoSM7E9Im8pnq/0X993GYlCvp9iwnLWUPI/r2p+L3Kp84bcmeyYvWPAs7ftboyTysCQH
	J+mVsYthIF5OOeF8cewGv77y9HN2lKaVmmxDaQhIQx1CXgIh+Mzj7IiOJzPcfs6VoUAIB1z/Yt6aN
	q0OP7zECwygrla1qPKIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6bM7-002lBZ-0O;
	Tue, 06 Jun 2023 18:24:31 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6bM5-002lAX-07
	for linux-um@lists.infradead.org;
	Tue, 06 Jun 2023 18:24:30 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33b4552e55cso19048775ab.0
        for <linux-um@lists.infradead.org>; Tue, 06 Jun 2023 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686075867; x=1688667867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V12rCjy7mPc3LIBp5uRLQjG6txyB7DcxNo61Y87f3E8=;
        b=iy/xvJarg3bLpHU7R7JQ/+OIqn6X9rB1vjDBEYSmRbGrF2GYKSNyCBxqDKaTg3TsY1
         m8XyTGpH3SUlb8n2kQg7nkhHq0b+xvMWHVAwznViXl32hPsaKltXyM7txeJ3El3WXp2H
         /RsZ/MHX05X8ig+jqB6WkaMITlkFjywymK1swg8trjjSAYwPLIC84KO7kM2we1+ZWb8x
         Vpq/cQw/auxNKUg100D2+YjMMUajgwlUt09Z73LOQworieqQRB3yUdq/odGQZDC+Xl0Q
         mwL7r6Z+4XZ7veO+wP2a9CgrH8sfBr9vQdwtRPstIS8z/ofMvJYtn8MFqNF6uDm7mvl+
         2P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075867; x=1688667867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V12rCjy7mPc3LIBp5uRLQjG6txyB7DcxNo61Y87f3E8=;
        b=TywLcAbdJBgI2CD4Zwr1Om3JmWBB0dIM46Nst6qVGqDrQ1aiD64P3ghoVPCe12oMo/
         WXf3VBwVfI2iQDK8zqdz5I2hDDUePrgWqYeDWisA3uoNKoGdzZDvIeHneqnanRZ7/pO/
         QBaA2ZWz88I9+MNZQdGbiPtLbb4K89Hb7Y+BO9iK7V+8bvsjfMwb8shUSPmaZ5gu3vtk
         F38vIxybhlCh81HfcLJt0AMoSUZRbxcXElnHWPdN8JZglAvkPYLbgbTw9P1/PYkw0/zb
         q9rlmXn+jG6PciVrO6UPg5ajW8cxk2IUMp26CJ0j8MAD4WTa6nP+573/q6fKjdyT5PQK
         YjLw==
X-Gm-Message-State: AC+VfDz6psThwYEVvbzA4caSKc0DtZ2QsnTIr/YsvLrUXeLTiN05d/DA
	2ye+qrs3cFVOFMJj6q7GCNw=
X-Google-Smtp-Source: ACHHUZ4Xl6Q3aZU+8ToKIEYcfoUZ4oDIRjhiWwJIU6JSAcZnO8WFZANa3GqrSDV09npzYmGy1N2rbQ==
X-Received: by 2002:a92:2805:0:b0:334:de38:d600 with SMTP id l5-20020a922805000000b00334de38d600mr2401946ilf.3.1686075867141;
        Tue, 06 Jun 2023 11:24:27 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id p15-20020a92da4f000000b0033a4f125238sm3235543ilq.41.2023.06.06.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:24:26 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Maxim Krasnyansky <maxk@qti.qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] uml: Replace strlcpy with strscpy
Date: Tue,  6 Jun 2023 18:24:09 +0000
Message-ID: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_112429_075188_0D5A4ED2 
X-CRM114-Status: GOOD (  13.14  )
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
---
v1: https://lore.kernel.org/all/20230530164004.986750-1-azeemshaikh38@gmail.com/

Changes from v1 - added strscpy declaration. v1 does not build.

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
