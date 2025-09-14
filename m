Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331E5CAC592
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=; b=AuWtCZ1P0sCMOxQikMWrr4LMox
	qSMyEabmigUL1xy1/IIVpxd2iOt0SysNmQooXbK272FMHVlORlDrVjCDCzE6mXHCNisV0DFmslizB
	oNsoMg4j8RDm7dwBRKASMMQCraxiiZo8lxRNefhCmccG0bRpKC5Nla1LgcPZEtKqbYfefwtKKQ/kQ
	83mcPpOTvXuXrw1DL6a+yS0BxhIahhubyyj3H5jV2Ln3fZp4XFA/xAcuKIHB8Zr/bS3laq25e6dM6
	NJEjd0t9NTA6WGU5GK+i8olpUUDH2oW3UYeKsTXQc8WBn1s+mYHUeEDhzOfBNSXuHCXkR0qnzFljn
	+GdZJORA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdeV-0000000HJmZ-1TF0;
	Sun, 14 Sep 2025 03:43:47 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdeS-0000000HJkf-1luN
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:43:46 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b0428b537e5so433956766b.3
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821422; x=1758426222; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=;
        b=BlZQXbWjci3FF67OT+SMS+BwCMpBLrRWq59TavGPcqUXNpx4UxoLrTKsSfyARpC44f
         Q2jL+qf2JYS3j+507tOrb5YVkBBlNywD14WiOR+lq/PpWZFRu/Fd5Nt5+/gGhwhXWKi9
         gSi/vWV7Mn2SapmGYwU9CwZSVjbc12tS+SomN1E2yG/eUQhb/lcgkONskvMnziYHYXvJ
         5vd0okokwlVLyvdK8bXBXpkth2TC83D6u5XQb9ba2NSxoPlySMy9S1FOvS12mNFSsaD9
         eySgQ/e9fJek4knCN/w/6seEHm3vQEi4Ood4sYeU1zvkRRaf6sLy9UNp+SzWvisNxKYx
         s7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821422; x=1758426222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=;
        b=V+oIHM9JPCgyweCyB7uI/rBcZjRq7YpXxFFz3IHfet+ULjbqXPbxGFGtiedtXR+fkE
         65V6Ur3TtTBrjUoNFNjafDq1Pe1gRiWoEy4tjLh2rPhcPPzYQ3Z3O98JEE/CHxsOjeif
         0Fs2Y9ijy9eVQnFEIIcrcqrAVKUliX559GTwiXot7xePmdaHM/6/YRFqSAekp631FAOV
         IxzC6Ng+rEr+UuRXs1Pre8B6ZaGv/kQsurKgfh6KmnavSCAdAGZo4/a2WIKaPPoNmbVc
         LOKIkpQGkidZSIprjFK8eF8Fx8pOb8JALj9/nSSx0eNuVdVWp8xMGCd9NJ+2owTEYKQN
         DF7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2mPK3dZLA9E++FoqJlggD/vNXxOM4s5ZKhuOXuOlOGzYbKETAAKl4LOPikiRSOKwHiCrRnfYw2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhFAvniBS3MIMVfktNuEwO9+Ua4kn6Dsr8duJCWHkhcQXR4S1K
	zTPdOJ1Jxu7Ryig+IswyPC7VJ+cA+wDUMtX4mAwrHoPPcd9qQOOGSdJS
X-Gm-Gg: ASbGncuqqF6IWVWusSmy5cHKqrvUNIL8bU5TqtSoQyguEi2RaB0SqdhdwrYi0ERmDjT
	Ba0beGTb7eXRGmwG6mZ+Z4pUgUfHlsQRoNDd+V6Hy8GnFCekYeQ63jwZ1/AmFOyZPXsuUCGZv5e
	VaHUSqvhmiylbHxfGQJ9YfaMEguQN0wbKFxJvs9RfvJOjQKKK0BrG7KBIB8rxJYPl0w1rEUbit0
	d75PVQWNwVE1Iz8mOVB+yBcoZ5+JEOIvBuzp8Q2sLQhEDA3D5/H3x1o6rRoY0MjT7vPzAQraxkT
	PADRAsZtokdogHfM2M4R00lcmb2GQa0rCT4soAUAoe1eIyNMOodr9BtCw5uFxTm//iKyX8qQ8wr
	uD6m6TJ54omOAVM5uM9E=
X-Google-Smtp-Source: AGHT+IET6lw3qY9XyvNvb3pybcnRN4nnQ2bci5TeiF0EBvfDGIL/USbY9x3ZkIUotRlW6z+hFZZ7Dw==
X-Received: by 2002:a17:907:72c9:b0:af9:6bfb:58b7 with SMTP id a640c23a62f3a-b07c354e9b4mr721980466b.5.1757821422077;
        Sat, 13 Sep 2025 20:43:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d2870da1sm345137366b.13.2025.09.13.20.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:43:40 -0700 (PDT)
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
Subject: [PATCH RESEND 37/62] init: remove root_mountflags from init/do_mounts.h
Date: Sun, 14 Sep 2025 06:43:35 +0300
Message-ID: <20250914034335.3506706-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_204344_476931_6EFDF571 
X-CRM114-Status: UNSURE (   9.71  )
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

It is already declared in include/linux/kernel.h

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 90422fb07c02..e225d594dd06 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,8 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-extern int root_mountflags;
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
-- 
2.47.2


