Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4108DCAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=; b=o0frs2muj9exGQRrea1Zw8cKXq
	rLNrqvZEWNR4lhrUp50U0fpWA3QoD1KranJQGSK7IiEg3L+XHN+RVwii07zRDOyHruvV03oL5tFjl
	MZOcpohRtDPmwy8+HOZlrv6K88tOw0qSnJzc+zA5P6AJMb5VuEviDmEQ0xFLCG7TE2Ht6RUlygbIA
	RHJWp3i8LuF8KCzVVojxWEbJY9pAmj7iAbjsAq3JYKM0by8hdEJbhC/OBUJh9NMnl0n5vd6+2x8ts
	d1YMpf3x0W19I7/+UjxlJ82ean6mT3EEtRZKnnyf/6ca9LZyefec1XHBPww7+jepcCKiCPZk+dJzU
	e7FX3zdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxESk-0000000CPp9-03I9;
	Sat, 13 Sep 2025 00:49:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxESi-0000000CPna-1BiF
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 00:49:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=; b=iCX3yEP8lyXh3TIASDrmZn0IOi
	/45aVPI5GgZW8+U7jta1nwDao/7YmHm3TYPhLwttFuWx8udWWJfjEl9MeHgmDK/nCy9TK0DZjVWqI
	ffcKL/g3s9FKcULv0gc2563SCxPifSXMqlZ4L37tjg7UEDYcDQ1nf4QT71m2t+mGU2pGbjQtJBo0G
	+gK/oid6GSKyQldwVOs0QMWWv//1kMvszXYlZO1b/ZVLjbm4xgllMCa4iYcRVxUtFyariVzzQV8HK
	xk41FvQaBqHMrpmJ0+jOmPj7W4EKsaXmqoT6rkVVsJkz5kdwupa4FiQf2zJayiOf4rdfsTxrKhqrR
	T9GR9FkA==;
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxESf-00000006UVJ-1cVK
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 00:49:55 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso4441886a12.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724592; x=1758329392; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=;
        b=KsmZ2+qAVnpckB1Xu7m4VDjB29wboUPnG8ECEsFHT+20Dg/TpfiFVXRhP9rW2WGMjM
         TJ+n/cpUYxlAFYychQdqSGdVnoPcV39cPCCAzENtHGx2tPCB+dhvUP/+ZcxL2ZCtORc+
         UvYjzCC8BlcEs6D/vHV3GKQCf3ia9Rn8Lx+lzgClRWOMp/kXwMv84fMul7wzBWMUMK/c
         ixEYUHQMMDqJtV5MjWCcUHyzP+5ZQUsVsTqMZpymuX1O67d8a9A6C/SnhvdRnRNWQ8R5
         SanIZg1jdoMF2rbLP7Z8W5Z0f9u6M8B0n8e4zOFvg2oRrpQgl7SodhY+DWwkB4QGp3PY
         2Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724592; x=1758329392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=;
        b=tlUi9JNOaNjEBtLfc9wufbCcStu0NwlTNg4FjTTzpfitEUbuLpgVIaqObQK0ucABQc
         p7CKw7jdt6cbTPhK7ExMAe/vLRd8ZDYrJkpKPZLRJZvrtyvU2oPnzRkBCS9RA62Wfpi2
         uqU8tOzrukTxUpX7aEWCtIFGc6Okf/JCjWJFOs+HrJfCZTcptOxu1U5wAtRAOZwnffkK
         ly8+Yw+9L+rrYSqU2n3lXLJ1GaGGzEvGxc9Pz0VXXfDbmFgBlOD1K2pjK7s+p/kfo4y/
         2QHuK2he0Wy4CVel9g28R4jlie+8Ak0FHZHZv0qz5turR4xFBzcUGAc8wl4S56QE843m
         kpTg==
X-Forwarded-Encrypted: i=1; AJvYcCWheG/anVPkM5gF7B/V1Od0xglNeGhbBhoy0Gi/B4Nm06GUeiYetnDvGRcPRAfSt5ZNsq5WhgE7Zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBPZY3r4amsAb4gd18YHX1pXfT99SUnkNtMrRy2aKHSAXNs5XJ
	Yt2VJnriPKVBIDsdpmeFqKOyAXylNZv5kTHaPv98VeuanKcAHiJ5TpI5
X-Gm-Gg: ASbGncspM/r6gXrdNN2YlQJQW2hAbWOgxhRO7a+H+QX29Ycwvrmmu5f1dpPHwCm5741
	dBi5qsFjX4RRTi+izBL42cErwHk+57G6MQFvSJpMw4n+E6Wrn9UZ0cv4xcMDdjzjfcA6pjJBNCI
	ySNXhd40a5/WenOpsw9mN+34s4VAG0jsDRKYedlpCkox93zfwBxrlmDZwrd81L0nKJPEqRo5pqv
	HNMVihucJyV6zPwFvzRLcffSrSU1nz8GVnqz7NoxO4xbvE4B2eA+xpWEuwdoz1jTWkwQEx6CsBZ
	0PPFft5IzVt5KoEyo04JJR+4fiTiyheD6ga3Tt/FhQnkGW7Fu/wuQvzV6lBm34sqYoIZgIr16Ty
	OuMAY+Y65ImlPLPWCZKr6Y7CYadClhw==
X-Google-Smtp-Source: AGHT+IFuaD6uE53o0kMUFqkBYFUIpIv4YZNYfnndGaXs7B0K4+B96SRU2dTVgEWhisS3xuLKgCtRtQ==
X-Received: by 2002:a05:6402:4316:b0:62e:df3b:79a6 with SMTP id 4fb4d7f45d1cf-62edf3b81cemr3814693a12.1.1757724591635;
        Fri, 12 Sep 2025 17:49:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3b6csm4149162a12.32.2025.09.12.17.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:49:51 -0700 (PDT)
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
Subject: [PATCH RESEND 09/62] arm: init: document rd_start (in param_struct) as obsolete
Date: Sat, 13 Sep 2025 00:37:48 +0000
Message-ID: <20250913003842.41944-10-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_014953_574664_8FC27DF0 
X-CRM114-Status: GOOD (  11.45  )
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

It is unused now

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index be77d4b2aac1..01257f30d489 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -86,7 +86,7 @@ below:
    initial ramdisk.
 
  rd_start
-   Start address in sectors of the ramdisk image on a floppy disk.
+   This is now obsolete, and should not be used.
 
  system_rev
    system revision number.
-- 
2.47.2


