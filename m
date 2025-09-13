Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FADCAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=; b=ZzGtSdwb8ghfvSlt42IbstGMnx
	Grk7o9PNRixYPqiEnYjs+JJ5nrqC8HInC7DGHE0GUMe4uj1UVlc041JAcnZQ2HfFthV5MVOgsku/B
	/f9ITveuiOfjU0wJHSXXhasYarfXDl6WBTwH0ZI8Af1mk1E6+VijF45XXTczuKawURHcL5TyYndz6
	jpUIaUtJnkOPqiGb/xNFf8o0fwBySWhbBV9UBQFU8LB2CpytJk0y1Q5BMLN0nRX11F0LXkSYrXyY7
	WkfcFYKWR7gbk2Svx1fSdmJdumDFYNO8afccY8fhLcHvk0qZq3UfC5FoE0dkADUuDN0Tvi4FcgIKW
	gcxGpw9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEtL-0000000CZyL-1aZW;
	Sat, 13 Sep 2025 01:17:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEtK-0000000CZx7-0pke
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=; b=mgJ3uaCZ6RM3d2E3fnRloSU6Ty
	21QAaqnuWz6NLKIxG2UpODpdPIWSht1NCfj10LWmq1xPTPfzC88Vg8PVA3kUWo6gnwuqd9yjD8CXY
	V9cpmbNwIpX4JHB8mURtD/18OEQbE5kzFH7YGm/JzuSqFHij3WNSXluf7pea23c2NMZ3ngWoySJlB
	5DX4f/KdHffGm1QKWugpB5wauufOIQedOd8GbHYBFqOQj2lQMqr1bF6nRWBwJoz1VVuNsk6BlaYT2
	J8VHBo08hTodU1X8xfd9yKL/jvas+5i5DO0LSwv1/STjHZvBaBfmprirPlA0UWmK++2Cs67mIs79j
	WLpNbvnw==;
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEtE-00000006WuG-3kuh
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:17:25 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso4461446a12.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726239; x=1758331039; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=;
        b=VpdshuIOFQunxAVNnnW22h87XRKaMcskRK2uhbiwDyAVFCgG0YkFE2ocgCOv3tSgJk
         ld0n7w3dvE9ow6lfFv39TDemfrnWbAGe8eJ71x0Sh553Xh8/QY5HdX+dVwmnXSQq9A5v
         NPIWw5wUMdLm+g7gZw9KE6sCHFdxm+HzwOfL1PUno22f/cuFvq5++6GpLue26Xk9qQST
         LWqzeqRqHk+Yx/9bXvRt3Du6OT06VHHQyppmyIKZxQYpbIPjH6z1XfUHjnJYRv3swN15
         nf4rpM/umt7WOnKwoAcqeDx6DVD1AfoswMtpj+i9DMpO1mYnpAeK1yydsMV7ogRV9TEX
         fiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726239; x=1758331039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=;
        b=bBKWO4mUlpw50xzZDFXOmJfYwRT2lPYKmgNqMUAot678/RoZ1FX0MEys42po1ywaxX
         gaxe/YT1ZvPqHvPdZd+gdFeOutdq5+Pnc9PlSk1teTLSx3n1hMzfpf6952NyVjmfCjLg
         SwXDEXQwVhQ6kMiJ6gBcbufYU1eULTUhkrAmGJD36THPlp0sAUuE3UVLnsNkcPO900s7
         nCOI5BYP0AcoWXdy00A5uoYmDcxsNmwEYcv4CksmlYCW0z1JELFDhflGozKHkcM6zE+x
         l1uJEZeLVf5ma/wqZi21NrJZOJNeV3hn3P7JICd0wvH4i4HiOyiE23+MeFTZL8qemxYh
         /9pg==
X-Forwarded-Encrypted: i=1; AJvYcCVD13vMXThyW7+ul+Jb7f+6kMcO9IBfbB6qCM9irDBBN+4ZulKGqBZS3vXBU/k3yBb24c6ynKCPeA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyu7s2pbbQYS4BmKZTtMep8vLG+wZY8mHnXOyECIzXIPwg8HDAU
	LfunGPlpTM8OKgbtYiHzdae9Iq5K1CmO1hyvZNxltUEuq/hbi6I9+H2d
X-Gm-Gg: ASbGnctG9GxGK1kX+iiVkxSlIMKUpKT9v2pNXKWVA+N5a+qgDvMVC0IAWMrgJJHvMDa
	3tryf0Oy4TNvvVDD5/Q2wdCwf5mBXfM7DIIpJEvorKFBLkV2ZMLQ9tvO6LUEnZ9nZy0gEEWMSPb
	YT5pG7DKaHi76KbJmZ6H4ofo7hl6lZr8qdAhrSSO4Er85LtN48orEP09jDiWpwJnehNlzWGYi8i
	38a7v6EK4Qt8OgzsLxeXa48XYF3Mu05iX0VRApXj2xrqpoPwbE27TXVdn9UPHBXMFCBUyFbktHZ
	mGDCQrBmS10ZkxWniDvh2sDCPGcj63OoS1O893r9BD73uWqBBNM9fBKsrtE2IF4eHq4qRW99bDU
	jkGrs9qiTqnMXgqLKp2M=
X-Google-Smtp-Source: AGHT+IGWcEC7VhNjJKZzReFkWP7F1gkqH4tvvChKQBMnzdm+44287e9kqOEvM9aYYFOmJE4OYY5/Qw==
X-Received: by 2002:a17:906:4788:b0:b04:b435:fc6b with SMTP id a640c23a62f3a-b07c3a79fefmr497358466b.60.1757726238469;
        Fri, 12 Sep 2025 18:17:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ae181sm4478774a12.22.2025.09.12.18.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:17:17 -0700 (PDT)
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
Subject: [PATCH RESEND 34/62] init: inline create_dev into the only caller
Date: Sat, 13 Sep 2025 00:38:13 +0000
Message-ID: <20250913003842.41944-35-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_021723_203148_1991C974 
X-CRM114-Status: GOOD (  11.71  )
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
 init/do_mounts.c | 5 ++++-
 init/do_mounts.h | 6 ------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5c407ca54063..60ba8a633d32 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -366,7 +366,10 @@ static int __init mount_nodev_root(char *root_device_name)
 #ifdef CONFIG_BLOCK
 static void __init mount_block_root(char *root_device_name)
 {
-	int err = create_dev("/dev/root", ROOT_DEV);
+	int err;
+
+	init_unlink("/dev/root");
+	err = init_mknod("/dev/root", S_IFBLK | 0600, new_encode_dev(ROOT_DEV));
 
 	if (err < 0)
 		pr_emerg("Failed to create /dev/root: %d\n", err);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6c7a535e71ce..f3df9d697304 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,12 +16,6 @@ void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
-static inline __init int create_dev(char *name, dev_t dev)
-{
-	init_unlink(name);
-	return init_mknod(name, S_IFBLK | 0600, new_encode_dev(dev));
-}
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
-- 
2.47.2


