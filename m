Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A64C71157
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=; b=mFZQit5rjlrotETmYMU/1JE+d0
	4Sek1kNlplieh4jNtTObCyK3gM3uscxYnVuNWmGImSvaDDSZZeMQr0NKXnpVaHEtGbuko397VoPqg
	FM2mdlX9VYeIdkJHO7VFinc3IWo9ZrseYKf4w3vArswk1upZ2/UFEVbsjlbQmmORDdaUNRU4UDjAO
	Ew0H8+sx15jDWkLlmmwxN+4mC8UUdsgxozrhX4H3clkrOwpZ4lmSH8Sx0udP9btMLTwOjx4/djiUw
	180eNgmM9IR9gv11IZX32ZCtWMQzv1adl74XXNjGnM8CnEHaTypfxEL1zkkQF4lMVH+1Prozc57jm
	aR4LZEig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i8-0000000BgoK-3hyz;
	Thu, 19 Jun 2025 01:05:00 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i6-0000000BgmD-1kNb
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:59 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso144260b3a.1
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295098; x=1750899898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=A92awqHuTV+/lgbi62sqyN+ZtPvHJdto9YP87h5pEynLuoSYKdfybNLgxHtayL5SMc
         dS1ahn7qkwIQd8DTt46JZtj8ce5oUSfMOJYA1Tg0TQ/FmA1AWTL693OaHATNOZ2wsE9G
         CyrzU/Yazl+lKQmEg2A6mK3DdaysIFmYCkPk7qp2U0OYvrvyOMhwVQJx5PGrwtciFgID
         ZEdN5/QYTcVMwnZc21ang49If/TRknSKHtgpL3KqzLXXgiEqkyqtZTfLJo33Tgp8PZrF
         G3ygmP5it/oZUQ1tq9XHy1TzqB/4fBxAP6fwBdkEf3wc4icUS7DJ/PvFS2HnJyFo6EK9
         nYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295098; x=1750899898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=FEXR/xd+EFCxznsTqe976iUz45kOJuDmumABKfFvewt3B6an8QqrW4LQsacKLjFF0g
         +DO59dJjRXGsM1rRHCQx6+ClyJ0H53fhxQ3zq7TGLNwqVMV57cY/P0gSALhhvIN+qktI
         qq/JvBdMihIc/B1MJ/en9qFR3AfB5NN6o3yv3BXsKpAklWY/LRB9MetWXIIV6W8eJHJT
         3Z89KIs/J3yKNtHZCyZgPMux7ZbKRW2cE43BTI4Io7EFTf6XkXJuXOD9u6eCFKGsnu4C
         zREOTUVeOfWTivqOyrcffOXmObID7V9QYu17f4F5+ku/DiW/Qp0wA8OnVUdb8oBb2W0r
         yKfA==
X-Gm-Message-State: AOJu0YybFcnGWXjH/yLcexbzYr5oS7hRUilNPK0pEiPP09KM2m76xr26
	x1nd5/iu3U2nJqY98VByWlsF3Ie6ysKF6WQsklGJBcLwhRyvMZp3eddX
X-Gm-Gg: ASbGnctnjHrAuSP3HKD7uYoJYRMprrt2hxz7p1A2yTQIH9X1GjRRLeDBc7XDuUewoox
	gDYXK9TbIlPoQJEeReN6KdjkvcKri0qIOTyPbY+nAxhGm0PPFjSJkfzNsSx1Xtn8kE5fb9eQKXk
	Hz61os6GCT8Xhja42vwgcg5uFkuH1XNjmVEvIsec5lwSAlA95bCwOCGhwmcDWixgc/fVK83qAdw
	shW15wEM9d08m6OY5onp4zp73GyX1Vs05y6cDeii7emmrGN2XNve6f8VcmFoOUBELdEMoU2fTCN
	9CYn9PlGnF9hziA5oSYOiiTME07v9v5NvYMgntVewVXvMLCkU39LnMdZRSNqLT+rzVGlMBHcebh
	PxLz+bySN144OQdDixuj8b1Um88cv7shs22+KVzMBZEY=
X-Google-Smtp-Source: AGHT+IEV6Y3cJLP4JaMcdJhSY/ETlnIE+14RVCjfX1yXRvBEOpmZSlGpLo0DZSp8M2QLOOjfCnAESw==
X-Received: by 2002:a05:6a20:72a5:b0:215:d1dd:df4c with SMTP id adf61e73a8af0-220111ad18emr2803824637.6.1750295097772;
        Wed, 18 Jun 2025 18:04:57 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d233asm11870453b3a.159.2025.06.18.18.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:57 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D9ED2ED653E; Thu, 19 Jun 2025 10:04:55 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/13] um: change machine name for uname output
Date: Thu, 19 Jun 2025 10:04:15 +0900
Message-ID: <b580c35c6a52f009d863a1fe29bd7b089283b994.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180458_456935_2FBE33FF 
X-CRM114-Status: GOOD (  10.59  )
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


