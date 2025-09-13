Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE197CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=; b=eax5tbR+W/usTcxPJBtEerv+nY
	8ARN8hEpuwLaEJeyTkI4BVDr0aF6/wss9i8ywqfAzmH8Z7FF58rKH4N05y1ru2nfSorldnPBEsVhB
	7CuWM8YCiyhK6hIeyKe6cLPqf9Dn8rXXUmr30T83z1c59zToSYVfZIT7r60Vcw2o6djrtIjiXQ3XZ
	BtjR5CI4z+mCOQman6/5Ed9ODEMQVf88q3qmYVTID0mplcUnU9fD1n4vhdMw5rNQ6+c0u9Mva/yNx
	QRM8vgVVLjud/RmZbW9+j/udljQTMbC4F2bjEdMbC71D4GfQSpLpPyzE46rT+li6Vx5X2mn/UwTwl
	t1xcUEmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxElm-0000000CWya-2z7w;
	Sat, 13 Sep 2025 01:09:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEll-0000000CWxq-1Lk4
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=; b=GHbxsTR9ZY6WEtpkKpo8mTOWX2
	NyzFMbpD7v8aufL9hfjKb/s2vVPYgWQ49EEXRHqc730RFIZUlM9BzuNHYQAs8h3yqpSgik6uOKdZ6
	Wa6fM+K4edfU8p4KwQft+mT6Tq5HEzmNbeTDlyPaXdCtYC1r9ccfYeHPhDUhrG9jZsn2VxJv5mils
	5hBi4vjLBA5ycPulSr5teJ5hXos6FJbC9BMK96bkwmEi8PEOLK3AsEA+q4ayD9l5DhJrtiiKCv0R+
	TO44RPqGk4XxBCdkgZDNnlqrY8shpJkGi2wJyst48JgF3BqGGfNo/nI6exnJ3XnalgipdRBqskY0V
	0Yk8mBTw==;
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxElh-00000006WEQ-3uTF
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:09:35 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso428926066b.2
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725772; x=1758330572; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=KWxbBCe5mNyWB/52yitcrypithj7cDi8pq6avlkBl9bbn1SuSEskWOip4kDttgI1iT
         0j3e/3svG//PCbK8WtA+H+PxVwjS4svaqFKIfYZ6ySDDar0mHjfRUcQ/hIYw0KM2pIyu
         ZClgqvR4RxFjDGAv8Xw5yfPDdLtWFAtPyWJFv2uaAo8JVW2VD+DMncqSgc+Lxt3ieHDe
         bcWYP6wekwed1AKNyk8n8M3donxZm9FGWdUo0AIfzPIdKR/fBYUp/tlTfXKoUeDAyhB6
         BHsgvebmZLLeugnhoQRTxXu5yjeZahk4omCM4npouXVTxkobYFTO9gUVqIaRuI8qVwZI
         P7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725772; x=1758330572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=TP87hkUbNUKZTAq6DmiAOruy+gis4TLl4E8cGL7GI/WvH+qNE5PjYxbmptb2F8qjDl
         88lf0mEzcLICcGGpjiJTXjU5mUaXJCvfiNDL2yym5EAacldCBmQQC+Ks3uIQbV+lV6Cg
         W73lWb+hb0jVrCPGyw04StYq3vv7ob6RTqkQcNUFwQnKQ2Fi9mHlk2RdU5rU8x3VlF/7
         TMGTWlLnbIgo5VNfC6cLIKBIwR6HZ172j6IqXTM9f5+lfCy5oHAJAmWBdSP+gWYPFgv6
         BfQapf5vB1XVZqypHnBMFpfCNq7Q6cfC3HqrxHgtpHx9NZw/QEBUGvohenvEroL1bobB
         Y+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVF4SGTEWOaaoilNuayoYZL5Wg9dEQUjRdCZi64cLLSsr/CAYXeHYwm2Q0GKZgx+H+xgSy+58kaiw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0f9pQXv9dIZZRy0rn7H0u/9rE4kTsWhA+KMTqcXhK8YvwZJD4
	cHbG6NB7rYHeT3Sxe6a2dWnCpKfhVSieoEIrYjU7aC6KoKC1SdbStdjn
X-Gm-Gg: ASbGnctKr8jGRuvloVti0I+PU3tAK+OSuf6g6rJ2LbBHuaQTL1uk1+wldqm1N/XRHBX
	t11IkfxIRrm/wf4gjQB4xSUA5HXE/iRegbhhnWfCNZEGCaQqUBUlstG06/WFCvpo8BICuMOgwmE
	QhejAMZGCPsKduV8brjA0Qj4t9Sz8DzC/SsJAcoR57BqFUMzvKSpOgmonAIoI0RXe74sBniDG2X
	FuJ3y/AZtgaZNr8sQzBrNOPt6cLtxa51/Qs6YW4PmLigien1gG3/QlQSHt2qn5l9uBXz/pWpOHQ
	SONxRKMglVjhV9iHOOxlnErmTxlwpU22avo6GWOemZH6LNO+PbG6TZKsoIa0kRhfHJt5zrpA6G0
	rQTZQrHxi4y1YagZ4ERE=
X-Google-Smtp-Source: AGHT+IHrHcZIQpP/M06nOcq3Snl8FXkxUTmgmKKbhKMXWfrO9iWe4P5Ilwjf7ocqvFrLGTk9+k818w==
X-Received: by 2002:a17:907:3d0c:b0:b04:250d:ee7 with SMTP id a640c23a62f3a-b07c37dca1emr487688066b.31.1757725771595;
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07da7a8918sm104574066b.56.2025.09.12.18.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
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
Subject: [PATCH RESEND 27/62] init: alpha: remove "extern unsigned long initrd_start, initrd_end"
Date: Sat, 13 Sep 2025 00:38:06 +0000
Message-ID: <20250913003842.41944-28-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_020934_297851_8D71DC9D 
X-CRM114-Status: UNSURE (   9.96  )
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

These variables already declared in <linux/initrd.h>, which is
included

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/alpha/kernel/core_irongate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 05dc4c1b9074..3411564144ae 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -225,8 +225,6 @@ albacore_init_arch(void)
 	alpha_mv.min_mem_address = pci_mem;
 	if (memtop > pci_mem) {
 #ifdef CONFIG_BLK_DEV_INITRD
-		extern unsigned long initrd_start, initrd_end;
-
 		/* Move the initrd out of the way. */
 		if (initrd_end && __pa(initrd_end) > pci_mem) {
 			unsigned long size;
-- 
2.47.2


