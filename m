Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3056FCAC582
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=; b=1z5yeUEir9lASYG5QdmaAVU1sB
	HcKOgNjIdLXxPJgBhSjVRCE2Md/hX/6A+/LgtNh9/BaapTrpdHqHxk+xUslmKHYrgEKN5rDLYCgHc
	57qgWtTZLnA0G/rWgDHm6BC1QbtB1msqtZayXdtzfIlPIcGQ3XtCJhlq/UZ4pMTTZQALtQCHxKAGc
	RujGTAjijwUK81kCjZQ0T61jEv4w51gy7+kJaFwT6V50Ahohxntf8Z+o0IBnwxIl2k5Bd91hKr6vQ
	BBJdVWqUjWgA6S0peFsfWR/ZZRRD/76anB0qLLWzyOm3O/smeId0tAwBgO08bvIahH0EkxgbxYUT5
	eGLpHr6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdo1-0000000HMl1-3wyB;
	Sun, 14 Sep 2025 03:53:37 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdny-0000000HMhP-3Vp5
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:53:36 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso3293640a12.1
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822013; x=1758426813; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=CtyLXqQHocSmGeRxK6xzaEzg9VFAigm0cseorL5Dl1YErpPmQtBSuyoi0zuaVKK00G
         FeCKDamxoMd33sL1zV6aTPY0tcKJkzRmBBCk+iNgigTfUUsNBdPbepbItXbGU61X8RbK
         sf3RYfNcfe9ltrZ6WkK0OXL5WKIzU+VUZxwJJt4XglLPtgDFYjlMDr55keyJNvcbtNfT
         zqpbZjWVvsa2Gb6YM8/vHoTVP5o+3/J8OQ5QQzUCYhJ5tbi5S2WiiujhdwKbQEaGUOUB
         o51xuh4V3QzbBh+f73qs6TI20sDuRyMiUiqZ9HDA7Aq27Ft4ijy+S4osdnnYF5mzjECn
         ttdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822013; x=1758426813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=ClLuO2pxcwf6uV/x2e/H+/opPOKCpcMe4yFVPkFtuOeb+yhooIkAc/oBofmIGfqntr
         2+lxPJFfnWyhNIbEc1oCBfG/9tzh2J1QHKQPueh9gv4f4WPd4OBM/nJKkoEeLVLvetUU
         XvBjPodUVxTiL+UWXxHh0Up5EOhj9Siw+imPZTcAeSkFz8ndc+xliZSkF/mneWrWqf0u
         BmVflKXN+N35g8FDMdcwjnxBxBfNTB67yauP1RfgX5p5+Vn0EZJ0+t5okxjWw2Mki/pO
         cAC5NUD7CxxFjGD/2lRVqzuRRF5yZWi3oTHAESNt5a4h/A6jqJMnCRoiM8if5tmpXNcW
         YjTg==
X-Forwarded-Encrypted: i=1; AJvYcCUaRSdfuDRr9kWqM/omvqjfHD0fPlZgvf4iTBhLA1/RtEia9k3L7HTv3VNGy5pLbsV+gr8iCWPlCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDbF5yWypg4iT/ldQTPvqXkyQyAfxBVJx8PvGUdmoX/bO1tL58
	F35Zq6pBMIH5/wmh3aeWvpFbUjgwXZXgnXBj9uoZhFjqwkz735RHXEyl
X-Gm-Gg: ASbGnctnxD3/t8dsU2FrfogMWKGWjf5ZaARosW/u+CowWnx0MwUCjwgm8vgr9RETWG7
	CtmJQfgkTzJ6qpmIpbMh3hbVy6cwD9Vw2paEXdq/P/yb7YVFueztVGgjF6iGDElLjhoISjLN7Eq
	rd/nLOk8N/vfKKk7f/xa44D8wOWV1+vp+hyqaFQYjB9V+11GNCMJPN6gHqDO1rQx3hMemTQUeDX
	efaQ7gfhjESFXIEWigBAtrmw677ujT1D7+TXYbpfehAWvMveWxrNMYJ8bPmFTHODo14TFwU1jH6
	AG7SUl/ZdrOmua8zfV4XFjQD/SbnqSQitTLBXyISbLPqv7HtTpjccu0ROnsDg6VaoErmUI9YImL
	5JGItNdMTLfrtVbCR4p1ngOq6n/5zLA==
X-Google-Smtp-Source: AGHT+IGUQXhZVcMzH5x4qrxgNQpCZ4sYyZ3ugDsvfNumu2I8pECs9df4oC+H+CMnm997jPnr5crTug==
X-Received: by 2002:a05:6402:2111:b0:61d:2096:1e92 with SMTP id 4fb4d7f45d1cf-62ed82614c4mr7020136a12.15.1757822012514;
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3a5esm6570485a12.30.2025.09.13.20.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
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
Subject: [PATCH RESEND 43/62] setsid: inline ksys_setsid into the only caller
Date: Sun, 14 Sep 2025 06:53:26 +0300
Message-ID: <20250914035326.3661003-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_205334_911100_8FA12AEE 
X-CRM114-Status: GOOD (  10.91  )
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
 include/linux/syscalls.h | 1 -
 kernel/sys.c             | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5d4413..75e9ee03d19b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1231,7 +1231,6 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
-int ksys_setsid(void);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..66e1e2dfd585 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1265,7 +1265,7 @@ static void set_special_pids(struct pid **pids, struct pid *pid)
 		change_pid(pids, curr, PIDTYPE_PGID, pid);
 }
 
-int ksys_setsid(void)
+SYSCALL_DEFINE0(setsid)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1300,11 +1300,6 @@ int ksys_setsid(void)
 	return err;
 }
 
-SYSCALL_DEFINE0(setsid)
-{
-	return ksys_setsid();
-}
-
 DECLARE_RWSEM(uts_sem);
 
 #ifdef COMPAT_UTS_MACHINE
-- 
2.47.2


