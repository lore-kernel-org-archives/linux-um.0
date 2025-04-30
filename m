Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C6C3ABB7
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=; b=kKt2x7xHWCQvagLmG9D/Iz8/69
	vdHSFPtbYoRSUBcx7RgGlW3HG2q9L7lAWKOP7rtUySwtfGVDDVxmYbQzJIooAHoPecLkrA+wox5FV
	oe2dOrHpN7Z3GVrgKI8f3o+ZvZKAx5UhgnVoXcj3jh8sM4lq+jbP4Hvvc12plGFOZGRP+3P2js9Vi
	P5VNaTbWKEFHaXkox2DiblyCJVGGF4PLF/U+G4Lysb1KVE5OvhvcubQIYeapCPK3oZNUXTRY4TD1t
	eQ4BLlMAD1fjHHTfbCMVExG5nbgFd6U2XQJJ84CpA+w59iuIN9hB4jtQxku5DejcRjgtUcvRky5zW
	1UYGTbiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4E-0000000Bfmo-3uPG;
	Wed, 30 Apr 2025 04:29:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z3P-0000000BfWy-22KZ
	for linux-um@bombadil.infradead.org;
	Wed, 30 Apr 2025 04:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=; b=laNTCaSV21Y5WANtyvAiFtxuKL
	LdRypTd489CfU6DvxjCCvtQQ+vRW9GzEiyPZr7BbDPfClXYKe4ReyaHszlIzIYdVo9fSiVNJDr2ip
	hwJT+bcC3dWuISIQMRRtXzMRRF8pEPWTY5gdxzycqQqZwEthMVdI698+7Hc70i7B2LZO2PqLfeOUu
	rqF63KrFQZiiir/whW7rN3PJXO4y2KOIIv6E6lEx+h0v22os5m9dbmrocnWSq7rRgRoRtJy9+GdRU
	bULYCWZJS2D8kXg8AuhcMUbBob81MZKBtkahoxWZzhPcyhQeyAnDOs0CjQzatYnqB3gFnj5B129MI
	5ZUZOOLg==;
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9z3B-0000000DgDP-0nwK
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:28:13 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-af52a624283so527314a12.0
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987277; x=1746592077; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=F8UXLBmpjYKFxkTxf64lnLZYGOO4KXv9VaAh+aXDcmCc2qFzGbFOcS74/OqUPLta6j
         GQwpdc40FRyHimldQN4CscT6WXGpQjOTPr7WsyCYgARmqUNrvH27MnZWr1m2WmEigpEW
         E0ubMaFOQNSW49SG2j5qXbi2AxgH3J2GRrJRJZNswLWU0eGpZ1IStEQo8MMbfm9rIJEO
         XOCB3gJ3OPIYzDo8zLwmeho1MBdR0phQiIX+wEwBQT3qKnf5T1EftCOuiLHRJsFUs2bt
         hVcFCwLv1YV6Y9J7PPSPOrvZeu1wNRugh5Y3vOCVfGFY4CmH9o9XwB+ALQsrtTnALqz0
         KJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987277; x=1746592077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=UPwCwKsdccjMXCyCHKQgYlnkEOEwaneCjjAi2K251GVRQTgcLyxcBiTn9l1f6D99p3
         uc/dW3ihsqC6I7/Hf2+9X1s4LwJzQz2H+g0HIHzoXEXPXKYLWNZi6nSZgyRDR+oMQunh
         aRyWkFy/cbQce01/AuMi58CGyZvS3lKhZ4Zp1boW0SboDFPiGpVSuZDFH+qkVG6IcSy8
         xHQ/jYZ5gaUWruQH0EYCOwzs6MjBfTrzCS117EY5S57yTex+F7glTrYlYcFFSpU5V3CX
         noTfy/PcHhpjuCnIWNT2HHpRHYFhDc/sDYEiFPll3aSLq65TyahzTpWI7IUlW12TZTA/
         DgSg==
X-Gm-Message-State: AOJu0YzKwwFw3X4rLAoADgtGY+sLJMsomiBL1TzdOPYurw+8XlNEr+yf
	/u1ET5st+rkEssSGDBalgxLEO5p2I2o50GAh/Wk/a+PO01PnM6GN
X-Gm-Gg: ASbGncv7b7gwo5L0fm5A+uqZ1jY0kcRFe2bsTN5mNvzXQemRHNshSQBtMsirdA2v/zO
	/fECU1YEKmuIvvOZ29Lu1Ychb0kUvSJPS0Xx5owZDzDAym1igYurYVZyMIqQw8yAJRTTah6WU3u
	D0guRzFx/btC+DIWSnN7rrFgYmLrgfLymwVtcbJT5FEwt7xdA11/JNgbKJdxk+M+ovAyHeXmZA2
	9/6aQsCPMdcsGxm1rBRQnTI6FbRUF2tk2OZFD44MFMy75Y+hK506g3F45RuYawmW1Xsfy2EbWhW
	ciK2P4cH7ZsupQBhCyb6VI3G4S3pGIMpB9qI6sk75Us+1p0rMpTwAz8IazcJRqoyR02gIlpIAUu
	0mCswaD90DhQ=
X-Google-Smtp-Source: AGHT+IECA9Apxbc6D2JhVwEUhYdUmhJiBYci0GxbrvHA3yJvjLnYDlridKGWIXBUNgsmhrFM8ye3SQ==
X-Received: by 2002:a05:6a20:6f0a:b0:1e1:a449:ff71 with SMTP id adf61e73a8af0-20a8e173f9cmr2155932637.1.1745987277300;
        Tue, 29 Apr 2025 21:27:57 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a5bde6sm609398b3a.127.2025.04.29.21.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:56 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 52572E94822; Wed, 30 Apr 2025 13:27:55 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/12] x86/um/vdso: nommu: vdso memory update
Date: Wed, 30 Apr 2025 13:27:14 +0900
Message-ID: <1670b88c2196a5fb2a6eed90c7a8714f03c040a7.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_052805_806152_35CC8408 
X-CRM114-Status: GOOD (  14.52  )
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

On !MMU mode, the address of vdso is accessible from userspace.  This
commit implements the entry point by pointing a block of page address.

This commit also add memory permission configuration of vdso page to be
executable.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/vdso/vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index dc8dfb2abd80..1c8c39f87681 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -21,14 +22,24 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		goto oom;
 
 	copy_page(page_address(um_vdso), vdso_start);
 
+#ifdef CONFIG_MMU
+	um_vdso_addr = task_size - PAGE_SIZE;
+#else
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+#endif
+
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+
 	return 0;
 
 oom:
@@ -39,6 +50,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -63,3 +75,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


