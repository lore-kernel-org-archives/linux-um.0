Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6665FCAC58F
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 03:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=; b=Kg2o/FmR09NtL7/7Bfsl9pAvhu
	3XNfS7+e5uJ1tmTL8OT5FT4PpBZw4yXIR9dES6ug3NfP1qNK8j4o5XZzMdPXJ0A4LlhxLq9h/x8Z8
	YMmikYr2cO3TnhLFGvDVfHZuTOgn/pJOVmYSE2HtdHHuVCHVoXxATUxeGPQESszYt8btYCKZZn07y
	j+Io386CW6eC7tVVmloZKrtWH7pTw5qnZZjWoeKTxFeGATvIVTMDYUZnLAbXSJhnTCMYyjDT7DpLb
	kVc9Wx1YqaZ/ALvePuw2SANlQw+AaEly4Ex7QuihgHC0oaJSuSwE4nNDjURDq1NeniZvCkyjYrDJ8
	i0EG22QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdrX-0000000HOXJ-0bWl;
	Sun, 14 Sep 2025 03:57:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdrU-0000000HOVC-3vjN
	for linux-um@bombadil.infradead.org;
	Sun, 14 Sep 2025 03:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=; b=jWZ95eDmnZoX/4a2TM+lD4jTzC
	SM/TPxxLEbwPiUjv0GLN3sSETD4vE65zyov6GtINtnp9xnCxv9ZllfsM7sEo2DLddXnWsG1MqgQHw
	rdJ+z0ajgTmONffGccSuoYeUBJZylDBcFsYKjSr1crjlblIP5qhOhv33J1/CvwpP0gDZMUQQ8DO3S
	F3YDvx1N981bzA6msjYCT5Mp5n5FaALS+mKWnC/onuMszxNPZQs2ZxZwLkUPIHE91rQTmw0ZyJ6CV
	Dq/D7nasIcEUsGiaE1RmbgtLffo3/mkJFNjNqeHYlNKAJHlRyMEra3gpdy9OTSlOL+C3dFvoAurij
	IQrVNQiw==;
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxdrS-00000000h7W-0jk0
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 03:57:11 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-b07e081d852so184010166b.2
        for <linux-um@lists.infradead.org>; Sat, 13 Sep 2025 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822228; x=1758427028; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=aHc0TaWXLKfVoRv9nfC+fPJddR0M/Us8cPDkTDwVYo8wjE0P4auY2/r59NjnLCEu/i
         2GYfn89I74PLd+BN6988FQAqKT+0MGIv4IWWCnXpq2LAGrFkQFsK7exNYnTu5F4A1Bgg
         YtsqxEsrzN1Sq/S+TJFubeZ3rLYvGC0PLMeOWiN8bOG5KCciyXW6Ox+32SqYl5MmgoaD
         mlAhARzGGghCH031FcHYIFRv9mbYs6rkSuFHMp8+0bgDfOWL53DkY3uFu0YUbvhQAn1g
         G/bWty5s6evhif3vawMzjQc4we6nNC64tqB8VPK1zavIHd7qv2Lj86IvknmvVPOGxdRa
         d4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822228; x=1758427028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=CZI+4z4z/b5sGpODJl7ULT5ayGpoQezhJ3L8u2CDCd4/uxjH+FY5B8ntMjmQwgYJ51
         T+evDOFNQgxaff81EN/WLqPXyNuFZCN8vF4jKHnqVeUIc0cZcFtz3bxrdG9imc2hAQyt
         ZA1p8yL54nRcj+OK8xRvh1n2pEpYk6wqfCDkH8ldHpchzYyc97eBUnIT5t/vamEMakVr
         SZESCq2grZ7WkL9zzYehYQheurVZKWRp31wA2kL/jA/Uwyn3Pgo08ncq7cAivixnZPJQ
         4Oym9oT9g9nGOLWssQ24QzAPnzJax4fMhP8jlpHfkFPchw/h5SBOaGzfZWZ7p+IlPFoq
         BRpw==
X-Forwarded-Encrypted: i=1; AJvYcCXcYy2iBn0P2t5itBN82FZ9GzwsA4mDQgey3pw4f9gihQWuXRB+OuyOY3wUeNMg+mVqr6K4bJShbw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyV7/qyU1RG96j6Py0m/BiK4nrwtzzzXKzAV99dsQsECSA9pM+6
	Emoy9ozsNpHjUPltYMOD8GKo0uB9trBFYUqo9FapgNeamCJycxL4A4p4
X-Gm-Gg: ASbGncvjWNndwS4Sqij217arBEfOONmqEKEa/F6aj6/CXzN/4gXPle08bNjrnGRR8q5
	SdY94nDvENQParLxom66+eQtf45cjaGdo7zq/ZwOKXApXAknnjglImQhyZ1KDBpxVOjlMbKv3St
	DvY5fiifsJlR/N6OGTVjDe6JFuoszYm8HKMjlIrywahOuFO9C+tjVtf3MAM3i34SDPeyo7fldxv
	Ul+57yOjAwctkdUlqKoMBKijFJPsAxP3HwlSoZ9fYjvlUY0bQ306g3fDBlfJR59thibXBS9QPHO
	NJOhXdDC+cx01WyTYzq+dMGoKbmv2Sq3F6scGokf1UDzYlwbnpaKTc6MaRN29OIEGa3Avitgjl0
	YVUmtW68jiolPRu9EhCsGBfNajN0J5g==
X-Google-Smtp-Source: AGHT+IHHnPU+sOVT053l7deT3P8z3LJVFAOiksWjmZKd0Ub2gBIDgZK1/4gCPHfUrNaBqPQVOEAIKA==
X-Received: by 2002:a17:907:d16:b0:b04:6338:c936 with SMTP id a640c23a62f3a-b07c35b8e53mr876582466b.17.1757822228258;
        Sat, 13 Sep 2025 20:57:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f1e54sm673986866b.75.2025.09.13.20.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:57:07 -0700 (PDT)
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
Subject: [PATCH RESEND 49/62] init: rename ramdisk_execute_command to initramfs_execute_command
Date: Sun, 14 Sep 2025 06:57:03 +0300
Message-ID: <20250914035703.3729713-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_045710_327059_F7D24CE6 
X-CRM114-Status: GOOD (  11.93  )
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
 init/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/init/main.c b/init/main.c
index 5186233c64fd..cbebd64f523c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -160,7 +160,7 @@ static size_t initargs_offs;
 #endif
 
 static char *execute_command;
-static char *ramdisk_execute_command = "/init";
+static char *initramfs_execute_command = "/init";
 
 /*
  * Used to generate warnings if static_key manipulation functions are used
@@ -609,7 +609,7 @@ static int __init rdinit_setup(char *str)
 {
 	unsigned int i;
 
-	ramdisk_execute_command = str;
+	initramfs_execute_command = str;
 	/* See "auto" comment in init_setup */
 	for (i = 1; i < MAX_INIT_ARGS; i++)
 		argv_init[i] = NULL;
@@ -1491,12 +1491,12 @@ static int __ref kernel_init(void *unused)
 
 	do_sysctl_args();
 
-	if (ramdisk_execute_command) {
-		ret = run_init_process(ramdisk_execute_command);
+	if (initramfs_execute_command) {
+		ret = run_init_process(initramfs_execute_command);
 		if (!ret)
 			return 0;
 		pr_err("Failed to execute %s (error %d)\n",
-		       ramdisk_execute_command, ret);
+		       initramfs_execute_command, ret);
 	}
 
 	/*
@@ -1588,11 +1588,11 @@ static noinline void __init kernel_init_freeable(void)
 	 * the work
 	 */
 	int ramdisk_command_access;
-	ramdisk_command_access = init_eaccess(ramdisk_execute_command);
+	ramdisk_command_access = init_eaccess(initramfs_execute_command);
 	if (ramdisk_command_access != 0) {
 		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
-			ramdisk_execute_command, ramdisk_command_access);
-		ramdisk_execute_command = NULL;
+			initramfs_execute_command, ramdisk_command_access);
+		initramfs_execute_command = NULL;
 		prepare_namespace();
 	}
 
-- 
2.47.2


