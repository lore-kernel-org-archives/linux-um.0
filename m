Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54FCCAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QP3KPO8+P4bejD4XvvOjfSlYK9K4kJKcAHCDef6XF+Q=; b=e7PUKymuv0AVHi5qkBjl0vzR+m
	00uQoO2yxcUgv6QnpoX4BIo2KF1vNxL1kU1KdTphkPSE6XxVVLkh3QRT94PaZwf9SVp5o+7QvIRAC
	WuMmd447nLglGQsrYdCKRBCFeVCYxwUifNzr9dC7PtKvjz8qyIypZT4FBa9929Af6FW9FcpcjGhJ4
	4sm8rLvYABuTA+qjAIkkDxK3bGLjcyoZkoWHgb6+5xx/+hOTkJaPjM+2whfI6Qga/xNFDqwkIvIRp
	A2sh0Vgce9VKymPPUC3/Pyy1cAl/e+mhD+fC2+rroa1X7hNLPAmlnQq6y25J8PoTxB/zyasdWNcJT
	JQW7MlfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEgV-0000000CUwn-1MjQ;
	Sat, 13 Sep 2025 01:04:11 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEgP-0000000CUtd-2qtN
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:04:08 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so4851760a12.2
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725444; x=1758330244; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP3KPO8+P4bejD4XvvOjfSlYK9K4kJKcAHCDef6XF+Q=;
        b=CFoL+/hfFewMhoWLWhRockPg7+oYUSDT7ybXlHRyutbjuQ6A241S6UB81f7rV8y4lJ
         CVE/oUlAEyjEjHa4C2xNUpbv6xHT3GQOanChpc5YwtKFC682nhNMr8g99wKuHKZ7PKne
         6TS0n2UyMOw7dPH7LwceSHSPlBuKoAPzMkX70MVIl0e10bTH3NaLiw6tqf/O1QZBo9Xu
         vvy9Rb7EmXxfH60vrRTQSOnS9q2fjTXI8aEUTR3Ksvr4cfr6traGOqkrwpkJ0pVRhAEd
         iQiLiWP+SYVU6BXju7duXNEkL6tZzeb/9YAbo5NV5scW7ecElYDOBrWaxtlEAT77eQBv
         UfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725444; x=1758330244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP3KPO8+P4bejD4XvvOjfSlYK9K4kJKcAHCDef6XF+Q=;
        b=KAFL3C4kp/wgUodWiZqyCEH3xSbwlY20CoS9/h65KwyM4SqTcCSYp8ZI8pJqnxwzh3
         0UIDy0jRW8zEER0dQMggAinjlBsvoPR33xlu20y8lgB+jlt8794Ao2fDAnPYRHKV6+zm
         DKXH7sGyAOKbTmmtIuqT9URLtMca2wC1Zt9gBw6gSqy07BRhq8nn91DnvamflQTUrIfg
         sebVqVJeoSmtLHdNXluVKrTmYuXoggeqaMhykgBOapneP9INHMdxW+w1x/pFT7OJFwvp
         IdOCBe5U8rahhWKqSAn2n1NofjTcjDnrWwQxSd0h8banlwRPJkOkzWBJs9DlcKJrOefX
         5dlA==
X-Forwarded-Encrypted: i=1; AJvYcCWKcGLnYGmiozeHx1GrmFQttsFY//yN5GO7neoU1Y8wADnRlT7jlDZCWAvw/ayjoKuYPlSgwF610g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwOSsq/8S5rbAGnF8C2mFGdnmDgN6I+ueZw2g0bc1VS3ZPcHutp
	ZMaMN3DbyfAi/cs+1j7dn2E8rcvXP6gPpj/2RV39jlAyBMqAsteH0xo/
X-Gm-Gg: ASbGncvYiAb4Ggx/nak7eiFKwQJYd+Mmpt4+9r8SPqd8BBGSocy/vIVWF1GuQPbp0/M
	RWNruVp5XsDMZ4/UKtatGqDmBpiooiK/NwfIvfweWipMoQL/Pj5rzSPwlb4ufF1duPH+7TWv5wu
	O9MMU25pwAN0lUrvpDcn2NU63oi3RhE+94W8wJedtoYWspO/Sr4JWlswp/AVPrcqg2kQuZuNnaC
	eDxpqAv/ILR+oWQW9B6AJubaoTxUkfC5unkB0OmpCwg3jmGbHI9V9YoFRgNoRrkuLREe5U+tTwW
	cf9qevMCCVpy0a74EE39belV/p2L7QAbd8l88ILNa7KbZOtdwNse4iB6ZkDZHtRyPd2/p/Jgtjp
	wzzJuuGC+S+1Kpn14blI+iIjx3Cn1QQ==
X-Google-Smtp-Source: AGHT+IF5gJzNBXdtzBXv0OSH4ftjGJnmmybFv16rcAGk5hl57bAzoCs28S7e9w+ysKsSQWZRdIzUSQ==
X-Received: by 2002:a05:6402:3482:b0:61d:249a:43fe with SMTP id 4fb4d7f45d1cf-62ed82c5a43mr4352436a12.24.1757725443498;
        Fri, 12 Sep 2025 18:04:03 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec6b6cec5sm4014207a12.1.2025.09.12.18.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:04:02 -0700 (PDT)
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
Subject: [PATCH RESEND 22/62] doc: remove obsolete mentions of pivot_root
Date: Sat, 13 Sep 2025 00:38:01 +0000
Message-ID: <20250913003842.41944-23-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_180405_752093_C10AFC43 
X-CRM114-Status: GOOD (  15.58  )
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

They refer to initrd, which was removed in previous commits

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/device-mapper/dm-init.rst | 4 ++--
 Documentation/arch/arm/ixp4xx.rst                   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
index 981d6a907699..586bb38d716b 100644
--- a/Documentation/admin-guide/device-mapper/dm-init.rst
+++ b/Documentation/admin-guide/device-mapper/dm-init.rst
@@ -5,8 +5,8 @@ Early creation of mapped devices
 It is possible to configure a device-mapper device to act as the root device for
 your system in two ways.
 
-The first is to build an initial ramdisk which boots to a minimal userspace
-which configures the device, then pivot_root(8) in to it.
+The first is to build initramfs which boots to a minimal userspace
+which configures the device, then switches to it.
 
 The second is to create one or more device-mappers using the module parameter
 "dm-mod.create=" through the kernel boot command line argument.
diff --git a/Documentation/arch/arm/ixp4xx.rst b/Documentation/arch/arm/ixp4xx.rst
index 17aafc610908..ac9cb28776c7 100644
--- a/Documentation/arch/arm/ixp4xx.rst
+++ b/Documentation/arch/arm/ixp4xx.rst
@@ -137,8 +137,8 @@ Intel IXDPG425 Development Platform
    added. One issue with this board is that the mini-PCI slots only
    have the 3.3v line connected, so you can't use a PCI to mini-PCI
    adapter with an E100 card. So to NFS root you need to use either
-   the CSR or a WiFi card and a ramdisk that BOOTPs and then does
-   a pivot_root to NFS.
+   the CSR or a WiFi card and initramfs that BOOTPs and then switches
+   to NFS.
 
 Motorola PrPMC1100 Processor Mezanine Card
 http://www.fountainsys.com
-- 
2.47.2


