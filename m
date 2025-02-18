Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E150C021AF
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oFRKePU7thBon8tfL6vskAhYenxo2fl21vHaxPHsJUc=; b=TSzYIaOY3gCepORG99PO5zQe9N
	QFoKWOV4baeuF/jE5TEuivU0DYyC8dLqyro+y8aM91FO3eQd8x6cXt/OAjvcjzeccqCszO2aSBexc
	m7mQYLR99rPjQoy6vo5ccF8ORSoYG08zWnRNqSeMoelzSOnxKe4HLhS212b4WX37g1ctjk9PDouW1
	WnbpHpJQ/QG/2CSCa22ElwVH9sDAkWavtEhUvkFl2drw8PBr9RJNI9+JOWTdQLRNW/hL66aVR6edt
	yH9cyMYyl+v+OZVf9uUZ3OYjZFFjDSI3skKtAr+kbDV7vs0dzlZeg7Bu9DzL1Tv3d6B6yPIOt3xDu
	qdcM2mZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkRsq-00000009G95-268S;
	Tue, 18 Feb 2025 17:59:48 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkRr4-00000009Fpg-0lre;
	Tue, 18 Feb 2025 17:57:59 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-54622e97753so39363e87.0;
        Tue, 18 Feb 2025 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739901476; x=1740506276; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFRKePU7thBon8tfL6vskAhYenxo2fl21vHaxPHsJUc=;
        b=BGNgYY7pP26CWXURMC+Cqj7BXAm1ikH/jwAD/0ALXqLplvAlyReqHJa42l2YPW1XE7
         patIgcm14LET6kJwvcNBpng0/rVBO4SZ+r9vAEQ/QMjqLlhR6ak9biAsw51XjJT5HzvD
         bK1+WOVrNe1nwevNlrdoeIrbX4Q89AJimn6Zg5qFzqk5ZKpCKDvOdIDxVLDKzhlxXDXT
         1gxSqUXJj2mPmabK/CT1qWGLMYiJeUiV2/XC37GYIqod3dO+h1CNGBBTvhqW/kNBClVl
         eXHkUx9gEcexRTjyKvAwSvu9Mx7dG+5sfZE2jQGVzEg8FOJk5vLiTVVcLjR0T4Kvsv2U
         bBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901476; x=1740506276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFRKePU7thBon8tfL6vskAhYenxo2fl21vHaxPHsJUc=;
        b=NR/U2mG5T4+/DfGkZvavSYVvN9TidKJm/cnIMDYmkFBvRNXdiXvvSMBHjSBNUQtC8T
         VCObWfIu+2dVovQUUMMbpWid00cRAelLYhtSoL7WnkiE3zGHRjxke/c/FqksQMKhZNKq
         j5sWx2z/9Y3C3hTqDTxiXYT53PR94TfdXnfkrRHOGNxsqq/PTxuYVNWUzEcOlYYURthf
         WReTFChbBSN5tDo5WRFd10dwivgsBJ+/WclCJ9TfyVF0g9s4sykx2FQ5Rv5LPC1Ms7Dm
         rMkCGgOraHZAlkMxu3x/kuhaz4W5wG8fhNQIUUYheLbI0q0rHNVghOO9FGvIw0PbyH7k
         dMHA==
X-Forwarded-Encrypted: i=1; AJvYcCWGaBS8nrjWdOvptYF6I1F7i2RBiqXjZjS1YWLUj3epLETftO/8m2izY5juzSwReCBJCzbexavs/1XSV8E=@lists.infradead.org, AJvYcCWN7GeOzw7Y6xa2ABTVbwwO+ldpD4tWg/hGVfNN5tMKq1VBFbMohFNkwnQiH4Ozfz0fdfLhoBngAjF04cyRtpax@lists.infradead.org, AJvYcCWw7lHIInpl1SdfeVfjmZ8WgsHIsUDrKP9gJV0xloiERn9QNo0RL6wapjAu4fnvDcgr0JCtIaD2K65ykQHS0to=@lists.infradead.org, AJvYcCXMvTTVrk/8xy+ZpeEqvL4o1IefCjGkdLeJZt/MiQbA0XrLvWNsHPc1xsMylFTMcjgg3qWQFqWQuDQ=@lists.infradead.org
X-Gm-Message-State: AOJu0YxWy+GsXVITHohnnoHI9pjtx27PgI6cZDOW0YF9FQBDuNhy4R5R
	aBDUaHKURPKlcHiEkdmF9F8A8qHWiOXmb4sQIEkt5OGvMxebFxFV
X-Gm-Gg: ASbGnctWvf5zVeOblwmODVdyupOGbtXaO7wY3SHYzP9dkUmGfrHsASNlsnMqzzsz8Xm
	KWeUeo8Lp/1NRYQyjFN3gpNywakmadHqnKDW6wsVgx2MFkLPfUINJyJlA5yTjEa9+PvdoRRLc2I
	gHiMxzQonQr8LvZnLkhZ0V1oth002HbD3739cE4OXkaXcOgqnpRjoBn/g7WfGuaYq0LkaVb5IwH
	6PNbI7HRlolEUb9pxhJRtW0eK1x646YtKc/nTLdVMxh/TWxBGcVtWMDZJDVwtXe33JWMfCe0Yjh
	VPSEc4OucS64kll7wHNvY5uO6A1iAZTtbkDeB9JRshOj+wK4C16few5JJV+2Tg==
X-Google-Smtp-Source: AGHT+IGfFBi/u9SniGtV33nIqkglJaUtkaaAX/KBzbUXSrhxIdAk38ItpiS7x3PdO+hl8rMx2A+8sQ==
X-Received: by 2002:a05:6512:3b23:b0:545:550:83e6 with SMTP id 2adb3069b0e04-5462eaa1f1amr241343e87.5.1739901475583;
        Tue, 18 Feb 2025 09:57:55 -0800 (PST)
Received: from es40.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545254f7072sm1709286e87.127.2025.02.18.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:57:54 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	glaubitz@physik.fu-berlin.de,
	ink@unseen.parts,
	kees@kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: chris@zankel.net,
	dinguyen@kernel.org,
	jcmvbkbc@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	monstr@monstr.eu,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 0/1] mm: pgtable: fix pte_swp_exclusive
Date: Tue, 18 Feb 2025 18:55:13 +0100
Message-ID: <20250218175735.19882-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_095758_220255_6FFE4153 
X-CRM114-Status: UNSURE (   9.43  )
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

The first version of this patch intended to fix issues with swap memory on
alpha, when swapoff fails to writeback exclusive swap pages and gets stuck
in an infinite loop trying to do so. This problem appeared after commit
a172d5128706028ac07b8db709728379ecc72f6e and as far as I know only
affected the alpha architecure.

Changes in v2:
As suggested by Al Viro, rather than doing a bit-shift alpha-only fix this
version of the patch makes pte_swp_exclusive return bool instead of int.
As Al pointed out, this will also better reflect how pte_swp_exclusive
is actually used in the code.

Best regards
Magnus Lindholm linmag7@gmail.com

 arch/alpha/include/asm/pgtable.h             | 2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h    | 2 +-
 arch/arm/include/asm/pgtable.h               | 2 +-
 arch/arm64/include/asm/pgtable.h             | 2 +-
 arch/csky/include/asm/pgtable.h              | 2 +-
 arch/hexagon/include/asm/pgtable.h           | 2 +-
 arch/loongarch/include/asm/pgtable.h         | 2 +-
 arch/m68k/include/asm/mcf_pgtable.h          | 2 +-
 arch/m68k/include/asm/motorola_pgtable.h     | 2 +-
 arch/m68k/include/asm/sun3_pgtable.h         | 2 +-
 arch/microblaze/include/asm/pgtable.h        | 2 +-
 arch/mips/include/asm/pgtable.h              | 4 ++--
 arch/nios2/include/asm/pgtable.h             | 2 +-
 arch/openrisc/include/asm/pgtable.h          | 2 +-
 arch/parisc/include/asm/pgtable.h            | 2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 arch/powerpc/include/asm/nohash/pgtable.h    | 2 +-
 arch/riscv/include/asm/pgtable.h             | 2 +-
 arch/s390/include/asm/pgtable.h              | 2 +-
 arch/sh/include/asm/pgtable_32.h             | 2 +-
 arch/sparc/include/asm/pgtable_32.h          | 2 +-
 arch/sparc/include/asm/pgtable_64.h          | 2 +-
 arch/um/include/asm/pgtable.h                | 2 +-
 arch/x86/include/asm/pgtable.h               | 2 +-
 arch/xtensa/include/asm/pgtable.h            | 2 +-
 26 files changed, 27 insertions(+), 27 deletions(-)

