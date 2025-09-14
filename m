Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5371CAC58F
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6PVDclpYQ6Nji01yBeit38rRV0WhZ/F6Ahkj7S8LBJ4=; b=VNHN8/l6bPg5QQPg/SvaQpkWMz
	KGbi2sWRsCiZliPduTvsqnTF4dktr2+ohtwtpUTc06L8VeoMeK8AoZpk9pgy+H8Bq4H4MJMuMHRZ4
	QwMoRIPg+BSw7M0mcuQsSK9n1SFIU155CreRw9hKqg+t3glC1IH+eYpSvoR7/zkTacO9WcLRYknre
	QqiEhy8UHIAiOHABHe2m8GdHyT3mbywswFwSMMJUFdtXA/c6+v1kGRmH33K1G9tExyS1208aa8gaP
	3bcVyXssFSpKaI5haEszXZJy3XqBlCK/HnzNDBLp7IyJrKPd+Sem8pVvy+K5JaWkVDziiBPmu7gpo
	6ANPgWog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdtg-0000000HPkS-1ww0;
	Sun, 14 Sep 2025 03:59:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdte-0000000HPim-1ywJ
	for linux-um@bombadil.infradead.org;
	Sun, 14 Sep 2025 03:59:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6PVDclpYQ6Nji01yBeit38rRV0WhZ/F6Ahkj7S8LBJ4=; b=HM1VdaRsv7MDuvK6xi2ARc7+mT
	+4pUexwhSkC+C3g5eIuVry2AZORauSaMbIkdnd7E9OvrSDaNOfO3nnQQJ+DImepAeTflZzgu5wD4k
	3ue8pOU5+9vwYPK0HIy5fK/6VSHjK2Wf2eHzeQ31FeRglrl4BEVRLwqUyWlxZOd31vYt9y1MclMBg
	/IzI5wKAPDtWIm7iNtGB+38IyztqGCruFF8DcD6PQ9V0OONlbum2IYwCah+GU6Dil0nRc2sesUQyv
	JA2marXFv61YsY/oiCU3y6kuBs7WB7y9NMzJgS8m2bwfVZiie5AX0W5mI3DhkQJyWWylrQ9pbL/4B
	Vdq5eCsw==;
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdsd-00000006iMG-0iP6
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:59:17 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44aso987382a12.0
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822300; x=1758427100; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PVDclpYQ6Nji01yBeit38rRV0WhZ/F6Ahkj7S8LBJ4=;
        b=UlaR3A4Eq3aQNFev7CLeZxHJNYT1TEVe+xLhS9Kkv6jccSalneg5KmwL0FdI2pD09y
         EooojtIdFQ9Nj6+YZeZNt2kYFKC69Bs4czjBQNG6IeLmWjsJcXVeSfoQuLB2rQGlYM4x
         i05hEzLOXO4Q57/ds96jpSMFIOSWfcjBkCsjgLWsp/RfHKTHZC31yg/yzxBfkSAIZ/bH
         EGo5ZaYOiu+mbiwEEfbblYPGaOCstuP3UaeeWsg0yej+QWvy8e1Y/jrfLt8nw8IwVWEX
         wPlHyH26aEqVsFFualqrQKsw+DkZtLysxp7PVSnpAO2ait+lqyrji+3pnyOUMmUz/P+J
         YajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822300; x=1758427100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PVDclpYQ6Nji01yBeit38rRV0WhZ/F6Ahkj7S8LBJ4=;
        b=Zom4wfvodncG2ejEDoExQ2062hJIzO/lkLXa0OrhGOyZ9nf1WPJDdvKqkW4KMWzzFa
         Rb47DaKtBzYzsSuKJHzEe3sNtWVR+cRfN+atEmWFDzlEoQdkNlP+wKj9aeYDJ1nvCRzg
         vgguvXX9C08J/V1VJ8F/5MBRauluc3+cqOn0ynw7lSZdhC5cLBxZPWTpc5m6Q6Sqx46i
         ly8ULfFmeibmnZW9QB0fnW/nGDkkHxVzb7nyFFUecFMWyGpi/DvmekQELVj2VQtcHM6b
         EZzP9BFwg2nZhKMJx3u2mhlmcQl3vxRNEd/62Nxukr6BrN6EDCzOXy/sVzsXEKx3qdiw
         VJSg==
X-Forwarded-Encrypted: i=1; AJvYcCX37eO535Rjam7PD0KM3YEG9FemMmSa9uKSf/qOJQbS6xzaFWkzEOWi7DkX7L4dufzpWsYU9ypahw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFwFuC2DgCneFPfBVr2sFl+aXwVj+AqYd4zN1S+sJaQkpmqthf
	mr3Py5vucHeZiYpzXkwt9WW1/49AkxXkT9n24S+qaHmr4ETmC8bPzet2
X-Gm-Gg: ASbGncvSHGEKwFZq7J7bnuvI9qdoxMBotRths/22IomixaJtBEH8YdCJW7o7yG9dGre
	qn9+XjXtCuwLojBAflc+iJo+IyXZedL5Rnh8D6PhFBPnzQvg6a8u6mXyOLcZR1i4IwIwrd2WCJF
	JvcbxLjURpJ7njtvCk68mJNMiWbLCgtqT7k1sjPhHe+fubAoqPEktsB/wV6XAPjHA7Zf+BMzNbP
	IDHJo1AwMzeQvjd/5xmJ3YiPpWRAncyY+KAOSsJN9WsgYq2+u7I63vsi45lLixWaFWe4ZzdJsrY
	1KQd9SeVW5anIuhRiWAHjmxFAnnG82k2No3uX5F8Myx3Si6Mp2lw7W9lnrw+B/d1BGDrAxoogtO
	OgjaRPXyxdQ3Z5a9dEEU=
X-Google-Smtp-Source: AGHT+IEs7a72WksMtWatD4lSFnDxnNg7+5MS1D9GOkH6MKg4k8K6DTsXjCx54xq6hKPtDzIS4c8/bw==
X-Received: by 2002:a05:6402:42d2:b0:627:f47c:b199 with SMTP id 4fb4d7f45d1cf-62ed82599f7mr8759493a12.8.1757822299751;
        Sat, 13 Sep 2025 20:58:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62edb7d9cbbsm4735738a12.15.2025.09.13.20.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:58:18 -0700 (PDT)
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
Subject: [PATCH RESEND 51/62] init: rename get_boot_config_from_initrd to get_boot_config_from_initramfs
Date: Sun, 14 Sep 2025 06:58:14 +0300
Message-ID: <20250914035814.3752803-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_045825_430103_9655C6E1 
X-CRM114-Status: GOOD (  13.02  )
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
 init/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index a42f1f0fce84..c535e0613df8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -264,7 +264,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(size_t *_size)
+static void * __init get_boot_config_from_initramfs(size_t *_size)
 {
 	u32 size, csum;
 	char *data;
@@ -311,7 +311,7 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(size_t *_size)
+static void * __init get_boot_config_from_initramfs(size_t *_size)
 {
 	return NULL;
 }
@@ -420,7 +420,7 @@ static void __init setup_boot_config(void)
 	char *err;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
-	data = get_boot_config_from_initrd(&size);
+	data = get_boot_config_from_initramfs(&size);
 	/* If there is no bootconfig in initrd, try embedded one. */
 	if (!data)
 		data = xbc_get_embedded_bootconfig(&size);
@@ -479,7 +479,7 @@ static void __init exit_boot_config(void)
 static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
-	get_boot_config_from_initrd(NULL);
+	get_boot_config_from_initramfs(NULL);
 }
 
 static int __init warn_bootconfig(char *str)
-- 
2.47.2


