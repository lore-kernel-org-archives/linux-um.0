Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C938FD5F86
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KgVbyVFvTMOOobCmboEzJiSzpNTMaTKxGh/qViShvW8=; b=Y3L53EJWRmNpJlLiVjO4XhAoTi
	2MB1Mk2uSGoKkEsc+mLwWzRYK0tXodBarQO/Urn3XdEJfAUdt2tnxAfIDhLw2wTr+YKNZi4Ur1W/N
	HRdUfdjnVqcGP5IoEWq41goV7V2XV6SPuHbd7mSx3zOAILCTFB/9T9mBqjmw1dhjYETwuB/8W094y
	ThOI84gHsy2XTV1f+Xlu2N1m1y9Or008WPUp5bC5xAjvWnUK4dn3oiI4ebdjVZh/SWELW7px2Kn6/
	8mtetJusqIT6o6HcCtyHubOySZ2G9dCJFabgGAHjQeWTM3knRFKd4rbzHzddwJ9dcokgJqJp9VrUU
	w1rtFosQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAMui-00000008NrH-0nNW;
	Wed, 08 Apr 2026 07:01:24 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAMug-00000008Nqu-2LAz
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 07:01:23 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8a0323830beso53664096d6.0
        for <linux-um@lists.infradead.org>; Wed, 08 Apr 2026 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775631681; x=1776236481; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgVbyVFvTMOOobCmboEzJiSzpNTMaTKxGh/qViShvW8=;
        b=QTut8gePWRRF/T2rdY+n/RgnRFlpsaoV+ZTyKQLcMY13vwmSFzIiMHC15+B+nKx8SD
         9yWrQIYK/+R2rFL13i2vxydCRNaFgeMHTPpollKt/1oZTV+HZrW2E57mrePxswhF2dSU
         UZHIQM8wi7Bkc2QUaJ2+sNYndYk9TWUh1M5qxeUjUyBwaY+cNnXvg6oJQsu8KUicx/iT
         6aEv8NWtVo4Gvv7ExjAGCrqp6ZFU3TM+MW1JzLCR/mIfkPsH5Vv36Pf1l92/eI3D7RBK
         SEVfQ58TdcRfOdUsyxP/kva1Bx9IkYHYyHJ4ZF3bX6Ip+J5MHB0BxbWjLvecu+JtEUVW
         znqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631681; x=1776236481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgVbyVFvTMOOobCmboEzJiSzpNTMaTKxGh/qViShvW8=;
        b=A+abm0hRrAsEpAGTdxsVe4FrixQbP8IGJqsDs77a+lxBuX8SEINubW9vFS1GYYJ31k
         +lG5rb3rRAB4HhcikHaT0+mWoNdNs/qgBU6/4/fQfgD802A5jCCPxj+FJt0ik0mAwej4
         qV+MSnhQSqX8VfzweBMX2TAlLv/5EvUUyvZR2ybr6h3aAkQm3sqXvjDW/3bVQRxrUx2a
         DbXxJnrUV6JP7N/A1J2Njfcf3WDJNe6mZ8B92Gje6ITpl3bh6VlocyWAORXo7N3lBtpl
         U1rDrsRFBAyyKsTuygC9oZi/rz2vIlIt+SnqBwnTMBSziwkmmrOLOMGgIURmYCuxKhV1
         5v8w==
X-Gm-Message-State: AOJu0Yxlr9ODG64NfhjVPAhs+pS8WTV1ceP8asucSuffPJU/AeeFity5
	qWik/XwOAj/89E+srfuo568+LKtG6qFHMdfC76WI2/hnvQfNY0+K0ie61eg0wg==
X-Gm-Gg: AeBDietYLGOWdGSWGesWc5hMjmTxyjNZQaNwoeyQOAUUIB+/NjsDE1KACG06lS5eUsr
	XRDkrALVWLy7jMsvW0zRbMbxyN0R0FHByso7I6LxHnHRIFtottplPDWhkYSlYZcCrMA2pFLh2SJ
	uQLoRE4ecLrMeYtQj4eT2hEW7Hu4wd+T5NdJNZPoCmT0F2d38nzcKkJq//muGnr/xDGfaIhvEEB
	axAiQ0fvSFoUDfeVctTnbgWJB8VXkgPah8SM6YhofqFXbi9vCjG9PJ7UwLt+iMZinKGTeTlj62I
	/OdBAE5b1vBGRCd0uafj9qvQKcvFQ+It8UKC9XUdq1B8wM50jpsHxUaaiFRj/aBZy50n2N+3eW4
	P2UvVWW/ui7UxO7KTI2wUkE3y/duuji6enWvZJadbdmriah1kg1wy57JoWMl7FshCzk7uPGw7e5
	o+p93ooTFX6XGmrc7nQPN89WBU1XwUaKNbF5BOpLuZx62RZTuntutXB6xXWzZf6ozVd73xesMWg
	SvCewDwwdCUxmFLWBfbik8MCAg=
X-Received: by 2002:a05:6214:c26:b0:8a6:d318:4909 with SMTP id 6a1803df08f44-8a7020bf953mr327652746d6.2.1775631681042;
        Wed, 08 Apr 2026 00:01:21 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a522sm163454596d6.32.2026.04.08.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:01:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Wed,  8 Apr 2026 03:01:02 -0400
Message-ID: <20260408070102.2325572-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407164435.726012-1-michael.bommarito@gmail.com>
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_000122_606467_61FDB06A 
X-CRM114-Status: GOOD (  11.06  )
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

Building ARCH=um on glibc >= 2.43 fails:

  arch/um/drivers/cow_user.c: error: implicit declaration of
  function 'strrchr' [-Wimplicit-function-declaration]

glibc 2.43's C23 const-preserving strrchr() macro does not survive
UML's global -Dstrrchr=kernel_strrchr remap from arch/um/Makefile.
Call kernel_strrchr() directly in cow_user.c so the source no longer
depends on the -D rewrite.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: https://lore.kernel.org/all/20260407181528.879358-1-michael.bommarito@gmail.com/

Changes since v2: trim commit message per review.

 arch/um/drivers/cow_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 29b46581ddd1..ec8e6121b402 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -15,6 +15,12 @@
 #include "cow.h"
 #include "cow_sys.h"

+/*
+ * arch/um/Makefile remaps strrchr to kernel_strrchr; call the kernel
+ * name directly to avoid glibc >= 2.43's C23 strrchr macro.
+ */
+extern char *kernel_strrchr(const char *, int);
+
 #define PATH_LEN_V1 256

 /* unsigned time_t works until year 2106 */
@@ -153,7 +159,7 @@ static int absolutize(char *to, int size, char *from)
 			   errno);
 		return -1;
 	}
-	slash = strrchr(from, '/');
+	slash = kernel_strrchr(from, '/');
 	if (slash != NULL) {
 		*slash = '\0';
 		if (chdir(from)) {
--
2.49.0

