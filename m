Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9673C83F38
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bku05+DNIlaPeHqRJ4y/c3E9v08tlUqoZ6kZCd1AC2c=; b=GHsllwF5m3vW+IiCayZvRnu73b
	1Yq2uziD8Cb8nWcMrKSR2fzR3Aw4CP1zb6FfZijAYAQu3T7/0mrTi1eCFHG44IrYUdwxOT8RaBiLW
	nieAFioJ+UqywzLrIH2xM5xe+TnE3pFhr8qdfV3CnbvmqamLtmYc6sQTw54Vcb9vREOj2uXWqEqZj
	WohZ29jZWfqca+qEaRAxVlWHDSVllu7K1GOLKkf1q4RuYGBe0wTYtllL6g+ClaGU5cHT6BUPwwYQP
	p+baBQVTJrFjTfF9tFnlYAl9Y3sqcQNFqKSWQglzmz6hTRUnmqf/8WdQUh+tie7Wk8bbW0nMd8WhZ
	0bXGuWNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ91-0000000ASBj-1qhR;
	Thu, 17 Jul 2025 15:03:35 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaV-0000000AN0E-409T;
	Thu, 17 Jul 2025 14:27:57 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-556373661aaso938884e87.2;
        Thu, 17 Jul 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762474; x=1753367274; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bku05+DNIlaPeHqRJ4y/c3E9v08tlUqoZ6kZCd1AC2c=;
        b=ejIHBXfKiwonpZMaPsa4qsv9ogivlcd3l9PjQBbSs3ttGKALNoiF8q7OaC3YyYACAY
         0JY62mGxUs9hajZvRuZRcsq6T699flbboasl4nr+yhVQ4KAIm40umP/HIpQcUmG8e/us
         ebxRwlNsnme3jM637VJPZm5ATeflmmrMv4nkcerLh/3a9M2q2zPhg76p+TppoOfSORFw
         CXLJ57gUCYynsNTji2zIW7xwYTfQ4jSKBQu/AOs8G26JNHwZTpejXId0XX802hVa1GxZ
         UfQwgf5yrc0eEspq89l39vjRgFu0RPZy1lScVyKuEufyeLm4oNB8mFVG1/1iks9EWETL
         jvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762474; x=1753367274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bku05+DNIlaPeHqRJ4y/c3E9v08tlUqoZ6kZCd1AC2c=;
        b=GcvBRJ5aNyt5qPmROVqkpMgbOVUdwVu8Mlk27MX3OW9cwFZc0p3Y16j8Odsv3DzZ20
         HivTA0XPJWnssF3EacPgAUvoctMzrQGax2ap/EKKACcFrqHZXMsfe/hm6GmgVSoj/T2J
         aBLhcw9W1eW5g9pyajxaYsPJj4AW1rL5K77RcGEsmiAhAg9wUf4gmUCWZYV/LKXmiWsd
         veVyWgjTrBPFE7p4uvtJPzfe/2Lzimx7b186ZK2TvGZ4fuoJNPlB3UvLh7fc9ig0S1N0
         y94xvFdobqQuX/pRKY8PnspCVeGCh6pcOlwy/66PyaBs2KpGwwagIgEktOxjfkCSXwtT
         h7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF5K9LgmxIh9rp44DU0iDXzPJ54XoKCNHKjJjxlK+DXeeVwrdrMG0dOkLwp3i9IKhbTdCiAONa/Yzlzg==@lists.infradead.org, AJvYcCUQSR6tbmEkRaPDbyU2hQ/eOmP6ktYy9rioHDiHZ62lMldYOpxsSqVarYAtAOsgjq9Ki3n0kDZiZ+c=@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1488O/R7PlDdeUkfq0L6yDnD97WTWu8PnwfG4V4pqOumrwosp
	rA8iA0czlr2BaZhUKX1zg9lTiAbx4IZzoQdaFxWLP+LHLMZP3pOJ9Kll
X-Gm-Gg: ASbGnctmCdDG6uku+y/T6fqzpS8/NGBdoijT7ygV88k8i7UiVH0xz1blYhxjwi1iDzv
	H3PBCLk42CzF+7AtJ3JWxcJmqy+F9EIGwVDOUlGugvN5KxLFblUzT20fAfwSyVxtF/XV4ydoQW7
	sC9Qn79iLOVQjyo+XFdj60YlW2JdLqFpKThAoSEljGKxUkMrm3ATau5Sf2AnLxR+0AuCZNdi43I
	rAc+Xo7fKwCHhw9qlYUs/GmsxbiVnwV0NIFa0KR/2E/xpd7jGz3/7kOfbTf/5iO6b/3aXNSE0po
	xc/xTwJaUlz9L7HO9X6wad9k2Vsw3q67y9eG9hyjJPeZZKxeFN04a3Mm2sDPUQfvpgNajGiWH1O
	jZCvsUm6Ky7TVNUKmpBs2NFrMe/E4e02YJ2JXhEbD9S8urADHjtCc4syHRVGq/IECSNhPrYnZdl
	4X20g=
X-Google-Smtp-Source: AGHT+IG3RRCZYJkrl0IFxNTcXHaC63cFJOMHtvbXLWcJf3SefCDeVNa3EwWa0HZJEZD2h7TP1+bY7g==
X-Received: by 2002:a05:6512:1452:20b0:553:af30:1e8b with SMTP id 2adb3069b0e04-55a233affa7mr1874039e87.38.1752762473999;
        Thu, 17 Jul 2025 07:27:53 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:53 -0700 (PDT)
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
Subject: [PATCH v3 04/12] kasan/arm64: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:24 +0500
Message-Id: <20250717142732.292822-5-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072756_000901_91570CE3 
X-CRM114-Status: UNSURE (   9.34  )
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

Call kasan_init_generic() which handles Generic KASAN initialization.
Since arm64 doesn't select ARCH_DEFER_KASAN, this will be a no-op for
the runtime flag but will print the initialization banner.

For SW_TAGS and HW_TAGS modes, their respective init functions will
handle the flag enabling.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm64/mm/kasan_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45dae..abeb81bf6eb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -399,14 +399,12 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
-#if defined(CONFIG_KASAN_GENERIC)
+	kasan_init_generic();
 	/*
 	 * Generic KASAN is now fully initialized.
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
-	pr_info("KernelAddressSanitizer initialized (generic)\n");
-#endif
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-- 
2.34.1


