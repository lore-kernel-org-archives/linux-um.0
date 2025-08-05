Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8190C87FD1
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=; b=oaeQWXr8zAsLXhM4bKa3APsVrv
	1GURl2vRFRpqH0FFfLxNS1l5Wr915qlxidWMVq+0uLiWhQLQeq4+P1QxukxMUZ20vEjlbkYi+NIUA
	vVtG2n0RSB9/XJ5EY7VBq60W3rjcX/+G0J7PEWN0uuKkukG2IwGH1ostvYdjvsekCtrfY/94zYM/+
	XqDmnEjkowECarVNWgqPQN778oKh8Dm6amicL9+hufw0jYOEGbuI/Rz7nIFDDCA3zPQEE5v+Vsm9C
	xVTAMJZsSEHb/PgS7zi0Xx8tcTFI2iHi9+WdpJ5X27tYhaUaXDpXBkpiKU4MRt5Gif9fhx26RB9vE
	yDpfQczA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkn-0000000DAql-1wST;
	Tue, 05 Aug 2025 15:39:05 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIct-0000000D0cj-2p4h;
	Tue, 05 Aug 2025 14:26:53 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-55b93104888so4472953e87.1;
        Tue, 05 Aug 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404010; x=1755008810; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=V6SKrOtAQK+waWXp22Doi5f0o60aoTCEGxPkyGH5rF87lWE/U2I/V4Hc0MEI+6Oxd5
         VIX4XUeoSjTc4WncYG5JvMa9ZpLP0BYdrfy7kGmfAY8Iy+DwvG5pSxLR6FVFlXprVhdh
         A/S43SLuz0AqqWztrlAfpeYtQkG5M+UpHUIGCDauV65Hb/kBq8fxDHVDRlqdVzIKoClH
         rjxzM4CyxCncibGo/2ybnZR8qvFCBwbvGRo6LO+vx2az6kzkNGxyhRH9RCdDphjbaCgU
         V99HT4auteQ6LONuF4HAlLvSZCGMm8sK7TCzLynkm6MvRoOD19hPsKZO3ahRx0LDgxKU
         Iy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404010; x=1755008810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=gf4hdaQUju7kXd7nNVoObHaBMLAWCJxgDC6a1hNfTKon0msPk2BFltkOSMJhjrSUxV
         HpUtfQoyzFQmWkblZOpal/WlxSipxWfnP/UGtzkmvDIbSIACiuO27a263/BmxTHfsdvG
         ShnBGwEdnwrAL4LJZSQ3VvpsJYtPFWOVJa1kwlwBbRYAu1vcLhjhDSFQrjvIQPk6Pvgo
         CAEddZHt0aA8HIK4AJC5UIjNQQBCB9C5As1YNaeBMZwqm15YaNT7Ih5kuM3lXVPXmcmL
         Gt8n+cTsu03oA0wtnU572Ioa9z1gt67mb3yMzUuh+uKBQVt9Kr024TcdN/QWT8ij6huG
         aDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+UpbZYQNRNz1ZUxqhdvIwoeHWB9hy65lZkX3Hsmhu56vZ9NwI+AeaoRSyjmm9pWz2JP8ux2ljNPC+eg==@lists.infradead.org, AJvYcCXqYvF2SE4kMiq7kO7i6TJ2g4JZFmYJgHu6CCEy4f/PVnQz0tMuR+fNXh6YbahW0fUVlgLCmrl2ejE=@lists.infradead.org
X-Gm-Message-State: AOJu0YyNuN9vCTQRhNGI3U0XGoVJar3y4inbfZXetLd5aValuk2gjZEB
	Oaq8NFzImazkka5LTXOZ1moiB33TF6IFnCRY/4yIv1q6CG+tR+qioDNn
X-Gm-Gg: ASbGncttfkaMO6CVDTaEWPeLqaElrDNZj8UnDm9iGVvOd5VbXlwymuq/I4tuABbcLeP
	KUkS9963UsRfflmGuQjpZwCQUWT6ddJo0j6SdcTItnJUMtMWuoBPZxM+mL0koJitDFE8nDUkLu8
	BDrznzecIPcESnniQ/E8Ta0eRlAWcO/g09tgd5cLvty0eh/CLn5htiVADyghp/w0uEFcAAUa30+
	+XfaSRFhGXRy3mC6Oc5wEMjB5flWyMsumjmUGqmz+DBjZCDoLfUzLgc/cMpHV+iMKA5eYbG+rvy
	HbjTB1oCw9Uq/XXQ0yYPHP9LEe8qSQj2TWP8NfhDbCijv34Qe1SqGcvjN1npcCPAtTLEnsF2U52
	OfcLE7iUsUMAYxL4qrRxvibd4McqrtGkC6trli6xANLQU+55Qz/3Bcb48OBKS95SHXdUfng==
X-Google-Smtp-Source: AGHT+IEuo6xaqIABZcTJ/AY4HFbxdZ3CAT0b3T807lmpaRovzDFMVVkpiUz/KiBR8yrsIvUCLLc9/A==
X-Received: by 2002:a05:6512:3e1d:b0:558:f694:a65e with SMTP id 2adb3069b0e04-55b97b41812mr3194986e87.34.1754404009682;
        Tue, 05 Aug 2025 07:26:49 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:49 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	trishalfonso@google.com,
	davidgow@google.com
Cc: glider@google.com,
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
Subject: [PATCH v4 9/9] kasan/riscv: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:22 +0500
Message-Id: <20250805142622.560992-10-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072651_714731_993DED8A 
X-CRM114-Status: UNSURE (   8.17  )
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since riscv doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/riscv/mm/kasan_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca..ba2709b1eec 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -530,6 +530,7 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
-- 
2.34.1


