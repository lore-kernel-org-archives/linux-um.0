Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F3BCD4F20
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 04:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mA8QNkfTPcJhmIVKfWV2EgXocZ+TYN3IbgT82p4dkrQ=; b=glPKo1GPwl1O2NaD+S4v7DZJRv
	k02+0hrWhhpYHh16PMLCsonXyZU5MtplJeaEqFekur3GPLWAGcbEd0iWzMaZP5aQcGrg4VHXCShTA
	rE0Rqkdup+hfMAprhzJbEASzYL6++2mC2SpTPyvr1/rtjGUunjV0Pyinet+9UBZAnwPpuMmc6xtna
	FayApyELMlH1qz9utsJ3/48kuYjHxg8Tbl+4zAFAYJMqx7kQJROman1nGtVkGtltAZX7f3apYIVWg
	wBfUbuXNmVHDVEHx+Hg6Ju4mh5rI+wnKw/6beAAJVLR03xYcXl0rA/05k+ftyJKmGSTdQL2oyz+B8
	N93pv4FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4M6-00000006yTU-3PTy;
	Thu, 05 Sep 2024 04:44:26 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4D0-00000006wwR-2vid
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 04:35:04 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7a966f0ac8aso21829485a.2
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510901; x=1726115701; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA8QNkfTPcJhmIVKfWV2EgXocZ+TYN3IbgT82p4dkrQ=;
        b=Ljv6mz5weMvSLDtUrLp13j3cRfVEqXrIbJI1VIyqP9vbD/sHsuma2ode1Ejm4M6FtX
         8CAXt0/bMkRB3Me8egc0ucvoGY3+TUhVHbODPlkW6IyfMEGZekZ76icg7Mp724vlqrFG
         OPvGzos7Tg2k6yEXU761HbZKLl4FOo43PZdg9KuGayDmEGQfdQTzG6TagXm/eh3Jl7oE
         cA+U5Awz+2nU6Mj7xPSjL77rU1p1727npctYbX5wDtRHjwNXBLUPsOurztpXiERCIU5G
         tOD35d6iCDC9eNDpbhwnOUc2XVK5z/JDQqmvVGwU/bP0lWhQD3kwQISxyb+PSQonizQq
         KIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510901; x=1726115701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA8QNkfTPcJhmIVKfWV2EgXocZ+TYN3IbgT82p4dkrQ=;
        b=II5R3NUpQ4HAzyW6zUn/dr0nALZ2Zlywi3H8LRmN03kVsf/rQu5BuIcOhpU/jlh4Lr
         vl8d0Uvcq7n3JKpNdIHn2ULbiqGtMIQDZrXK/inSQ//27Ju4vzeUHVYYP0IiWVRGoip2
         t9e843E4Bd2lBN7CCnYcT/a+I+ziN906eLMUeQJQRE1GARm/Btxn9AZqakRmnzm2onvP
         afY89dkmUWcaNqo3y9ugstSYQDnWGVo7oDWMKjw6GPvO0JfY1gJ0uIC0qqs57cwdQnD5
         QaLF2ULVdnkn+10+8e4HbAP3Vz6DR3/1/KNnLWXeEaJ/nfHj9lSsulnu3yrFRlD3HGl6
         GOtg==
X-Forwarded-Encrypted: i=1; AJvYcCX3zwbraHuZQ9laijbfVI6DPYCW1r2i7OaQFy4KhWfA8xDYYsC1ttLcGkUpwol6pSADa7ovbbexuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+K0ystQmZkpEMVnBaSUPl0JJMSHtevaE4x4yh3Df/TCaqqXY3
	TBX3iwScou2Pt8o/VUMcrOuwp+/NXosQodvpZbWZxuV0aI4+JLrHSWiTL8Vo6Q==
X-Google-Smtp-Source: AGHT+IFRf1D5vt1QAYst2+47RlHDBe/oTQ0pdJOm5kim3EC+oveF5BzPVYhrOWbWoMHiQ4QFDP6QZA==
X-Received: by 2002:a05:620a:2a08:b0:79d:55ab:3867 with SMTP id af79cd13be357-7a902f29ac7mr2154420785a.46.1725510900949;
        Wed, 04 Sep 2024 21:35:00 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:35:00 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 4/4] x86: enable llvm-cov support
Date: Wed,  4 Sep 2024 23:32:45 -0500
Message-ID: <20240905043245.1389509-5-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_213502_790266_0F3DE0B1 
X-CRM114-Status: UNSURE (   7.52  )
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

Set ARCH_HAS_* options to "y" in kconfig and include section description in
linker script.

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/Kconfig              | 2 ++
 arch/x86/kernel/vmlinux.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2..e0a8f7b42 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,8 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_LLVM_COV		if X86_64
+	select ARCH_HAS_LLVM_COV_PROFILE_ALL	if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6e73403e8..904337722 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -191,6 +191,8 @@ SECTIONS
 
 	BUG_TABLE
 
+	LLVM_COV_DATA
+
 	ORC_UNWIND_TABLE
 
 	. = ALIGN(PAGE_SIZE);
-- 
2.45.2


