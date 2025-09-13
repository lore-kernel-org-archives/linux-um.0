Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDA1CAC582
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=; b=pqAlMopuWDGQJVIKrGjlmZCPG5
	wDY6LsvJsm+PCqvwjl3LZS+4WBQgpIVIjLfT+MTRvKw62ugf7V+W3/I1ue2m7EVCQMZumuUcVVx/m
	jpbgSV7bAniWwv4O1A0Pg064rdkX0AGJg//GNqaQEB5jFALoSnpdH6Xb2yL1lDVj1Qf3/haSQQGwF
	OzF7GVTPV1lrtWt+dCktPaop88OnD4H+0k+AALubKyKfmIeVthZjAjom9PaZcYxGbYp4MFlTKOocU
	UNlhOKWmplewEUTfEewj98W+3LzjhaAevO0rPtOpmrV2Nux+HUYBfF87LOcCvzBHvR5HXcD548JVN
	j+Vz3vNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEVv-0000000CQyZ-2jZf;
	Sat, 13 Sep 2025 00:53:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEVu-0000000CQx2-0n5m
	for linux-um@bombadil.infradead.org;
	Sat, 13 Sep 2025 00:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=; b=EhuuL/NVUbT7G+ew8/PRa9MyFE
	HSJhZfLuOTSvAVFxpze11JudFZLE/LrRILy8WwM5nhYmeI+FWdKXrCUzfu6cPhn0a1s4+XYQTifch
	88ROIJrXdsodUdTZRYPOzyUQcuQhu6lXUFxkxxoa1tYa+5YG+JflW77wr+IxRPdy2r9DAFMRdyyI0
	ye/9Wv3rkPeJ0ob8vKqo3ET5o/RXhCimrOQqejZ9+FJ9oNIl4dMsx7lwpkYeZOzy7pX5pFYB5qHV9
	C0h/OUxc2vlre/2tfL7oOV/XUouYUi3mFbWKiWUYXte1Hjq7+rN8785m3TBeEfBGSZnwfI+xDKBAW
	+6pxzuew==;
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxEVp-00000006UtI-2qoG
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 00:53:12 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so3497426a12.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724788; x=1758329588; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=hU8YTgMUBBecnPhuDIoi5Ht3UrknAGU4uwUtoW3eo2ZeNjckhKMflHK+VKStajJqHS
         FzOEESnb0QQxGYPgcWmsKLcWBD6HpkV0i8QQu6tLzx2sFd+ohBFb6sP2J65VgfsdgIKI
         eA7nnA3NjuGdCqpVLsjlEra75U0IdHLCUEjvkVycwlsCgW2u8vyxb7tL4nfBhG0a70Cs
         MXxBYgWJw9OglRUSE6p4Auu+dnvkSHWxcfmSJow5ajWp/mn3cYLnfDqd2GOjjN9QbiaY
         sTrYI22hH9Jy+eGC0drTA8xj9BsrKT8ifjt4Qy654Gac6iAwIF6uIk9fquY+H1Hdglhk
         6juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724788; x=1758329588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=fcKXQi7b6US+N7MgXZ5S+Go9OqNm5tfM0+rj0cY75IEdIyNojoQCy8SL53lAhcW+WX
         DlN9cvWfSDG1oGtHeFjkDHTjPNvtfz9Bix9QxINO1GMfzWIcA5DO6us0HtW8T5nELevo
         DXaKoPxUWjFtkXtzypnKqtPAlYNds6ZUZZ8CUyrY66h9YLoN2SWsQBRF3hN1rkm89gOf
         d2S+CUvgSloGcwC+kuKHk5dub8USk7My0aJyzRgU6kwsseu47wqnd6OLtChV3Sb2vGAq
         igN0mgZBqmeiC+wk1nYOMu8GQzb+K8iGw7BxwUhY1O1YEs1bBdtUTe8IgGEbvup1d6sk
         zMOw==
X-Forwarded-Encrypted: i=1; AJvYcCVa8a+G2IPLHbp1LhW4wIRmF/dFGEfGZtCmjpBzSNNyUs/5iLcQ8dvfjZ2/chGL3SpQHWBdYGLBtQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/0E05OAH+KFowBWamYnQBLeZaWKQZBfrJzM07Yvx0dpxUXcuL
	6j83m16tLCKy0rFuHnJTAQX664pYmdDpkFIcZwYTsGeJs3pfGh5UPPrK
X-Gm-Gg: ASbGncuQtsf2Fl2MNzi5vPnjSUgt4AAj2H/O7mUiFubEekKfWya4m2MjWnvC23M64J0
	1omb9+MP7xTr1fqRlA3iXpL6/Ch4RtCAECeIFwjaHjM3Z1qs4cXBLrGmqyfVFbVEXr6Mho8634e
	HlqlvpdRB5PmBhon2h9K5Cn89W614JQmijsJWHUxecKkfWO47Vdfi90fVv1yr5fEfYRmX5ODTJ3
	Poq79DWlh6XyR4HQ8UsMg/gVJtu5WDcZoFU3+8lJtN1LfEJxYEi2Ghx8xoVTKlnbAq0t4ZOZBqA
	ua1rItE5o9QMQWmyQmHjSGGSTfvFIHaPHseMG6rIyVd74gNWhUDWOWEmNb5g4LsPIMJkWnVtWpQ
	JX/bEwP72PJf07xXSF7pioVLXUQQtyQ==
X-Google-Smtp-Source: AGHT+IFLH7pCvIgBYHEI5BCYMw7iR++gatKVbesXKTxSAgJfhChwCe/V59YIUp3mRnJ55soXUGFMnw==
X-Received: by 2002:a17:907:da4:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b07c35bbcbbmr535243766b.19.1757724787764;
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f22e8sm477916866b.87.2025.09.12.17.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
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
Subject: [PATCH RESEND 12/62] init: remove /proc/sys/kernel/real-root-dev
Date: Sat, 13 Sep 2025 00:37:51 +0000
Message-ID: <20250913003842.41944-13-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_015309_806890_E288C4FA 
X-CRM114-Status: GOOD (  11.89  )
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

It was used for initrd support, which was removed in previous
commits

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..cc958c228bc2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index bec1c5d684a3..d5264e9a52e0 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -14,30 +14,10 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
-- 
2.47.2


