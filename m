Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A16CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iq4EBZrV1lfKd4Zb7NXCMDMChiW0nY1yh2iMeYqfP7Y=; b=SMev9LexvDdUhOMu+F2/3HgsDF
	A/JCXb6M355Y7W/rVgBT0UiV/YKnsbB3dHzbFT1FW10DQRFciOetiw0QtCWwRIVHJiALveJB16k7i
	e4W+JERbIL1XHCXHhb810h9Yxqif7ABHCYnybTvgirEL5GBCai7HCy65NagBuf1ctmi9qi2Z1QZ0O
	NIcjnkEeQtcXv0ERn/wuqsFKGvEUG6oQvA2/dSPoksQgpRgNiP/NRzW5ZEeoHEfoRx8hCYwoyvaW7
	Y0ysiS6AIaUgWU1Z5ZKhch9s0QYOHt12wjj+l4K5tpnIMZaiMMTZaN9ll1VS1zKT5OGN9HkF0nzIP
	Wce89GOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxELI-0000000CMa1-1LEZ;
	Sat, 13 Sep 2025 00:42:16 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxELG-0000000CMYV-219Y
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 00:42:15 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso357648a12.1
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724133; x=1758328933; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq4EBZrV1lfKd4Zb7NXCMDMChiW0nY1yh2iMeYqfP7Y=;
        b=Oa7irtmYAeJyJHS3toAWX7EVvqAMUf2gFbcnnEvNkp4+el4TcLqIdDYC7dDfNWi2m/
         fgjs9yjrt1Hg/vpgPv5up/pG0p5O2lkY55DUefgyjhBVlYWKtjmRJuDhi9me8UnZgt6B
         ydeM7qxIfXbIY+iKEXgfVolLMycrygs5tkbko8MClfdrAvEQpInOr7Smlc349Ag+7vH8
         9BCUofyHg5YY3VDFwS9cCgbgUWPmsh5mI06eYAv2tZuv2DBM5F+iXwplYQRLnELhdT+Z
         juWdYQ6JYAuNPMeASqrY9KVQuRiK2rI4+pxySIg8djJ6pT+Z2bjBbYLbuLQc7NqYJ6yp
         88fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724133; x=1758328933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq4EBZrV1lfKd4Zb7NXCMDMChiW0nY1yh2iMeYqfP7Y=;
        b=AX2a7CdNWEJ39y12cgbn4Fqhr8zdCXOGODikIpcwl2yrpJenVkGjIF8sutY0udsjJJ
         2FuBpQ8D/NjLA7IzWODvG8o2/lTSPnvyNQDT1HBDRVLxwGIGAvjwf14Y9gQE8rACYlhj
         WCrKLcAQdJROIQt3nXt7fAvToo5JXzXLoCqzjdUoQMMs7JZIKiwLFRwNVBC6MsDVHaej
         om/9m7lZzyo6MEF8VeQqKHjlsrwj0RKlvJZk2DojN1IW1aNtqeKHa2YA7JgJ7e2CBBA1
         /hf8dmmpniTy2Fpgx7r201M5l9aeXuul4staPHRRPRlcDr4m8s65P0t7vUoQ3/iodjy1
         rcaA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZij7QdF3dWfkC4Dwc9EXEqW00T1Nsa/I9nKzYWSh4/b2d+T/i86cGbATAe08mERQGEfAhK9K4g==@lists.infradead.org
X-Gm-Message-State: AOJu0YztWcC8XRSu5C8DNfqc1230L7fCkoS5oFiXbVh4yUxy7vUXnmoO
	s/hnLyqCypIidt2BlWiQfXr6IEF/L3yT5ZxupsQlVCr+yGB1oNAbiNPQ
X-Gm-Gg: ASbGncsvfIo1lsiFz/ope0+9HRii0CQrdRsCGqt3idrqFCMExNlfHHK7+9/uI3j7PTD
	s1tuQ53pboaWcPyp2+gtnSDMeHpGRPpjtLYb9HFfiG1gq+pMzyAazV0Z6HI2AiTe+x0WweEb2As
	XDAMPhdTA6zzObyYMWeWYyZGVszFBNeStwkuSwVwlzvKLPSrf6wZrxQ1TVgHG3PwqmxxGHN2GFw
	pRBwkgqLDd26YT8Ncs7zG9AxtG/2t3pt49ZrIwi+Pes1DkTHjkcIXl1CubQwpHxVAiZbX12HDzR
	GrbIn7GQPil/7iO2knT55rrStmE9uUgE2XlEKgvesiSniRTYJ83xhK+TgWGQizsObJbe64ZG3xb
	PRNXPz5y+mxJfr6u94+g=
X-Google-Smtp-Source: AGHT+IF0YGOwgI/SiDLzLobCRbGCMEuk6UiMOqwXQtTxtsbaeH+eIG/iAAo9vQw+zhuCea49+yp7bA==
X-Received: by 2002:a17:907:2d2b:b0:afe:8761:e77a with SMTP id a640c23a62f3a-b07c35833dfmr474345066b.19.1757724132448;
        Fri, 12 Sep 2025 17:42:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3128a5csm466901366b.37.2025.09.12.17.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:42:12 -0700 (PDT)
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
Subject: [PATCH RESEND 02/62] init: remove deprecated "prompt_ramdisk" command line parameter, which does nothing
Date: Sat, 13 Sep 2025 00:37:41 +0000
Message-ID: <20250913003842.41944-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_174214_546955_16438FB4 
X-CRM114-Status: GOOD (  10.48  )
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

This is preparation for initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts_rd.c                             | 7 -------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d3b05ce249ff..f940c1184912 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5229,8 +5229,6 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] [Deprecated]
-
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
 			that). If enabled, the default kernel base address
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 16f7300239da..4d720001c12e 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..f7d53bc21e41 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -17,13 +17,6 @@
 static struct file *in_file, *out_file;
 static loff_t in_pos, out_pos;
 
-static int __init prompt_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated prompt_ramdisk= option\n");
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
-
 int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
-- 
2.47.2


