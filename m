Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF37C36008
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3DXr60kPcHkddAhJfp9MCcqTGpCcxatqv7lUBWSRFhw=; b=h9J16chiQa8BsQsgGTZwe92p3U
	oS0RHWZ/B42nkMFtJIut/EFmtm2WHzYwU8wxpldlTzD5a9mO00UtEukdSeeu1L7gZPosJzcGSNRZh
	B4YVVWB+4nt79PSJvzx4Z0Pz59N5uQUPG4ojFxKnk2eelYT0RN/Mf0ertp1iR9yfY4rl6BvqHoHNU
	wx8L7d3mvOZTFW81qKTeOHvpyYFk9oZGTUDEoAQXKTZs9l0kTIN5bklO1/krHxk23JiRo4TKf8Qm9
	/MBOvkKftmMtE2/CY8dsrB5++JlbXgGddCRhcIs87geU/kgTj77MXLsDNV5YgWsJ4Gc1EhzITqMx6
	WUNj3TEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txW3v-00000009PPi-2zti;
	Wed, 26 Mar 2025 19:05:15 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txW3t-00000009PPK-2o7r
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 19:05:15 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-223f3357064so3226075ad.3
        for <linux-um@lists.infradead.org>; Wed, 26 Mar 2025 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743015912; x=1743620712; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DXr60kPcHkddAhJfp9MCcqTGpCcxatqv7lUBWSRFhw=;
        b=SLQVLUzZn+Oe1F99MSCe3ND+5m001wfu8YK0Pj1EH3u2qC1rySvN0gpK308JU30cFu
         AzyXCKH2RYuvK6bhXtdDmWwh00Zcsi7ZBRL9lfDR3N8vWCE2b6nJtZFw1WijQqdHG1p0
         u9K1j7Dy3MfPFC/qL2mXvZm5fCAjYStf7KOY7xEkcCebGPPO0ti6K2lHZezUXuEGAFdN
         Nd1KXGX2L130unSKQ+9Yne+cMQXIIQwoI/9CA0cRXOsX4WwRxCB56FxVb2ihgqBPLjsj
         zd55QQu3C2nPh+m21RpaNR8NQILAaiEdB2F917yTcKqTRW63/NwWp+aFBPSN5VffyIpK
         dy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015912; x=1743620712;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DXr60kPcHkddAhJfp9MCcqTGpCcxatqv7lUBWSRFhw=;
        b=rn4uXbasE5gKbkTqqcLDaDZMGpBdvFdyY3Gm+nIMLsTU89Af0ii13sjGmNJW3umIfQ
         tJbWxcAMzGGuClJVdNGITQzKmClJRLl+levfjbXrNkRBfN14ie+BJzVvk0tAXK81hCPd
         OBwVrLVlwdFVec+S/PMbYN24B0Zm1HzaFyn1clqT9VhIoYL6FRpU5/EKUPzaET8b2qYN
         v7L8Sd6CnrAtIBNwGP6+7lfSHHzzlJC4wN/FMzrxwXLhFLrwiMFsoKWq9p9RpfK515V3
         gDbff7tqI15NzdQBZ9qjjn4W/VGXJ5dQeiXsnk2b0aYXrfnlBitKzVQgxNyPYb9ppT0O
         9JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTr4puNxoEtVZG/a3khRl4OqITAPz/JSVYEsoWx1t8rUrjsX6uZFE7pejwML7URFjPWpdwxp15hg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXZc8dCaeiOFRIiIddgpj0MjPUnN38xVxx/wGebRjfyKTA/R/3
	xYRJY5Yy93ql7F0TyivH9etuXb7jgLR/rfLYMswo/nzZotuOaGPYEv+44ohN3Z3oH/FjP1dIh6A
	9UM5uVugOD7brKwcBMaTMSRSQWg==
X-Google-Smtp-Source: AGHT+IF04rFI7uoAifaalhzOSSMCwcat9J+XcqeRT6msx0P5SIjYgnCWtRVcBKSFkGMVYS8CI98R5W6v50aBUub08xQ=
X-Received: from plhd14.prod.google.com ([2002:a17:903:230e:b0:223:69a1:46da])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccc6:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22804858ff9mr9113005ad.20.1743015912058;
 Wed, 26 Mar 2025 12:05:12 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:05:00 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=samitolvanen@google.com;
 h=from:subject; bh=tLUm45R8/GPZ/LUcfff6E8CHOJ0CuOLBzUUipjlMJAY=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOlP/O/IKn8+7H5115bELZkCkUxvroZFGsZH6D392Pigj
 6nxCnNrRykLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZhI6T2Gf6bWwgGGQoqz3T1n
 X1cVXyhwJbdZ4YDGl439ErNr6y9GxTL802hf4cX61CJ8vZZn2AbeltWvuxe6Wvdd5i5fpH1E7uo MJgA=
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326190500.847236-2-samitolvanen@google.com>
Subject: [PATCH] um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h
From: Sami Tolvanen <samitolvanen@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, kernel test robot <lkp@intel.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_120513_711683_87B68257 
X-CRM114-Status: UNSURE (   9.30  )
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

With CONFIG_GENDWARFKSYMS, um builds fail due to missing prototypes
in asm/asm-prototypes.h. Add declarations for cmpxchg8b_emu and the
exported checksum functions, including csum_partial_copy_generic as
it's also exported.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503251216.lE4t9Ikj-lkp@intel.com/
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/um/include/asm/asm-prototypes.h | 5 +++++
 arch/x86/um/asm/checksum.h           | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/include/asm/asm-prototypes.h b/arch/um/include/asm/asm-prototypes.h
index 5898a26daa0d..408b31d59127 100644
--- a/arch/um/include/asm/asm-prototypes.h
+++ b/arch/um/include/asm/asm-prototypes.h
@@ -1 +1,6 @@
 #include <asm-generic/asm-prototypes.h>
+#include <asm/checksum.h>
+
+#ifdef CONFIG_UML_X86
+extern void cmpxchg8b_emu(void);
+#endif
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index b07824500363..ddc144657efa 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -20,6 +20,9 @@
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
+/* Do not call this directly. Declared for export type visibility. */
+extern __visible __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+
 /**
  * csum_fold - Fold and invert a 32bit checksum.
  * sum: 32bit unfolded sum

base-commit: f6e0150b2003fb2b9265028a618aa1732b3edc8f
-- 
2.49.0.395.g12beb8f557-goog


