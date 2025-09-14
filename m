Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D39CAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U0YiDU4Bzw7IKNW2/fgCfvKW6iRx1DQ4l7Ssn455PQA=; b=sBTIuKivi8tNuxP5hLorAAWxfu
	11pBLfaOivQh+I/sUuDaL98McFUD8AhIVx/m6nrPOPWPNLhd/SSIsIObO9u/YVzhnRaV0E7OxFSpC
	zallBcn/4SNw6l9+ZWOs1o1spNSfAh08oYqA58O947xG99oaZctfrmydUAZLa68bFPPZSojD5d4me
	q3rKwS3ZhgM/DbJcKJfsQK/FWbRNL+YsjQj6qVIDFobEOEta0Mp90+Gdd+JEtVU5xRN+HFs/fmfvQ
	GZviJAWmyk4Ni28+enWTuyEuYnrloIGAK7A8DditRdr5gBpNgmEZxA2QX6oWthdZ5Iv35g+r/VCoP
	NwIw1eWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdob-0000000HN5e-0ref;
	Sun, 14 Sep 2025 03:54:13 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdoY-0000000HN2f-042u
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:54:11 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so475277166b.2
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822048; x=1758426848; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0YiDU4Bzw7IKNW2/fgCfvKW6iRx1DQ4l7Ssn455PQA=;
        b=jTGQaZar0UzFmlDsNCRsE3/st0+b97qgkJFkDRuoAhpXcipBOlJAUYF0BxZB/TaWas
         CmNcqySEVJSL3IrX/3/vbvNNQvV7mnvMCay0Jf+HvSjGbOPok6mxf4+Tq3+rWe+Lde07
         SKRt9a3QItIqRcIp2S0G1WF98wif9kFXtUiy1F92TkGJobY478ofpwjl0k97nauOOEyN
         kFLasFINnTJLq27BUxXYMZuSUJLThfUJi/fqdnCerD72GjjgJ2J93uOlKRdM9wdECw7x
         yTzw210MuERuwjR/qsElO1KR3iiM+LqiYcDMP2zF/tnO4CurSA6onxTOifMHxc4qCfqq
         Mpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822048; x=1758426848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0YiDU4Bzw7IKNW2/fgCfvKW6iRx1DQ4l7Ssn455PQA=;
        b=jfhraEOP9qQAeO1iqF9qETGnGe/mP7vfqgUETMx2EkS8S+op425H8daYY8+hqNVFgP
         fYbWoHTTOnKjmdtEkrKB85UnzS3C4pr9yEnwKuWvPrvLUeYQMrtoA9/LyIaalKLbWNBO
         gzq2IiW0ACJRg7nPdAcLXvjCjuyHsv4MflTL4d/SSy2Kbj63Z7PVFgLb5+ttESxzkA28
         mmV9BcFnhAQxXSJAjUQaOeCGWLqif4UQVm8pmMaPI3d/PJ0LTmXeasGg44YIjboCIzWM
         1Rmjsw363HfNg47mBWjuPZAphjnWiR4kVMwyOuwUfKS1YwIq+3FJlRrizkTdLNeChfCe
         gSMw==
X-Forwarded-Encrypted: i=1; AJvYcCXCyJePZf8F7v390jTqPMHYkNbHcZKcWlT/yOKRs7XC+UgNW3u+RWwYY4y/uUubK0XGioMSFZkARw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7umIDNe4ODp9faKaAaDj4XPaixqZT6aAZP7fuSyXbtuckcnT3
	2qSzfdg2RB3tEpPyq+j3tq4f05ZME+M9wh8CZVz7YF1o8k9SXInn3WuF
X-Gm-Gg: ASbGncsbM31vtw0z6vPQm+dqmX5JgrnwEjaDzV3v9RAbQZC61NVwQGr3CIppg2NTGjE
	+OlBHGPPQiuZy3F5IUATB8uv6ivHPNz6LioikA+WQXTmB0PPIUDkWfCEqxJq8lfrRl5LgDCCxJ+
	ACgVn62/0IxwfiXUVLPfICNZLztOcGic/9fAq9dO+RB1WWFC3MFklvTzeInjJXKPr1yCr1RXdE1
	OcS2AZ3TZziqjznKDlm8ywSU8DiYPcBMJ45I5spSbC+lfmZRGgxq3fTrhqecnThI3YI3htrW6oj
	+FzFhQnScM03pYQGEVYMRZ4QzxtRKLihvVPbgb3U0oZym/FiBP7TEiwwFiMybvdnvaoIuieeZJ1
	8RSZEHRV0k4mwkty14OWlJyIWMaCRvg==
X-Google-Smtp-Source: AGHT+IEVLkeZlLSkzoTpPLzlBRvNTQ9m/bl133jXYp2zZldNvB+tlYKH8pXYzZ5ISfOO2+UjGM6RFg==
X-Received: by 2002:a17:907:e8d:b0:b0e:3d88:27fd with SMTP id a640c23a62f3a-b0e3d97e027mr75192266b.8.1757822048020;
        Sat, 13 Sep 2025 20:54:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07da7a8918sm303079766b.56.2025.09.13.20.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:54:07 -0700 (PDT)
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
Subject: [PATCH RESEND 44/62] doc: kernel-parameters: remove [RAM] from reserve_mem=
Date: Sun, 14 Sep 2025 06:54:02 +0300
Message-ID: <20250914035402.3670906-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205410_062641_CDD6DF33 
X-CRM114-Status: GOOD (  11.18  )
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

This parameter has nothing to do with ramdisk

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a259f2bdba0f..0805d3ebc75a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6277,8 +6277,7 @@
 			them.  If <base> is less than 0x10000, the region
 			is assumed to be I/O ports; otherwise it is memory.
 
-	reserve_mem=	[RAM]
-			Format: nn[KMG]:<align>:<label>
+	reserve_mem=	Format: nn[KMG]:<align>:<label>
 			Reserve physical memory and label it with a name that
 			other subsystems can use to access it. This is typically
 			used for systems that do not wipe the RAM, and this command
-- 
2.47.2


