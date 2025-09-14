Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B02CAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=; b=aixAZzTOoF3HRUjb6DOcWc2uf0
	NN54ackISnHOMTpSppKgelaJHusNek4YLcxqVNjXQNApiBYn4PEhdyrl0JD37Y5R+SYlcB3DTXCrD
	nioVqgVjPd1k7ujeTrMJd08Gj1rrfB7LVlxclmIhCs5WuRr31SOio0xN1LOdsKAIT/5+817+e6Q1V
	oZ1xutepw2zPkCuCjkximIcdICTJyoMF4X+wucgl5wDu99JBFih8lvAcShiM7Po4xM85Ng4OPlFTa
	EgC2afp8DnJbXiSVH+9ZWfwOuFJ+qNaeze9kAKAgLO/6ApMVn0jPkyt3hC272AJa/ymMyzvWP7/iL
	4XS1ZdFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdlj-0000000HLOq-0uJa;
	Sun, 14 Sep 2025 03:51:15 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdle-0000000HLJd-0xeW
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:51:13 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-afcb7322da8so599989766b.0
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821868; x=1758426668; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=;
        b=b+kCklqOk80jJFmhqHNvNxZatHK0Nhn6qHl65Gyz+pQx1ARJp6LmacM+nyGf1xlTsp
         EGp2F8MnF0KLyr4DF3PSkn7WG9sR4iFytRnqLqn3RAjphEJXVmVVj7POIniobjrIn8GA
         SMArCW3fVtAVq3lVjZWXXjlY1ZP2Gr1oCkRl/GQUDu/m59GSISYvrwvRcfYUhEeiaRxj
         M6leblZkt3YAX4PooNhZyb5sYRp+EvWrChZA4LCtMzJIdhxczo2PPxS7lVDggJdIhhfS
         2/J/ooovVaJaocYckJ5olqJaoZUkkCHQaSUEVWej7sabLQ7UhmUn/9Ro4jKwphrK/If5
         zEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821868; x=1758426668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=;
        b=w56GjuOaXupnZGj646uj1VdYF5uMjAgPxbQaDSw0HpSqvuW4lXK4UU/pKy4tY1UCxy
         InO6/23GptLXaWRn+QnAzI/qxnMfP+NS7py0ZVi31cdD3hxc5oImy2qQF9ZkmDMhV+z2
         AO4jgRkD/BT4h/9n45T4VC4mFAdAde2NNypSq5We0PCE0tH/42w8xwdA0lPxqFNGWc1T
         I1Z+vXrkVs8eMbVtmaj979P5YfO0zz++0lAlfA9d3UAcMAH1aSvsHr6+aFZQ2Z8Fp9cS
         CJKI7UP+veBmlhA3J96IonUTGdC9qrGwyJWOkj07nA+gDxxFVf6kHqvjJT0MDVcSFkdT
         zS9A==
X-Forwarded-Encrypted: i=1; AJvYcCWtNgcik97AxoV6/ASP0U3wuJJHVQkJinQ6K3Rqc2Z8xEimJTBLU5gSd52HmY8K+Xi87R1XaOOZWw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVpokFD59HDedlQYQ5+j5BmD1BMdklcO2S0cUzCWfFvxKzeKLJ
	L8wMac+hpxC1+d8lF6bAtzw6w/7aoXSpxespbThdEmRPXfYEgofWtcJj
X-Gm-Gg: ASbGncu6UdlKsABY1yOINIKv4tSvGkBgqFoDGFFyObO65p/cvAcRAKY/Z7xgFBwKW/s
	WXoCchIkHoaFeLbSZ1oN3lBrA+1uPfi3yez1sB4TCpf2KgdogCKtQZMedsj5cNU8w/0T7tZML83
	75x/ylgiHpGgFUVrF74OKhULs7w2vL3gXaqJhRnJIt8MMN5Okv2WloCi+2NccB7wt6C4F23SkOB
	KNoFJzDf9ncDjYiD3t9xf2sZJFlRF2/VXFlg8uy3R3TKbAwBGwwlIDtAjW6Imj23kxLNP1sBHCc
	OD7n8+830FKv3ENPTA0xiesEs8Z3a8DxKnrmdWxCOOnSyynBXj7/Hv8JXu84ZnUhGAfMHUupNf7
	btWU4gPyOK7/Mdvp7JrI=
X-Google-Smtp-Source: AGHT+IGYiK6likOM/TjE1BLl/jI3UX22nGT0EQIxF87CUWohx3tkGnMcAa8PzC4lwu+rbC2577QTfw==
X-Received: by 2002:a17:906:46c7:b0:b07:da17:79fd with SMTP id a640c23a62f3a-b07da178367mr507229866b.17.1757821868321;
        Sat, 13 Sep 2025 20:51:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347b6fsm679031866b.111.2025.09.13.20.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:51:07 -0700 (PDT)
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
Subject: [PATCH RESEND 39/62] init: make console_on_rootfs static
Date: Sun, 14 Sep 2025 06:51:03 +0300
Message-ID: <20250914035103.3619203-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205110_325335_4A52F39E 
X-CRM114-Status: GOOD (  12.32  )
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/initrd.h | 2 --
 init/main.c            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 364b603215ac..55239701c4e0 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -23,6 +23,4 @@ extern unsigned long phys_external_initramfs_size;
 extern char __builtin_initramfs_start[];
 extern unsigned long __builtin_initramfs_size;
 
-void console_on_rootfs(void);
-
 #endif /* __LINUX_INITRD_H */
diff --git a/init/main.c b/init/main.c
index 58a7199c81f7..f119460bf8e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1533,7 +1533,7 @@ static int __ref kernel_init(void *unused)
 }
 
 /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
-void __init console_on_rootfs(void)
+static void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
-- 
2.47.2


