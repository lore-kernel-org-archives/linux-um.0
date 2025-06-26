Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4259BC83000
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSxJD4SCtsi5mR6YtVjdi0UPNRveg1OSTrY+9IeINk8=; b=EjJTqNXog3GQZqf92hdp80xW/2
	hH9Sa+bRtVrb/fYpADq/QXlW+QPDjNU+vR8lfKLjrLWaNpVyHmJJvgu+z+cJrj2KJ9ipKMKo1kbX0
	tW+HTF2rl81F+NSsOmgg4npZGXmKiuzCd/Do3WyPEK+bXhUnKezFFom+TJzCUPhrToeSz181Tnjmf
	/Y+VzQp9qKD7ZNyqlMxXjziWYBcnTdkEe3/3YN7P6aMeyOhReOi3rViVV+pRmHgT8SIuxzmUjU/EB
	3SDQTLhyetx7/O3VE1w3wzP2A+O+AAa0QUc37b3LFcE/MCdlekoQVjFfWGHQxgXqN9+ye68DbMYaB
	o62RVNRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpLD-0000000CFfz-3zoc;
	Thu, 26 Jun 2025 16:20:47 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUobC-0000000C8Sj-03re;
	Thu, 26 Jun 2025 15:33:15 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-553e5df44f8so1038428e87.3;
        Thu, 26 Jun 2025 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951992; x=1751556792; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSxJD4SCtsi5mR6YtVjdi0UPNRveg1OSTrY+9IeINk8=;
        b=YdKFFK9DQIe+Yo+NeTPwfotWkQ+4Bjfl1zmUk+YYW6j9cbb3GFnMGrnfgVg2u1/WKM
         qa6T/1HUjJ3DBTh6avg4SbhGgWwTJ5VdrQMJ10mqs8hn/0VKSf/NxILgxqA8FKABA7lS
         Oly4wBlaXLjCJNiS/AjiPFh9F36lTiqen/eTpqgh/+MjbMVwxLg8Ms5ReRKKRxc0gJ/7
         8ewEWeCKwUX7SptCDHJft4oYrt9qkQNBMjFkhDUsgFXSDTNPCxDOHif+GoRLJCj06HWe
         l6PezW1MNIBp1hDOKJvoE3B7tdDEJsWgDJGYwiVeH4gPmgTaGvUyggJbg/RxxerXaFPT
         4Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951992; x=1751556792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSxJD4SCtsi5mR6YtVjdi0UPNRveg1OSTrY+9IeINk8=;
        b=ud7igb59Nd7bzXQ464loHPxgt/T92gvfkhrays8hY41nWWmIVs8LYy6mBbaVgDr2vd
         in9V9zuXCbbn93FkLWYU9ss9/0PzkTLmxm6iZ/c+Oa5kTi5EuY5+XxbK0a6LrupCRbao
         UQo9PVAKzmHiS7muNd/ouguO8gip2XMINCLyUPjbi7nb16Mq4QMaMNXgIXeYrdWNM6hu
         LgsnuAfHWWH/EdvEzH+CNu61uYkMSa/DTYd0Utp8fhAjyabc1ijdwl54ceNlMyQWyY2U
         tygWEVpH1GNoxtoutagjZSbCkKeEo84puTyPVeSEvh1tqT8LDxCyQgv/4uxECMqEPhZr
         ydWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcpg86UAFaDt7+jp2X4TDfXXpjVUUI3sqnE04Sh/tVIPnIcCDdvtCo0mXb5MKHZA6zCfPSBN4A0Zp4/9fGNONr@lists.infradead.org, AJvYcCXmdFTo90sbWQp58LUWrLRtTcxW/gowLkQ82Jv/HjonGAxnrB9J8RFWx2YSCg9e1x0elSdPhDNq9tg=@lists.infradead.org, AJvYcCXqNJGjsw1n0/oHh73frY80BDRO+0zi9t3Ht4LNir4Af0kp6tMR4kXR2siH0P4eG0IgUPAIkrWQNFoFsrU=@lists.infradead.org
X-Gm-Message-State: AOJu0YzjZIsVEHvCPKfp5V29Jo6JrrqOThKkxZkBoHwoR3yhs69FtmZU
	DJF45v8nyCxV0l2ZDfDOr08wey1cA/8fFB2QTyLF872kP2+MCislitpa
X-Gm-Gg: ASbGncsRTmJwhNOiIcgye9LhTTZJUfMu4hmSPgz0hM8GezOA3AnmYiMiriQSKhjpLbr
	7A+T+ZYNVpCDmw0BQeTZqn26QGhlfOl4QLKMqoGSY4hQJQfrIggmA+CZdPCDVFfERfXECCSbJUJ
	J/JaVwDx1dBIXsd8EtLD/t/nti/ggUVDiMCHXlIUJl+Nh1RpQEYNszvMUBUf55yb/mcmy+RT2+4
	C+F58R7Oiir0O8WQP6DZuY7lk2GXVMCOc7kei5pLISD0Tg0XwA7mvaenIXaN+yoMjtAlYOO8tTo
	ugS3yftIq+FyTl3/saL67ekfpHr1jEQOcBXugFny1ykhBoZzqcJX/+J4iUqg7hJXkFpfSBL6mAW
	gWfpDJMPjonbynCQo4ymQX3sod1Jx4w==
X-Google-Smtp-Source: AGHT+IFoZkRuIIumANr6hYYRzr1inmKBevr4v8neJa1j+iQaqRjcvodg6bFFAhrpbTZKPBtQIm3EXA==
X-Received: by 2002:a05:6512:15a1:b0:553:2882:d79b with SMTP id 2adb3069b0e04-554fdd1b90dmr3161154e87.32.1750951992214;
        Thu, 26 Jun 2025 08:33:12 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:33:10 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 10/11] kasan/riscv: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:46 +0500
Message-Id: <20250626153147.145312-11-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083314_060937_2E871996 
X-CRM114-Status: UNSURE (   8.20  )
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

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
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


