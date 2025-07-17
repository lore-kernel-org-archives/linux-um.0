Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BDC83F1A
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y3WcQqYlZ+nGmkIZO7BZjNBhDOM5R3Ju7Hd0Z8GcHCU=; b=WVuIi+KxEipUIg8FwsKmuA6F/0
	2ruf9Ik5m6gVhZuQzK+5/MBRxDorsoDRB/cof/syST3wbj34zZBVwdNcSkswo5jMyxRkddUIwgqpB
	/OsCeRBh5WCTOVfE6gxBOTEXar9kGs8a9YdpfZ+qTWMC1hXHgZU7QjLCTdgZaqwrDT+vl0m2rTBo+
	cjMXW7HbumdLz/q8fJiG7Z5+yQgUFYfmvvgFE4QTAR5HtU8gCC7MpSiOYW+RFQLV/I0Uqvemw4Z9U
	+46gU6jhzq3KwV4r9ZFZ6uNe1fGZjxk134wkqAHZ1joG62dm+BSytmf7GwhdnToZsCM9LjPKkn4lx
	1gBTdW0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ8x-0000000AS7d-3xWY;
	Thu, 17 Jul 2025 15:03:31 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaL-0000000AMvQ-3Dzv;
	Thu, 17 Jul 2025 14:27:47 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-558f7fda97eso784296e87.2;
        Thu, 17 Jul 2025 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762464; x=1753367264; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3WcQqYlZ+nGmkIZO7BZjNBhDOM5R3Ju7Hd0Z8GcHCU=;
        b=d4ySSF9xeRqaLaRDncVETPgTRqGgGIMEfP97uiBKE33p65g/REE/bUr9L8OHXSOiEx
         o8LDHFP2ZoakJysCbJ2Mg7rOQxruAnuuOnwszhDGmfFxGBpHghlQRbWDtxNJ3iOc0yGE
         i0eJAOpnXGq53ySUNpHpxNos7dL8yXBrT4eo4CtYnsq9cINzf4RiXiG2JB9wbKSq93Qg
         ErWMMOG8fM66AnMDqbIK/N+/+Cae4LynZqMDWql4yq6ROFH0FwjI9l6p/4y2TWYLk+i5
         0F9XwK2Fnw7puLXN1ungTJ8lt6pfcJAJiETiKM4xX4mWU9hkQR0zKrT/MOv9cSvQPV+3
         ft9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762464; x=1753367264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3WcQqYlZ+nGmkIZO7BZjNBhDOM5R3Ju7Hd0Z8GcHCU=;
        b=ep7ZIQ3cSlKZac/f4pOu8TugYk1CQ64mr8XnOCtxHlmhmqre4uaIxUO+68PA3Wc95v
         lrJ6eOhf+Azn5lecisw+1nDcCzxqDRCJ5egzY/CbGjmxCmN1YKTB8q0dCGjseIah3Pto
         KcC1rJxXPV+3g/gYUVTgvHBRAWZxL2eOQXMiMFl16PivqLk/nB/8bNIdZcVrlMqRcxps
         uvBiNe7gOyZdiglTFoRsb6e78/Z+5hslM5ibHWhUUT8Y0vkEgBRHxl7YTMTvhhnvIKel
         JazBJLJK4AMRJMGKu8ZYckidkiCUbToR9KtBe7BDL2JtMNkBfugxKxoaMXAV/WoCuRCs
         ULsA==
X-Forwarded-Encrypted: i=1; AJvYcCWwmqZuRALv8/KhrxnHun2/lZAN+R+0OE/Af+wRnqPuCz3/L+GdPFS+dHDnr5NiUm0dPf8Y7Q7q867i1A==@lists.infradead.org, AJvYcCXyGvRLdyjDD/r+nEAvM97P/IWPzcGmN1yU5k8XkmtpWPc/Gth8Hi2OvcsOQy2y1lLZdL7cr5cGQcw=@lists.infradead.org
X-Gm-Message-State: AOJu0YzjjHtEfYbAuOocbFmsqajBPpcZFUUem+JAPDC1oOx7BIrRJDkF
	XsNP8rbmqmIaBpNwUD1NdMF1e/RWu+/83Q0RaKh2OVchNgZnAApSJqbI
X-Gm-Gg: ASbGnctiIx7mq/M14NzvDOxfRMiX+Pj2B/XbcpnUzyLpgYngTBSJHC3HiiD0gZa5cU/
	KyfbXb45NaTqSsOYzdJyW+raRR3CtlldKY8UvrAB4x2F60t5ayM5zqY5yCxqBUGSaye/tc8rS7v
	ZQTALzl/HAy+G6hdThQbzZFW8Gdz3fsOP8QSDElYWodaTKNNGCWd+sAm29j7564KZFZK/djYOjQ
	H7Ml9m2hNCP3effKjNGQcIdP2bP2GV58Q5T6CfsYnnCYQ4RyqSci/BzN6LdFJvyjQNQf0Sa/Ht9
	W8dZDdJJgdGmi/rMuJEe5WiffD8YA38tvjdIa5xJfiLqEKS1czUqBnIm4yTiKf1f4NphrAhdSR9
	bfDRMLhsUIX0KISJ6I0ht+cm/ZD4fBdBCZeM7brZVkVTwmP1k1M4VpBVZkBHIfTdf6yEG
X-Google-Smtp-Source: AGHT+IF/OloHnnX3mhASN203Qn491wmneqjv+U28AgmKB7HhI1lYsnMn0p3m12S3GUHmxAKLZ2vT4A==
X-Received: by 2002:a05:6512:15a9:b0:553:2421:f5e3 with SMTP id 2adb3069b0e04-55a23f1f963mr2211249e87.19.1752762463801;
        Thu, 17 Jul 2025 07:27:43 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:42 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN option
Date: Thu, 17 Jul 2025 19:27:21 +0500
Message-Id: <20250717142732.292822-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072745_814904_C50B5EF1 
X-CRM114-Status: UNSURE (   7.91  )
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

Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
to defer KASAN initialization until shadow memory is properly set up.

Some architectures (like PowerPC with radix MMU) need to set up their
shadow memory mappings before KASAN can be safely enabled, while others
(like s390, x86, arm) can enable KASAN much earlier or even from the
beginning.

This option allows us to:
1. Use static keys only where needed (avoiding overhead)
2. Use compile-time constants for arch that don't need runtime checks
3. Maintain optimal performance for both scenarios

Architectures that need deferred KASAN should select this option.
Architectures that can enable KASAN early will get compile-time
optimizations instead of runtime checks.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Introduced CONFIG_ARCH_DEFER_KASAN to control static key usage
---
 lib/Kconfig.kasan | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f82889a830f..38456560c85 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -19,6 +19,14 @@ config ARCH_DISABLE_KASAN_INLINE
 	  Disables both inline and stack instrumentation. Selected by
 	  architectures that do not support these instrumentation types.
 
+config ARCH_DEFER_KASAN
+	bool
+	help
+	  Architectures should select this if they need to defer KASAN
+	  initialization until shadow memory is properly set up. This
+	  enables runtime control via static keys. Otherwise, KASAN uses
+	  compile-time constants for better performance.
+
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
-- 
2.34.1


