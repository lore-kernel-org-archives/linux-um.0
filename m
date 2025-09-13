Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED22BCAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 00:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=; b=PW4562F5v+onFNYHnTkx1bpF3h
	6mfQ9uRHalQ8D3C9Cqzc5DSKkWaHZ79nmPyZyEbbqRfR9/+gFgLDnWGHCDbqfHY8NRKPXn3m+Sp8M
	ts2A15yzUfyt96tCNTdv+CbbHQ0FjUO5Gt1aZxuFDccQvtQj/6Qdu9Bqn28+P/MUPILM9u9yAaZEF
	vI3e3MiyXg5BsQbSKvwy1hZOxrpxqvaqGbYs8vkL14VRHQBzKR04CV/jnyweDuphmZPe/YbhJUZnI
	cVG6oZ65F1nJBBuXgODWu2ukMaxs+tVrP4o7N3M7uNQfvCVvjkWq8QMFtO40DY2HgZlkEEfmDSsq+
	TyhdUTYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxERe-0000000CPK2-1lkO;
	Sat, 13 Sep 2025 00:48:50 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxERb-0000000CPHB-2b0d
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 00:48:49 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b04770a25f2so357253966b.2
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724526; x=1758329326; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=DiB1WHpY3hl9urHfYoiGKQes/1+bZXlg0RRUxstjsS2LbN3XKKXMFIhSkyOS10254x
         LJLSX/2KBTV6scucfASjOgnMe81XNuRRgLkUgK0XcktazhYGCabb04SHgecNrpn50MbD
         9F1E0++oAHdNTzK1EIJ7QuCVOOxNLBMos+8AsEkuZyMcd/26s0uHUAp5uPxFaOVQkrcE
         s3jjjEZCDW1083p4vMaWyqH6FwyTqygLDIthfRV2TCO/Uy9KpSPVQ2QwdEBvsRG+Y0s/
         QjUbx8vhStrV5SbkNjbNeUFrxxLiDSvknIH7T8H3tGFUrHuNWnWM8xACK39wv0FdwKDK
         3/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724526; x=1758329326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=ePfAIRHK72/86gHZpchvVRGyTB3u5QgGIJHiD4zWT2Ee5dLdh07vo93rC9UIdbtzlt
         wXkcDbwRYCVgaMoHvjusFoRu88GqPMDFE4lw5cLPGCSZhmMGnox9Adk3TvHjiccl7/26
         WUyaxoSuPamV9VAcD4/FNv2LaTmYwfhV5RNNUxwh3DOhgjJqsgOfDboJBiDUHiFtuTp+
         mXtpbEnOgz+VXJj0qqaY6xEsloM6lY34WUcimVAKGiK5dYQmHWB2P57S/e4Qwy2Zjwfr
         em3cHcXLo9+172jYpmWmHhAmgmAwsNpaeDt+C9qQDa2nGMAvDAnYuJ0Pfz/5AH0+y3Yr
         FPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEMP1ieX3xe8bzFeBaUP2eru1wpDRwON0QJ0R9oS/YYVtHid1ER6/2eF24RS51LH5qLbgp+zn0cA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx38kbsXs8e/wxNXH58l2d6qloIvuhmy0QgF8Zw5etT23Ob5Hji
	oKi2v6b8N+AfI3r4KuD/NBsDUIY217TNG8tzPgY7w+ac/qzxZ+ou+nNw
X-Gm-Gg: ASbGncvgILwCDUCErv9CrVdUx4cyGZqefnBbjoh6XFz+s5Mu3ZW1orasFbQoSkB2OF2
	HMuV9IFcN5W//vBfTaS+eJC7P7knotE3nlPQdQI8eeZMMbzaYFk0EweQDiU41KhcMQZTnN0YKW2
	s4YK9MeFyub2ixyslHRKd1ojV5vAnJxHLxNw1kGy7BWWrIiqoZN0xwhMijhyZ0TmARitE0knnHl
	ZfcKsrm6/mZzGIF2r9iZepmdWVArI/8fshMgLeKVogJwW1u1BKekTH+yvfCybF2kZCIPxLf5JPr
	UaWim/Bj0WKcug7ZErmcHKRwEJMcy02fjEkF1osAQivsOcy0m1wpqkOB5o5+BmzIcWrxfk7vZS1
	61tBkow6ue+62kC63tF4=
X-Google-Smtp-Source: AGHT+IG9OWg6vz1Y30fO80tUWulNMPWiUpAt7xVByuYcp52he6rblxs++6dTXTQkGfdvR2czpiOABA==
X-Received: by 2002:a17:907:d88:b0:af9:add3:6bbb with SMTP id a640c23a62f3a-b07c35fb469mr433586666b.29.1757724525627;
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm461777466b.63.2025.09.12.17.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
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
Subject: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and FLAG_RDPROMPT
Date: Sat, 13 Sep 2025 00:37:47 +0000
Message-ID: <20250913003842.41944-9-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_174847_678335_9A448665 
X-CRM114-Status: GOOD (  11.83  )
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

They are unused since previous commit

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 4 ++--
 arch/arm/kernel/atags_compat.c   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index 8e12ef3fb9a7..be77d4b2aac1 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -35,8 +35,8 @@ below:
     =====   ========================
     bit 0   1 = mount root read only
     bit 1   unused
-    bit 2   0 = load ramdisk
-    bit 3   0 = prompt for ramdisk
+    bit 2   unused
+    bit 3   unused
     =====   ========================
 
  rootdev
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index b9747061fa97..8d04edee3066 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -44,8 +44,6 @@ struct param_struct {
 	    unsigned long ramdisk_size;		/*  8 */
 	    unsigned long flags;		/* 12 */
 #define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
 	    unsigned long rootdev;		/* 16 */
 	    unsigned long video_num_cols;	/* 20 */
 	    unsigned long video_num_rows;	/* 24 */
-- 
2.47.2


