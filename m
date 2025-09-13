Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AE2CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azZv/jvf6IRhG0wveCq5ECQcNHAHnPNLNif/IfsLlkA=; b=BkrAlf3F/UXbey3E0vv3M7g4z2
	uj8ZuW/9CBgjVkHUZ/1qujFNPDeYtKy97ZJDa7bWH8meWfH/FtM1i2j8XxicgACfi/owDWQE4OC/N
	ccoQD2JIi3TBQ3y53jGqemB9X9N9jn7R2WhabHoJHrv2SZ4Z/ATsnV+tAuAN7EySjzszHA2qEsZ3D
	yDAGHJros0nL22tPfcL7cWOjM6kIjgtzsFIkeqHAyGA8HdaFj2C/NfVVArmBfTSVOZvDcgJV6Xpbc
	1nRVSWq+Wd2sXmceXleLpn1aRqvp8uuz/0BK0WX8EKq6jkHVAfGQabnz/S8wh8G/3Xo4glWaF7FFc
	O8gZV6bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEuO-0000000CaLS-1H1G;
	Sat, 13 Sep 2025 01:18:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEuM-0000000CaJp-2vvL
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=azZv/jvf6IRhG0wveCq5ECQcNHAHnPNLNif/IfsLlkA=; b=dChpb33f0btNWsDkvfYf+DqLUT
	pvwe+QV9LpGzdC2hvTeF2zXQAlqRbUyvkwf3OPsHjmjAKAz7I8QipA8KxIkphFQ9MXOawvvu0h8tv
	TdZNR9DRztiL9nLgpmbLAUbTNSB9OJQjNSqBB8uulyOSHzPmShC3I+mY5mqQeIt4YMHEDPZuVxyHn
	35NvyydOjaL0e8yZEFWlAQ6FWqHU6gLrMnUl/DkErlksm5eiuYinPrz6pPcdSYXdVzV3E3kOmrxvQ
	f2/eS0NePsMdZuCxkCp0hLyfhd1bjRm7s3LknhwLGGPfFerRvljaEYabLwXWwAqnbn2+EchwghU4U
	rBRI5uFw==;
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEuJ-00000006X1g-0vQc
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:18:29 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so369261866b.2
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726305; x=1758331105; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azZv/jvf6IRhG0wveCq5ECQcNHAHnPNLNif/IfsLlkA=;
        b=gcObzO/2l9gGH4skKnp9LQq1Cg5r+dokWql+YyAnbaLuvk0Q17RHWWQQop3epXt/3x
         tN6bmM+OfjCUHToJw+etICoUKc9tf9SpRzVZm7o/ADa7IWo8+4IKGBj0rI3m/OTHAIgS
         EGjYqQg4Fchee9SSbPPdN5YOdpx5LWBrvAAfUQQFMl90Qhaz1nKkD/UT3/eTmf58zhoS
         SY+APpTHJ1s9IJMscEnJwPriQy+5nhFIVQA92DgN4xJgSCKJBjZYqbQTP/I9Q8Dnue7C
         FbJCJ4JUVhh7EZk0MoYoe1P+azZVZR8eR7jqwkTMJ+yCXwP6I9UJiMeOpdxVyMbXBmqK
         Hmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726305; x=1758331105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azZv/jvf6IRhG0wveCq5ECQcNHAHnPNLNif/IfsLlkA=;
        b=NihEUw6Psijnm7wx2yolYYP1H+i1Ht9VJlyi2HwwEAAJ/O+1VtVnMFoWByvceGczle
         HXfbTC0GBHB5MA3WntnO42pv2hbC/DKqc604ynHC8UfbsHEgg6lPBltE8FCAl8uvK5JM
         T0pI3KaEVodrghbK9MEIRm+GO8BqJzaqrBd1Mp9k0kqNkImC7rEVlfe0VbrswvQS5xAB
         nDQoNYdBRUO5H2uH5tIwXmDg7NxVCTTg2iDbVLMX6XdVyyXSaEmJ8x1Pagu1RR0dKWIH
         l64z/rJBNHgXFsCCjuwZeC8Az8pIM0mnwtp+se2EoJmU40NOxtHFFhmJflfxlVpsxwgm
         OZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCXh2dgmDxuXtcxdPK/h8JcSxyVtflkqz4RCTxqIRPZO7Zltw8xq1pk+05AWRxrg89w5OpyJv8v24Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwaAlS8VUpBVuAYdc4Sg32lf006/zHC3kW/1qZsLce5iTYS308r
	jDwfDHnppdUvLgC58OY/jVDMX5npNo6R3fJYo9H8ADjdBlB1tnJGh4e2
X-Gm-Gg: ASbGncvh0SkppUcCw1F5id8aFF+j3GRp6NI2jrBPjD3aLIkClYIvcJ85/WT2WcKHMq3
	yHiIKiAi8EpBrgn36YNlaeG6yAfvS+j4e3MIf7oCgOCHff/AZiuqMCEFx+pLT5apCnrMF5ObFG9
	FZ9isX34jZGNagWFELd20H0A3ciKMfuU+IFeQbMyQwJnnBuoiPNW5kAXDbLngL2TfY38RT1U6Nk
	tfHqjviTdMENElaENU8GS9pSDZLCyjQN9Q+ViRL2+k/aSqDZ5tjg76kLs2MhHCzzWX3YxX8uw/l
	8hP9bI1ARX33oykaRquI5+AsIlTedoQEmRRpVBaLmi02DHs1xPws2gs2ZoIlhA5s10Beu1n37Ew
	CHvShSQfkJ5kggN2U9OU=
X-Google-Smtp-Source: AGHT+IExQyu+Z7m4GD3MP2gVTN78xlktku98kUsQddou1aWuxY/hOtzAat6yYKAto7vnFggGkvcCIA==
X-Received: by 2002:a17:907:3f18:b0:b04:45e1:5929 with SMTP id a640c23a62f3a-b07c35cd746mr507554266b.28.1757726304508;
        Fri, 12 Sep 2025 18:18:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd309sm475244766b.53.2025.09.12.18.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:18:24 -0700 (PDT)
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
Subject: [PATCH RESEND 35/62] init: make mount_root_generic static
Date: Sat, 13 Sep 2025 00:38:14 +0000
Message-ID: <20250913003842.41944-36-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_021827_416330_77532750 
X-CRM114-Status: GOOD (  12.14  )
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
 init/do_mounts.c | 2 +-
 init/do_mounts.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 60ba8a633d32..c722351c991f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -174,7 +174,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	return ret;
 }
 
-void __init mount_root_generic(char *name, char *pretty_name, int flags)
+static void __init mount_root_generic(char *name, char *pretty_name, int flags)
 {
 	struct page *page = alloc_page(GFP_KERNEL);
 	char *fs_names = page_address(page);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index f3df9d697304..f291c30f7407 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,7 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
-- 
2.47.2


