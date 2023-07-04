Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D217C001B0
	for <linux-um@archiver.kernel.org>; Tue,  4 Jul 2023 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=pF6h5eAvYKHAtmM3U9UI4jCL3B1Ftmeh6SFY9ubC6iU=; b=kuT
	g66JZWC+kGu75kf+RTHe8Ju8ea4v3y4ZBo0sGHsXkPaLWt4YMVSmf+J7R8RRWzaom8MVcAibJQtVU
	2Hb/Yk6IK3QoZD6C0vVUPJ0o9MTCieiyZfM24qx8OczG5sGn9eBo3+cuoH/W3+JQx4GVE3Lhla0Io
	rPpHirKigZEHWqPdydLibNa32nBOxACsNafxxDYf09vTwGr+Berrldu99fbyBpgR4Rq+OkuhD1146
	RUz1vtk3ob1jzQRl4QtN94cekLBvZmkEtxlHORiCPOx6kmLiQnpy4u2xJp+rO+3oZwgMCsfRwTtTU
	TaYJwOPUlVyDOPznK9rzuffhcYT6cpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGbQg-00CZXV-12;
	Tue, 04 Jul 2023 08:30:34 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGbQd-00CZVV-0z
	for linux-um@lists.infradead.org;
	Tue, 04 Jul 2023 08:30:32 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704970148dso55099577b3.3
        for <linux-um@lists.infradead.org>; Tue, 04 Jul 2023 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688459428; x=1691051428;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sfzTTTZzhjYlz4coFh9E2qSX1ec2CbvNDkaAXEgpk5k=;
        b=V8Vsb0Zt5QGQio1EPy5IGW2p8TPoQMJ1oVAgaPnqc8Bl2IMATsQZRlbz2u8dDr8cmo
         aHvazQfMuSXmNAxqMbzFrwGkp7MBrxzmuYCrK2BwIoCc5U+Ty43eJVT2pdEMJjDL+ma+
         aGkT6TxH6vX5m9sWMUsU+RZXMaDJV6vqbQBkD0oyV+3N90lgjPTlbBVuOn0nnzGw2Qvl
         oXx07SyWAgK2Jt9JjDwEMAQje137bsU9yzAunIxWnc4o7Cqc+Ml1mROlOJXkEFdIsB6l
         y3z/GPJWMEe5xVO3UZlkoIid/wmLfG7exFCE/PaAAoNH36bzS5cFinGXDw4qlI7NW10j
         rcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459428; x=1691051428;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfzTTTZzhjYlz4coFh9E2qSX1ec2CbvNDkaAXEgpk5k=;
        b=Egcg9nkYwuR49EP7iFLB+wit5XvaKGeHuOaGIe2Ty+rNXf/o2y+fBFptLxVbmXfEm1
         7hW8W447qIL9l6+Gc1LbDSKxR6U33mOMuRuBDLo5dD12WI/t0lJZs/Pvhiz2am1i6iBs
         i9usycQUTBtmw9x+zypfPOJnJK3y3Vxw2UL9bd6O3D6IEklcOQZ13Y5RoMJY8bVJM2oH
         XljGRK0a1VZVft3NVg1I37KP0HRhgzf9x3PZzgtsD5lpqhVcsyl2VJHBDVf8L7rcxfU/
         DW1oKkuhvCP1ppHd8Xc4gaBSauTRcCBngLLRaStFaYSDYCmNrcsp7drU9RKdY1jeK4XK
         XxIQ==
X-Gm-Message-State: ABy/qLaiDFfKKf30IhfvW60+N7+Ypf+MYtW9j4e85G6MIP7xZoFvF/ek
	LmQ6PYJHP0566Q1Ui1LlAu/rRwp9W3AtqA==
X-Google-Smtp-Source: APBJJlGdBVgj65bby9V434H9tf4LMtH0P8VjOntdbYAYDc6gjGY+BtXP400b2TbEy0J1sOLuNq4qDOqdTr44WQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1813:b0:bc5:2869:d735 with SMTP
 id cf19-20020a056902181300b00bc52869d735mr77328ybb.13.1688459428478; Tue, 04
 Jul 2023 01:30:28 -0700 (PDT)
Date: Tue,  4 Jul 2023 16:30:21 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230704083022.692368-1-davidgow@google.com>
Subject: [PATCH 1/2] asm-generic: current: Don't include thread-info.h if
 building asm
From: David Gow <davidgow@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Noah Goldstein <goldstein.w.n@gmail.com>
Cc: linux-um@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_013031_343526_22B72600 
X-CRM114-Status: GOOD (  11.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

asm/current.h is included by some assembly files (either directly, or
indirectly). This works on some architectures (such as x86), as their
implementation of current.h is careful to not include any C, but the
asm-generic version includes linux/thread-info.h unconditionally, which
leads to errors when either C code or non-asm-compatible preprocessor
directives are included.

Just wrap the contents behind an #ifndef __ASSEMBLY__ to avoid any C
code making its way in.

Signed-off-by: David Gow <davidgow@google.com>
---

This is requrired for patch #2 here, as UML uses this asm-generic
header, but works with x86 assembly files which are expecting the x86
current.h, which is assembly-friendly.

---
 include/asm-generic/current.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
index 3a2e224b9fa0..9c2aeecbd05a 100644
--- a/include/asm-generic/current.h
+++ b/include/asm-generic/current.h
@@ -2,9 +2,11 @@
 #ifndef __ASM_GENERIC_CURRENT_H
 #define __ASM_GENERIC_CURRENT_H
 
+#ifndef __ASSEMBLY__
 #include <linux/thread_info.h>
 
 #define get_current() (current_thread_info()->task)
 #define current get_current()
+#endif
 
 #endif /* __ASM_GENERIC_CURRENT_H */
-- 
2.41.0.255.g8b1d071c50-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
