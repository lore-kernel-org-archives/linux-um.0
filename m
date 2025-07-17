Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A21C83F38
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=; b=V65AH4xai4/G/G0m7w+t6E7B2N
	Anl4fXiDKeyLXuTghMz2rhbMQl5N1yN0PNsNgXjXRgeb62w/9RPCzsprEn1hnbtarV1Wv46nqvJ2v
	DfEGO0pku3wKnTyHxCv5XEXjwXN5JC1fiVUGiG5hiWewqJY1fwViTKtnZM90/YIRrzx5XT8aUPxRo
	PCl8KLvT56H5I2s9WKaS9TrKOwCAXuhALjfKz/jChkGL+85T09clKX5+AEJxGpDU0oC7JSs2PpqUQ
	BDeRuUjI7zFeSky4bjIeDAy3BYwTWE2z9N3DnKuSh9dVPLzyK6ZIL0tLstk+Z5pWaVEIaqgRcANjH
	8JDCHIWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ96-0000000ASIA-0dmf;
	Thu, 17 Jul 2025 15:03:40 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPac-0000000AN3g-2WeM;
	Thu, 17 Jul 2025 14:28:03 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-553b5165cf5so1236537e87.0;
        Thu, 17 Jul 2025 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762481; x=1753367281; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=NpiEv7OC4hhwPWAJDvTFbOLAbzm/niKEFx10xs8TO667SzXRCahrf9Gaapg7WPEvrd
         rfTGxJSY801XDwIcWb5aXGtaW47A+D3oRkKJXAFMBkLVW+7YhMozoYwluY3tNoqRivB5
         huOOXg/33eL0YTzMRWhkAOXmMNqwdYzV33vwAlWqmtCRdoWcoym3COGyMzNTgDgMw4UN
         HJ3TGmS64TiL9vKwFC3p500eibPyH6QtpKvXM0pL+isG3AuHcUv0sNKGEn2f5O7F1/vO
         BpnyuCJKVhDw+XBW7a5wsPqfmF6QazEbFM5OgayV3mnqSAgRuPjyyW5iRi3x6bNgPqsd
         s4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762481; x=1753367281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=SisjgT0BXM6Ue44ZM7631Q31Vmutcs9TLvAxTZkmO0RT77nzj2IQ0tLvQxILjL1Rkf
         aqZBwtqTCHWuQ+5LaONVdqHuktEYSl1Pew91JSdty1a9N9Eec+4MshuuwUiARmb6R1F5
         8/ZtziCyi8Y9yseeqtQGgQ4HISgkpfwqFydZP2ke7qHhMw8aZhzvlKSLWXIFkLlo+1oM
         sDTp4wU5PCfy3iyoSIU38JT2+Ao+uNlIWzhN0owT3iK7h8yRg5jB4PUamLnnSr+KDjgJ
         BxDbpafDLcAUloOEw3Pn8ICHycJetufHKvHo9PMCOSMC6lUP7wqXG/i+Du1P9YjeOrCj
         xynw==
X-Forwarded-Encrypted: i=1; AJvYcCWNn7o1EhkZdaso0wZ3/5rK4QMV3wcWZSs5Bgt52PoA7cNxVF+5q6RfzSeWVUENLIskJMnanj1EifM=@lists.infradead.org, AJvYcCWu6nf64Ojb2Cd9esVYnAKDdrpvXE529TtXhb+mN0EOH6u8n/X+IVRsq1YpS5HN19PDsDTD9goqjAU8uw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPnu6YrifHDxLxzAdzgXj0dCav/cBwyL1Gd49RD31/0hZH4uBy
	rWRP9DhxPVnF+dQ6d0YaCDqxqXo7M4rpGZlD16XGzsER4B5j6fSPM33f
X-Gm-Gg: ASbGncstOZ+krD3A8/x+uEN6hyvwxsm6ia/hJlxBESdAOQGyKMnBl/q6rhF8Aywvnq9
	mlYfakfBl13t4x0XEEUiRruq/qRCn6k6tyg34VmKhmNL+JShXFoECGR6gybyPQlD1+P+sf6Jt0d
	A3mb/GR8EKx3WpmX4/zmVvwUsPvk8reI5770WkatVBSKYHrn5HJzqtIgtFbaJP4Tpf9k7ukigB5
	LST1076Nw4ZYVO7V7NiE5MIH8L2uGMVs7Az6WmGJAWiatA3Vfv891ZA1K+rHdD+3+NwVQfjfmla
	s+/HqwaGQAGuF2I+vCFwhHZC41KBy+7S544yKRa4KQ0h6LLbD4Xe9Zt1mXRTANqDTQW86mDSFoj
	CV3OxWCBL3JATZJ6vf/BNjRV15w+PYxlOz+6eYReO6q6axYZEHLENnXOsy4aGj2uKR0ZI
X-Google-Smtp-Source: AGHT+IFLVShq7sQke2+sS90z+vGxECzG8DIPcMIPlB0XqE9wZj6ZkLlHMF4FaDTA86AkwLv8/0lA9Q==
X-Received: by 2002:a05:6512:63c4:10b0:553:ae47:685f with SMTP id 2adb3069b0e04-55a233b1914mr1997025e87.38.1752762480616;
        Thu, 17 Jul 2025 07:28:00 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:59 -0700 (PDT)
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
Subject: [PATCH v3 06/12] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:26 +0500
Message-Id: <20250717142732.292822-7-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072802_636965_E24C1AF4 
X-CRM114-Status: GOOD (  10.13  )
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since xtensa doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op.

Note that arch/xtensa still uses "current" instead of "init_task" pointer
in `current->kasan_depth = 0;` to enable error messages. This is left
unchanged as it cannot be tested.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/xtensa/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173..0524b9ed5e6 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -94,5 +94,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1


