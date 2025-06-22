Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7FC83000
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=; b=Y+mkUbr5eWQnMAxGEqTpzQ41HB
	sL/joK3OOILEHlrgF24vVk5tRacCossgml2Swxv9I9GLRoYVEsaQ+FHlgbt8/cvbdOaLu1qpFTiuL
	fk/eXVEQYMo+/pcrH825WEZ+dyJ8Fn7Wxg4fetjZ1zZtCni+igeNp2u18IDMAxZg6xwHFKbIdII2P
	smgKmH9bDVrU3cdW68hRp+fN3hkcQJNiy/8+9S72l4usSBSgguGXfWZgi9kdyFWyptUZjKxVr/anA
	PTYbiZB2CEZWQabekgGwkeA0hdWKXpXhgI8ghHgqr42g4d/mKZOtIFrIzGbchqQVy0JB1s3pvjchB
	eTp2wcTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKI-00000001F7O-2uOb;
	Sun, 22 Jun 2025 21:34:12 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJq-00000001ExS-2D2C
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:43 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2352400344aso35335205ad.2
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628022; x=1751232822; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=Ebc0Nv6GU3UuLVOLYErRDXU0M/XltMxQAnQM2UUg7SDI3TbXnE8KLOzozYX99j1aKc
         NNEqzsYRp3Ey+iBp+Cwajce/Jf32D7CpY7UnIlkhEmrJYo0gBT9V/olxd2qeJqpJ6QOP
         xZsomaJ7rs3pKg6AhQq67nEmurvX/UW1bR7RVTvnB/cEI/63D1Nu/B7GwnoxuDGaMHqj
         82/3nALaSJ0zkAZ0FV2VLCENd2SH3LB2LJlHyZB6xFic0FhZ80erjjWkRAw9OfZxM7ZR
         CBIby7sGZNqfZKYJT1t/m5BanJl045Lk1zt0CSWiqTDHO0srkZFs9p6YzxyOX43pg8sA
         lMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628022; x=1751232822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=LS3nLG74biu/9yV2Vn0CKypfBGjdW1E9HvNPoc9FvVkQwE3TSrIclExpaCf2LXOLbR
         4Gs91U0659Aa2pwGP2EedAJYJK92QJ/wvdpJoRBy7vDHAEmrQRKf5Zx9rTl9jM4kr2mZ
         2qV9hrWYPgfMEP4re7MwjuxLwHIH1b4mdu1cAP3dSFhF1r0+EFyRujDziqTIjeFYNb7l
         7+OXnWbM1GkFtZ5mO9E5b7SZkTEX2Usjtzr89DL4qRun2f7QuTp6h3KjqT/0qseRdZC+
         BpZoZNoW10QKrvIGw0T+wOvqCG2JCP1BGb0fNfujNl+xDaI/0+EeOEgZcWayLOaUS4k/
         OvTQ==
X-Gm-Message-State: AOJu0YzXbDCuRBgiwrrVa0tLShUrROHg5qkQhbQdL7DFTLX9kPZCI/SG
	dybJRIypHfs56TNVIYcMDzB457Oc+fNPOzOTE5coGMk8GA3pqhrPDsUG
X-Gm-Gg: ASbGncsVXfmaL5z6kwzqnqYr5Timm8RfNvJojvGfEfoU1AT7yYuRMc6k20XlZx24SxT
	UMa/8Vi94LW8QailaZyPywpWuFLSg/VPPDO2R3s1Iqk13IB03XThTs5V2onAdn6qn49h0oHj+GA
	IkcMl7IEqLaSgDlvAtmGLdPJBGMz5mP78Fah8yCOnJ4xyZBXOoCmsfI7S+FroXG7FJjNCOnG+wX
	PfFOJHskhIX81mYXjmhS2cmajiF5wCCI8vtuxLPO+t9KJlARoWs3LkY8S4b8smjcGkQQQ3kHBlT
	3fzG4vGja1T2V3QYYMpgISDiEvEBhZOITBJ3FOtZg54nl4th11mxbkNumbZuI31jd4XIH4spOCM
	zgRL54QEw8Ccpg5Cmmbp0mP77MSfbUtMi
X-Google-Smtp-Source: AGHT+IE2X/a6jjB1EnFZZyhowFHSJjm1zCMXjlA1XnMsjL3oMDjBlwH6AM3zKhRsmJ9nHB3vT4YZVg==
X-Received: by 2002:a17:902:e889:b0:235:f51f:c9e4 with SMTP id d9443c01a7336-237d980b75bmr163794955ad.12.1750628021956;
        Sun, 22 Jun 2025 14:33:41 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83cf981sm68073275ad.59.2025.06.22.14.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:41 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5EFA2EF1EBA; Mon, 23 Jun 2025 06:33:38 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 11/13] um: change machine name for uname output
Date: Mon, 23 Jun 2025 06:33:09 +0900
Message-ID: <a0ad90a5ce95e8d34c6c5855cff701bdd51dea5a.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143342_563677_5C72B346 
X-CRM114-Status: UNSURE (   9.94  )
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

This commit tries to display MMU/!MMU mode from the output of uname(2)
so that users can distinguish which mode of UML is running right now.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile        | 6 ++++++
 arch/um/os-Linux/util.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 5371c9a1b11e..9bc8fc149514 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,6 +153,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 CLEAN_FILES += linux x.i gmon.out
 MRPROPER_FILES += $(HOST_DIR)/include/generated
 
+ifeq ($(CONFIG_MMU),y)
+UTS_MACHINE := "um"
+else
+UTS_MACHINE := "um\(nommu\)"
+endif
+
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 4193e04d7e4a..20421e9f0f77 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -65,7 +65,8 @@ void setup_machinename(char *machine_out)
 	}
 # endif
 #endif
-	strcpy(machine_out, host.machine);
+	strcat(machine_out, "/");
+	strcat(machine_out, host.machine);
 }
 
 void setup_hostinfo(char *buf, int len)
-- 
2.43.0


