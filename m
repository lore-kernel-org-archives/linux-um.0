Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E969AC982D2
	for <linux-um@archiver.kernel.org>; Fri, 18 Sep 2026 03:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Et5Apl87bd7FEQsrX3qveqLki9XrUVLSHeowq2WvHY=; b=fA4MNYTV2qqZV28Dy6l0aOF7t+
	bxZtQtps42KQFctookU56K4UaATzeWAdfyYJ1WCyKxVp4fnww32CzOvS0/WpEfjHgsa+tBAw01JB3
	OV1HQ6Bs9Z24wLCMtaT9Hcl1OO5KlGWOJ9QHBBD6bbawsnUGb4kqIC7fsUPs2Tzdefqkf0nAtNsCN
	twiCld+989tLRp+owyZngg+sUv+aDKVzXh/G3tt+MMS7qHQZSHBsu7pHq8t88H1AdJVnc3sEiXi6N
	HPwlp69kSsrkT+7icmvi/NnPl7Qkw3F8Fqu3yRlK8ZvDPyT3465RkKkjDhK1Q6R0zLRGUzBX8jkbP
	1znD9gMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7P78-0000000DNWH-2iHD;
	Fri, 18 Sep 2026 03:18:14 +0000
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7P75-0000000DNVm-1JVV
	for linux-um@lists.infradead.org;
	Fri, 18 Sep 2026 03:18:12 +0000
Received: by mail-pj2-x0a.google.com with SMTP id d9443c01a7336-2cf5e516e67so1633835ad.1
        for <linux-um@lists.infradead.org>; Thu, 17 Sep 2026 20:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789701490; x=1790306290; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Et5Apl87bd7FEQsrX3qveqLki9XrUVLSHeowq2WvHY=;
        b=AKDVB5+drXyBBK+0bqJUZGDQEfm5cX3aWP1/g9LEmRt4W8GqII1qMR0eAklv2QQg/t
         pAeK5ByqRcVlSI5QUrRgPArl9wD8UaRCe01VoS9QzSgqSKFLwLVdmSLI9vV4lpK4qEO7
         AQdHHVdXxxQetsMkj41YcWXLpdVTDxRmRCQpt2kTFNA2yeelFdmFyjX2c8TaW3zlCkPy
         HitAwmRkkNbS4nTIzITfgfQvEjcx3xDxZ6lhucMaNg2dtGctC4ZxTwfTdHUo2ks8jxgd
         dIRnRG48AwyLN4DZPD88R2y6tIdHe+RWOlIaA7d5Ap00LaX3j+0wwh4z5KD/SrjcT2to
         ZZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789701490; x=1790306290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Et5Apl87bd7FEQsrX3qveqLki9XrUVLSHeowq2WvHY=;
        b=IHOvlhebZSqPdN8K4KywjhIfRhambsMeV23Ssr7kJ9ODelsEKnvVe0OvXPjJxHMjOs
         4d37WIKgAYsEBG5Md4oufPULllmlwLC+t3Xz/1D2NXn/m5swku94GXpywsgUwdK3sJyQ
         qCYnF1eaqxj8h3tv65awCJHreIl86SMSOx884nvmUaCM2Hy9Dqs9eM6pbu13uK08n2x7
         5Y9C+ZYreSiNK3zO6ESdjLlg6c3Z3FQ3Tu16jqeSBC742Zr9o1jj8abI3DKCeAkYAcnA
         8cuNZsGYMrTUM290epTEO7dCRxL+1Ay2EqLUpKgynapO3JX/sME7RJUSxZ9IecITfYRG
         vuDw==
X-Forwarded-Encrypted: i=1; AKwUvBxZdbAz5azOJyjriUfAIqCEaoCxmfy+egHNwbjHDLYM7/MHak20NGDOOtPYqOoZJofDsl7rmyaU3g==@lists.infradead.org
X-Gm-Message-State: AFuF++mz1QsBuLNHJU+IAbpZu+rG2Sny3Eo5XZxBAHe3pGLbtuUAj4Lm
	Cg5OZcNK3Yq5jJ3zPIe/NUg7DKeVMuvUcXT3wUecv9HQm0bxhd3lPp9c
X-Gm-Gg: AYBFou1E3C1Z/BQbQOqJjM6LsTvGVehaA2j2VxynR3N3gzL0oCCJY6mhpyj73c+hgTZ
	x/KQVfyXZoSrR5CRDGz0Kpzwantft2TOVww603Isj65LPVlssGiMBfVdubS+iEcez5YCKGGlHDG
	1wZdLJ1cSsTbezb/mJRk7IH0enKuGlED3MrPToGqOtbAH0EBco3qPjYoOK3aQR7QlfDUjPyW1kT
	Uf0X0QOW+RJFb6CLrBxNRv31KViZ3oHpFRUvr7iuBsHq9Cjok/gLtCXAR9cUIxnl3gsRe+T5JqP
	4WINchR7ZN+mWucV6b16sXOcX8OkaS1GiG08gk9EMNAtffItcyPWlc59Es/zzbbFLt7wf2WvKuB
	tHnyFeB7x9Mjn/SjMa+SHuc7AZGYr3/yqHni8f+1/+5vHSzvZ2rfGCgCuMa3H0lycb7Mxv8U5o7
	9PbugqE7oWIAgiWGuijs9Ci20YbWLucl/wInySCucCn2qMOpzey3FrE9BXZF4PEicKd8d3ay0Sr
	dMeBpzjhxB9JkZgPZSwJylRID1M+EuBBv0I2lgucFie9ZTkitdYV/pCmGBqghcpyLAqYZqxWK2J
	0x3V/bfu90JZbC8drlnOTFD7rNV1M8F0CXeQ47Th+hMg7z6ZE4Dilq5zl65SFq5L7Q==
X-Received: by 2002:a05:6a20:b78a:b0:3d3:ae40:51e8 with SMTP id adf61e73a8af0-3dd8c575882mr2359443637.28.1789701490373;
        Thu, 17 Sep 2026 20:18:10 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c286d8633sm451318eec.7.2026.09.17.20.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:18:10 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-um@lists.infradead.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: [PATCH] x86/um: remove unused <asm/required-features.h> header
Date: Thu, 17 Sep 2026 20:18:01 -0700
Message-ID: <20260918031807.449816-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_201811_372916_B0883A7E 
X-CRM114-Status: UNSURE (   8.03  )
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

arch/x86/um/asm/required-features.h only existed to satisfy
dependencies on the non-UML x86 header of the same name, which was
removed in commit 8f97566c8a81 ("x86/cpufeatures: Remove
{disabled,required}-features.h"). Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/x86/um/asm/required-features.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/x86/um/asm/required-features.h

diff --git a/arch/x86/um/asm/required-features.h b/arch/x86/um/asm/required-features.h
deleted file mode 100644
index dfb967b2d2f3..000000000000
--- a/arch/x86/um/asm/required-features.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __UM_REQUIRED_FEATURES_H
-#define __UM_REQUIRED_FEATURES_H
-
-/*
- * Nothing to see, just need something for the i386 and x86_64 asm
- * headers to include.
- */
-
-#endif
-- 
2.43.0


