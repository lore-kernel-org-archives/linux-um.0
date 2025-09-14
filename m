Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89A2CAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=; b=Ibnm9cgIpB953jSYi6r8jIxWP2
	JCzIpvKx1cNJHGRQa01bKfuuEN1Xq2f8fCEdgNMSpNOvHlcjXhpOYo5tUR+MO45Kb01CyCd+zQcd7
	0c9ChxB0ftL+137PeDhGH2tCCrgCfnLOxb8QD+WaEIeZpLcfMnnvBKqEBFM3AAkHygR86/6mZLDSw
	HnavYE7fSaG8rjLgSXP5YK3032Fqx+88vSnyHyC9NCd+oiv2I5ijnI+YsoZaFoCJGCTBLYnLhPvhQ
	/YWZcfB3EFPCJ2kUWi7+gwhD6eB80Kcp05xChE5OSpKYZyp94XGHG9QWqFmIAij1gnqqsESIf+SUb
	/3mUO5+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdqv-0000000HOCc-1gAr;
	Sun, 14 Sep 2025 03:56:37 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdqs-0000000HOAm-2YY9
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:56:35 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso1757490a12.1
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822193; x=1758426993; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=;
        b=UJqP8DKqOnRMWT2d4Q2KZGf0YyveGfFxnWnN7P+EWzLklMfXVk6/J3YwaSeKrHL5iX
         EDG5yXZ898QwC+rnNRBjvyGRqyXm6VpnORwMde2Z7XhLBlYYfURXiOwtVuF2CnPKosDO
         +vj19VcE9KU42VAbBLMNPtqr3GUEmz+dNu+37NesSJC1nqrkY+35+Q1X0MZMYthMehMt
         Grk6fFinB8nbdhEXMVWZC+z9kSmJsh86wG+PGPCvfwY0rdyAjLPE2l27axB2lLEFZyo+
         SjH4eK+1TYg32+ENdaH0sSkiZEYzMctomSSBfrwv6JP0dA6SUZpA5m2hY9H1vkgBDgb+
         LUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822193; x=1758426993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=;
        b=B6ZlvF1SL3iyNBGmnoPmGWt9d62Gw76GfiwFzrOur0Su6TSvTpY1y92tOcX0XG4MHD
         RpoFuyJtL8BcOUUN61WVladmVLfyrkp1s0IghcOaGBEOYk7HNEtbtTbYVUPU7QAWXHZg
         iYXcZVnXyT5eM0yuvr65VhdNR5NgabXu6flheAe4b5DulU7iBzKB/fcDSpPMy0W0RTNg
         UC/wcduUcAQrZOvr9MW+hcTmZUaK5ka6qdwNSllbnbjp7G+2G6iF3qB+bhXLDz5vf2/x
         2QGaSVJiEmWmRCpnNzlbFhhfkNw5v+FAkYUZiiaibAJoXsgd0lKcx/tE/zgBFRGQlYXX
         Vwmg==
X-Forwarded-Encrypted: i=1; AJvYcCUoKo2i2IEMdLsjmElAsC8hKbJCr1U3B+FZz5MER/8fA5dazxz2AqWpxZDDKz4g2Y7BvDxdgUv29w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyA/tD0WGFHOc6LTE8GGUeDP6hUBDlmfBO3HZdrnAjdvbnM8df5
	VqWhjxk3BHjkhjs1y8DoKpBTqmr0MPygtPtIvTIlHOFmnXB6zWkI6PZZ
X-Gm-Gg: ASbGncvhA30DPdHi//wujwvFVQUSNZxC+Jk3e6XX8M1bsnKbpYrVFAmPKnb+NF4gyjk
	GwHRA8iPZrJYVbFKK3X3IOeO4klGBpONCb8gQyqfHwkJXIyWaRqnkzdGSso4OqlbYvPhNbhYjJl
	g5d9aV4BbevsYXAlkUdk8xOm+amcx+2asEviGzgXHbROzm+h0RC3xf/M6TMN4pABSkLo4sNPJxw
	G3ynJrTzCQ4R7siw5zky8fJdzKwzkNTyR4qp9l+2Hu1umXbyOvuU+pWlGgrcyQgh62gYo/fNWwY
	2kD/JNoYpdbYyzkkn9uzXJQIfAv5SNENrok5Q7C+a+6sE3CgVJ6mcUPWtrw6eB9ALqXrRL6hkXH
	SPropLdQMVs/N4FwnOJE=
X-Google-Smtp-Source: AGHT+IEh42ac6WqH282xp0DieWYXKfg+ycti4urbWWAb1GXqLLNoKNDdAlfHKjc5T4lrTIZzL6YLwA==
X-Received: by 2002:a05:6402:2815:b0:61c:e1d6:6bf6 with SMTP id 4fb4d7f45d1cf-62ed80fd3fdmr8226990a12.7.1757822192729;
        Sat, 13 Sep 2025 20:56:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm6510443a12.18.2025.09.13.20.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:56:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 48/62] init: fix comment
Date: Sun, 14 Sep 2025 06:56:26 +0300
Message-ID: <20250914035626.3718268-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205634_659905_CE65047C 
X-CRM114-Status: GOOD (  11.31  )
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

Make #endif match #ifdef

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index cf19b7c0c358..30e94ebf4902 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -717,7 +717,7 @@ static inline bool kexec_free_initrd(void)
 {
 	return false;
 }
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_CRASH_RESERVE */
 
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
-- 
2.47.2


