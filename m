Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B8CC7EE39
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BEyx1UFRvpVo+G4N42POvQdsD1hWzSpAcJ0U0Tlc1dQ=; b=jmWNA6eE8TSSULHOJkQ9Tn6zc/
	5A4X/cdJZeI2ZbFmAT9pKKqtj0sMlbh52G0qPz96h7HEa2CGxauc+UAnkKT8/lP8kqtqlIhHAVOA7
	IEkCu7z1LUhuKwJebeFXWdL9TPdNrVq76eCaFoyBuc3noSDUk8HWkHDAsbTU5WhnUAT69UtAQw6+Z
	vr6jYmmBkft5grTsJllilkrqZ+0nHB2HE7p/NuU65eq4/z3+r0/fFTfkjv2PJRXW5HIvRBtays7De
	1UFd3HgHTsr9iAQH0M172vb4mJACffE8qBdpN3/O5nugi+TyZ2ORYiBTeCX9Bpvcvq6JMoB2pVe6k
	bLLtCD/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOvr-00000008a4m-0TRq;
	Wed, 25 Jun 2025 12:08:51 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMox-00000008D19-1lEr;
	Wed, 25 Jun 2025 09:53:36 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-30f30200b51so78901301fa.3;
        Wed, 25 Jun 2025 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845214; x=1751450014; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEyx1UFRvpVo+G4N42POvQdsD1hWzSpAcJ0U0Tlc1dQ=;
        b=hrc29109YCh6bcWBqgjBaqAaatA9+AN4M8KYe3TrOVQ5cM+ZkoUa/pkb4rajj6ZPp/
         ajUTI7yGmG67TrgYQQ1TUHA5OV1pJCF9RNlfTY/VzHUWZ5U78dK92fImKh1327U/SkTm
         20+i3wjGcgavZ22ILqf4+vKOyOQcVqJPCEQB5B/toijVQUsHeZGdU3dc0yjEve7VhM9g
         sHGqgUYW5lfsvpkXQUQTfovN4SaoI5n8OKHUaN3QKubia918yhwEqOqm/fn59CBAyiOE
         +Ocd6t/z3LPSSe+mIYgFmmLJMzgObxnWV2V3EvmbeWLjMHi9OvpRXqOYe2CetteaqP3k
         k2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845214; x=1751450014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEyx1UFRvpVo+G4N42POvQdsD1hWzSpAcJ0U0Tlc1dQ=;
        b=Ajek66QTld78Bu7mxEzAYKJILlCHo4VoefW5xUVEewMFL/5oHHhQGfi4RjmRuxqP1g
         dmZWIYqQmL55ZGL1gDDKL2V0ozhbnaJ2h6A+YCVjIhVFY+UxHz8Y8delnhNiXXUCWqcG
         XfGd0BnJOMupMPxmz3dMzmMtRTKZ0v9WU9Rt6h5vOHv7I1Ax7n06WAdUKCozZwJpRexm
         dh/uYV4yoDYCJc48eEkAz1NGGj8oQYb4HCHi9CwISfON/jyZG+Kmsi6v6gWNWpv8ee+k
         z/UCEq4hkmEtIXROwwLaC7E/zZRNNQ8U9TIQeFT14TXw3dVA4MKzrL8UOUevkZmwbov9
         YlCw==
X-Forwarded-Encrypted: i=1; AJvYcCV3l/xRsK7dvc7fKVGFjE+exOrkEU8LZroG4DDB6hadBN+b1o1ng+lJnF3Ns96muTOfX8jYriK7cQmVTDlAdoto@lists.infradead.org, AJvYcCWrzKqI556N2RVng9E32/jTcrQG93cc/XmeXrrztEhJfptXCAjtCFMDaF0J5rQdAkpvA8ATYZ3VW6U=@lists.infradead.org
X-Gm-Message-State: AOJu0YxL0Y/2OK/XGQF0N9tK+4WH9TlYw+fmWuhOUVSp4G+wGzx1kkS1
	ab3eu+88Jgx5vcoucsAX08P1JDiW4fsjOXDcYfH3VQ/ofnQOh5tuiKQF
X-Gm-Gg: ASbGncuYZaEb2SlwW7oVw6pr66rWnfzL2zPgxFZB58Ab2P/9mFc2bzAzU+gA65AE0IH
	G4bvDcL6inep9Ts75NcIHoha1Xq12iPzgOWoyz/DALbnw4XdtslSmpEsSNcfkQXJK6WwCreTWFc
	JDMuSuTM7xWwqTUZcESTW2vNePt8nYi6OgxoS2LhkchOC8MtiWW+CDxd8y2NXitC6BXJiAWcsLl
	vJ+exFFnTsByHKCk3DciNsqaEcEZLhacSJKRpSKON5kVhz1dzszz/lS5Kg3FepOApfKJtFnHfag
	VAizJ4/vih8Fl3izLoXIuFjbDYGUlXSaLkBfeZrxdpnYcZqnkVPWV6W7cixR5WOs+Q/CFCT1SH/
	j02Q5h+wDfP6zqKQufOVyFzwrk5DAjw==
X-Google-Smtp-Source: AGHT+IEcjLY1beu9wht7welDNsEE9aAi3GLekIAB8d1qrA4KC0EwxtCdVmkKJY06lTM1Yl9RfqTm0Q==
X-Received: by 2002:a05:651c:514:b0:32b:3c94:992d with SMTP id 38308e7fff4ca-32cc65755dbmr8009981fa.28.1750845213516;
        Wed, 25 Jun 2025 02:53:33 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:33 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 8/9] kasan/s390: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:23 +0500
Message-Id: <20250625095224.118679-9-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025335_458800_7C77DCB2 
X-CRM114-Status: GOOD (  10.82  )
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

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 54cf0923050..da7a13d9ab7 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -65,7 +65,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
-- 
2.34.1


