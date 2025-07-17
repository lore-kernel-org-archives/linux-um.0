Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA3C83F1A
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=; b=hP6Q7PcgkBzlPLG8hkrXXp4dcm
	it3w825F12mYrlPPYDBIeB/ZlTpxUz2Rl/+AKwcNb8ggPtD80Bgq2leUBA5ZOy4jH2ZOEpwlKTL00
	jct0qQLqPeYsdCsc5ibVu2AXvCbhOLnfuIOzqOQa6y9pGwkQpj39MZ995VBkGW6PA9jHued9T5jhG
	T+svzXM4+79YFhQ61293Lyo0ekmUY86X8kOxRiidHaZRqZ5I5GPjlPi83TCnvk2fJK1YYbk8Wcw48
	lDBUGLfGH3Rg/fVsbXvTBUj30hH2tmVqlFygBUg14NGy4jmIpyFsWWpLw0CGBgi4oLyR3BZwvzPQC
	uGabDmBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ9H-0000000ASUm-1GH5;
	Thu, 17 Jul 2025 15:03:51 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPas-0000000ANCC-1o6U;
	Thu, 17 Jul 2025 14:28:19 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5561d41fc96so1209287e87.1;
        Thu, 17 Jul 2025 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762497; x=1753367297; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=mRo/wFqxb5zhB9ln6K7oQ9TszvbktTtEVP6HvwjbyKuolqm8MyREPd6r3MnF/tL7da
         ub8vdew090p9aDY+ct+VrrxywW+N/extat8OdvxbAsrodOoCcjGVoI+uDybN5KUVcKTP
         4qJfLDr84dyHflJNN1BXxNzaVV8SSBuEQQU+hNPwTHPdLW9T5tpUwQeMEYdaLCtXn/ii
         XkckmXowW6BSC7YRJhhR8kFlUHw1915NGiwFyRFrF0TUYcJCwRtFc9OFJBvHWAsUkfDb
         amDXSRwQmtKCA1Kn/k/5ZhycyHSTTwjLW88qja4xqriyPap3gCmd7lLz/JAeocZg6bug
         1RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762497; x=1753367297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=SnFmOfzzYkgoy5csr/C5v8YohRUFOcrLqp5rgi4znonRah/2aZoO6i/xL0ElKaNOVz
         4EyXrwnGDobBVkVi9SgEqet0jHM5wmCqt5mJRjG+oeefd64PqYZTSFv6UHaEPByOilVC
         xdBwZlMBtDtVoQhho6L8hvsS48m3vUcQX+CzJ2pNipvrB12fcK6WdJ9cdeBYml7o15Og
         HO7iqIpcXS3bc1VcpnHr0thZGEwGa5ZzrzZUoc6WPkbiOpR1kZgITL4pcQOU+qdPa1Cx
         VkZSLAay3/7IvQKCDBgaQ4v7I09z/1QHAGmrbVJdYBE5KpkT/6wOgktbxqFsFjUnF/72
         MhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVai6rad95Mgl3SJtM0gNdQcPn2Mwe1JD+spb/tN2A6JqWUu0LdBOjxc0R9oGbBxfOjRY8cRTUg5Bz41g==@lists.infradead.org, AJvYcCW2+tPAVNU4lN2OzsFnPtYg5DXMhBNLOq4ea/HWXZFGBSlVsE0hhZaaHQrulXpJF4tmjMkO0TXmM/w=@lists.infradead.org
X-Gm-Message-State: AOJu0YyUUNz75gwPE6yN/trO5lwC95noMu3/lEaHl4iaX4MuFz/FsCrk
	QXImnvzQB9WBpZB6Zzhi3MUtqpd/EI1hlhyU2Ouez6MEJ5lPuLDgAkb/
X-Gm-Gg: ASbGncv0ToQATEw1N4ol0dl93q3OHKRycyQrrT7olp5goeSDXIWbNinsPbITfnLKhlJ
	tHH2v9GDXV/+LNaIj5Wlhhi5Q3rXM1UU5OvxdhV6QnJKhe3uEx3kbcX0lOW1Zr1kEPjA4q84J9H
	R/BVLQ6PnBSzqEiQxgqjqDnpYVSkMKWl9Kofpq+vrKP3RBxy90JopkDIkkCNRDHfknz1YkKUUet
	PvrJBuQKUAu9Z40V7OE6Frpobdplib4ibG6lI10YE7icce510cHWCVzXGAF3sdD8EdifwpMouoY
	TMeLacuM7DU51OGUgF5SzjtPsyomHk7Nw8rhKT1jtaiatFqCsdhdtA0psViPzgQbgHMDjEx0/LY
	Lx30jQktBJ1LP79Dz0mcMoLZS3hibmDx4cHLOq6t/wcNhPz8BP4KfH4Fgv6gBR+Xz8u89
X-Google-Smtp-Source: AGHT+IEO/8eHWJm582VzmdIOAIhCMVFXDa+uycN9FWVanpBus9xWQw/+gRsCzypPbNm9nuGJ8ZjzCw==
X-Received: by 2002:a05:6512:33ca:b0:553:37e7:867c with SMTP id 2adb3069b0e04-55a23fb26f9mr2259542e87.50.1752762496407;
        Thu, 17 Jul 2025 07:28:16 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:15 -0700 (PDT)
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
Subject: [PATCH v3 11/12] kasan/riscv: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:31 +0500
Message-Id: <20250717142732.292822-12-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072818_479448_91157951 
X-CRM114-Status: UNSURE (   7.37  )
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


