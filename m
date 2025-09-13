Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F1DCA101F
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=; b=enmeVfdt1JbG/x3Yf3svbAYUQN
	I3ii/Vinz9CuSFPbZTSAaK6Wz9Oxzb7dp9R+uoZEbllx+/aHIK0T4QeQL2eKzL59CqmKFcS9Bc+pm
	85MWxVTheRWj2CkIpGoUnh3lwWNRG8wwFhwVU/CLb6gfIlZ8ZwSj262icH10aNBja0hSCcHYc+jWa
	nIEy7D5f8SmGiaePNVbDf1CR0pvikREfg8w3V7UihDk/O/z7RlmXR4fXS800Vi1WjR7c0w3UiqfzN
	Sdkr6GDyl8DUfYFDU4j+5ohVTiZGUNFCiGpBrptds/8nBFKzpMRV5Z6Uk1GeCaDBl6Ditq1irFNot
	aUZw+GmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEib-0000000CVmP-0wW6;
	Sat, 13 Sep 2025 01:06:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEiZ-0000000CVky-2tXC
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 01:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=; b=GhUXGcZ4SqtzhTnA1is8YBESk9
	ChvXX1X99M7H/l74Avr+7NuSf/ZRcVm/JiryEyzmvNmML/cdF4pjGCifihGxDeftudWYEE4zfK1zE
	Y/75nY5jX39Er354NFohHjLBhypa90AhVF+/2+fZ23WuqH8NRHK4xFv/rgvhXcVnl8pVFn+rqmFeG
	KRRn64vm9n+cFM7d2eT2Wzc8G8PTv2mVbGPZ3hYMMImDR4XYeczxMNWYF4M2Ile7jIbdWBfbSgonh
	EQwMxgAvuo2+HAHhM6rYmxBAC1R0GyUQXfYvI4nziSpKimHnUTyY+Q6e1zAOEeN0ezAMixyRl4b0L
	Ovqt05Dg==;
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEiW-00000006W1V-1VSS
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 01:06:18 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso4278901a12.1
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725575; x=1758330375; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=IN19wii6cBTF0yoMAxVLwt+XGc7ouNu8meKtdOlxMhwTHj7qKk8JNpouKDZN0wMe5L
         wxTuNrxWAf6Up42vD/UWMSMguu3O8DdTiXrr7a32ChZHXyYzcu8Aonm85d4IPG9nKAVY
         AzRIg9sSE+8xVQdtbUzHSfBBLvx3KypoXBB8s07nGzb3IjEbNLsgfnZzQRvDJl4ZTOqZ
         lR00opd8PeoR9Q4Yxq0BXSE4dSfgD8M+iHxJXNY8+pOoixZjWsGL2cCKhu2VNInKtucJ
         uho8KEC2/l87KBy0d5x2SDSnA78hmUZIujD12887eSSe4Nt5qXfrbYZEx2NqeVLtxoZ3
         2yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725575; x=1758330375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=cge2mS1DY4h5w5Xk9bCpRuhSFsmLN6zh9AEoJo+0XtkjyYxs0Co4XmL9y//skg7X6x
         zudQ8fIp9laMFVwsqFxQwxepCtXeRqEF8hlHst7AUYaV3HwRcIy5tTDnWkQgU5Fo9wmg
         aVVrRWqPRe6dCXH4c45EmmibXwCAQvof2OmOeTpzB7pkrxd5aDEkfP1AU/PJ01SYsZiP
         m5sntNgw63NcTR/zX1MFHP3/R4T7+q57sgc167YKJFzAMETQzfLojuECvADX4IJgEBDF
         +HLRQDlYfSW8GjtSVFCHxxhBJdFF4oVeUEHGgtkq1/NN8sW04H3jL15M2+hTv3JkZEsN
         mkvw==
X-Forwarded-Encrypted: i=1; AJvYcCV46PPNskC+q9LGDgE/qGe8XgFfpWNWjgZ1lhLtOGgJHZ0kpYJx4XNzHfLZXftWe3QgpdkOKckcUg==@lists.infradead.org
X-Gm-Message-State: AOJu0YydG+7p+hXzqe6CurmYc7ZxgB4G0sJCQcz3i+jABZcfBRz27i1U
	9mI3upcjCE3nA9WgQm5zUPCQsP7hGaLrM2DVjGPiypEJ90B4f0CJqOTF
X-Gm-Gg: ASbGncvZEMH15Wl1bAbe0/f6l1j5QgBOGmInola940FnQqFP1VHQ0DDeheY0cLsWIoo
	i8Q5QiELzgBY33FS4m5CDywcJBhC1EZ3R+ytSFFJhSWuEzDIKgPx9ifP5Tyykga/Nk4zF5bUa8E
	7wbPomn7Pkw0+kWFmvozvOI8N5btRjJ4WmZzYl2digrgulufs7Lh+4g6kLwYX2dRW+DjE9KULM+
	nSy8A2CNp9N+dWreeHPifRrA4rSkoJH0dwsbs6T77hIMdg7iPuIKlQxG5yk2+631FpVV5PU4O6z
	jaZ+kHzUWqekKGhtqRBSYCC5dWNLCUytcOl9ghnM47MsA1hyNbMlanF4r5WcOcIZ7c6OcwqHw0a
	87/5TuEYamu9xWDIIfnmS4LzffFuRRg==
X-Google-Smtp-Source: AGHT+IFUls6LXsrCLze7uCxm9gIrKR+0qjIy+VauG9zkpfPwn7RwHzjJtZF9/Fq3L/RMfRZn925KxQ==
X-Received: by 2002:a17:907:c09:b0:b04:35c3:40b3 with SMTP id a640c23a62f3a-b07c384b024mr492655366b.15.1757725574734;
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d9e18c24sm112553466b.61.2025.09.12.18.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
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
Subject: [PATCH RESEND 24/62] init: remove wrong comment
Date: Sat, 13 Sep 2025 00:38:03 +0000
Message-ID: <20250913003842.41944-25-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_020616_838060_806D23B5 
X-CRM114-Status: GOOD (  10.69  )
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

This comment is wrong. free_initrd_mem may be called
with crashk_end and initrd_end as arguments

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/initrd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index e49c7166dbb3..4080ba82d4c9 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -6,7 +6,6 @@
 /* 1 if it is not an error if initrd_start < memory_start */
 extern int initrd_below_start_ok;
 
-/* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
-- 
2.47.2


