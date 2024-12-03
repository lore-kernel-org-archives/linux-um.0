Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D3E6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JZLXAGKXJsQaUwHOfGxb1XieHVDcZBF9xpfXO7H06r4=; b=NLDqrbQbc91/kx6nz6nLyEXHiE
	MG9EUeTkD0MjSI1KBltiCwjQOe/PJ5XtQJ69tEL7WtDCkwQWfz3/M+6Mczg8X8Wi8RdyIWA9CbBh2
	yQbxjGZCLQdDHcVPfIRlqukET7LfI/JwKT6719QPo7pmf9jkvM1U/lR3zwSURqPFDP4ETAg5PsLlN
	OryH2lGiAS1U4xZIvPIZfj2XTfNz5/IoZE3fC3FC6gdt9dwb7ETLkUlzgL8m4KFQn521QBFG5fYtX
	O4vRhKy3mp2sM5VKRRhe2sQfTCPtg9OFjFZ714C6R4yGmxKd2dHSR2fcBqgydzkEL/jzXrAQajAjs
	oCym9pNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRd-00000008DEj-1qDu;
	Tue, 03 Dec 2024 04:23:29 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRa-00000008DDc-1ZPL
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:27 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-7252f48acf2so3582610b3a.2
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199805; x=1733804605; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZLXAGKXJsQaUwHOfGxb1XieHVDcZBF9xpfXO7H06r4=;
        b=ZULt0Dt8P6s9HSczZ+iTJT96gE92ehtzd3poROaFmHlbQuu2tsxa73rxsx3y68hmgQ
         3FYhfxxTkubK8jsjqFZRnw+WtcyLSMEtUkNFpF1yUsivRi/Yw6Cr1rqIh1kxqJklLm7S
         YWpKEgakrNO3zvnL3I5BnpetyJgDDzdqhaxL03V7hKx4TYe8CW61ykJXlS3ci+gDfAca
         HTpPVvhaJsgXi5RDajDuj7Yt7h7GWwjP5tcGZI9c+j54j3GEyA7/9YTG14eCOq9lT/dd
         VD/0XOzGI8rISkhU1dyFHh+YwnnBHhupCIw/Kx1aW15HuT4yTGV6X9tcg5fiMkv4Q6+6
         g4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199805; x=1733804605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZLXAGKXJsQaUwHOfGxb1XieHVDcZBF9xpfXO7H06r4=;
        b=G618KX93YBDx9Lya4PR6Ws93C4KCSfR1AMlaO0CNZnZ3OzDbBndjA55Igo9qTFrfEg
         qE5qPc9SuQXF3Lr2XkpZ6cIiRemFk8DSYmMt3dgQPwPW8p9dtk7mDOvDkfL3TLp4vQuy
         sPjVPk5QsMa7HUAC5PZG5WyW0xcDPZH6gm6n5EqywSZheZPEBI9cooO2OqM2h8ZzRWwf
         VSRW9ibE+femSY83tb5HIXHUbcf6FeRqw4RuiTpcqbDWALNl5GCv4osIQF3heqaOGdvZ
         VOXMgi80ET7W/i4QarnCjqIbsEuzZEeGHi6GKme+62sZa8dhBfFVVnERYNkeZlqplw0v
         PSvA==
X-Gm-Message-State: AOJu0Yy0/jzqpHDBzQ2jppN8QuVR4TFS2Pw1nyCF970Nal4Zoc3EtFNA
	bshuzTz6Kwv0ZuVRPORpC9kxjGwvvwDNesHvEwPeY6PRDJ+cmcII
X-Gm-Gg: ASbGncukQMtrYf7q/5qpaRYOa+YQLXcM0z/aSV8mTTfKXL8noNOdKyIVnlKPtbywSUh
	YUwD29L1KjEkpVDAcKz3Z5JuldtlA2ESSD1toISTpdOhB0dL3g/+2bzSwLDQiVx0N/xKvcCHwiH
	KtCYTsLF1l2PVLo1k7ZU9g61iGL0VHROLwLVfrkSM1mirM022XdvchHDH56pUukoBcoU+/AleCA
	4csNzRW7ob3/gLCiuSsL/SpaGGgJtAMS3ROQVesaI6ln606kTYMPjT3e2J0POnltdSovFWK11E4
	PVS/8bXwdoWaWJUZA4At
X-Google-Smtp-Source: AGHT+IEnZhvotlCjjz+IuKEwK7J+M5+ZOMsyE8W8PZJgKuTfhkpQKEsccmo0ddOI+80XWjCWIaLEfg==
X-Received: by 2002:a05:6a00:a02:b0:71e:7174:3ae with SMTP id d2e1a72fcca58-7257fa7272dmr1565478b3a.11.1733199805137;
        Mon, 02 Dec 2024 20:23:25 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176121asm9369077b3a.39.2024.12.02.20.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id CFF0EDD39F9; Tue,  3 Dec 2024 13:23:22 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 01/13] fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
Date: Tue,  3 Dec 2024 13:23:00 +0900
Message-ID: <564f58c6c893f8817b07cb192b254f760c256580.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202326_414247_14B30F06 
X-CRM114-Status: GOOD (  13.61  )
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

FDPIC ELF loader adds an architecture hook at the end of loading
binaries to finalize the mapped memory before moving toward exec
function.  The hook is used by UML under !MMU when translating
syscall/sysenter instructions before calling execve.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 fs/binfmt_elf_fdpic.c     | 10 ++++++++++
 include/linux/elf-fdpic.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 4fe5bb9f1b1f..ab16fdf475b0 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -175,6 +175,12 @@ static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
 	return 0;
 }
 
+int __weak elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+				  struct elf_fdpic_params *interp_params)
+{
+	return 0;
+}
+
 /*****************************************************************************/
 /*
  * load an fdpic binary into various bits of memory
@@ -457,6 +463,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			    dynaddr);
 #endif
 
+	retval = elf_arch_finalize_exec(&exec_params, &interp_params);
+	if (retval)
+		goto error;
+
 	finalize_exec(bprm);
 	/* everything is now ready... get the userspace context ready to roll */
 	entryaddr = interp_params.entry_addr ?: exec_params.entry_addr;
diff --git a/include/linux/elf-fdpic.h b/include/linux/elf-fdpic.h
index e533f4513194..e7fd85a1d10f 100644
--- a/include/linux/elf-fdpic.h
+++ b/include/linux/elf-fdpic.h
@@ -56,4 +56,7 @@ extern void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
 				      unsigned long *start_brk);
 #endif
 
+extern int elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+				  struct elf_fdpic_params *interp_params);
+
 #endif /* _LINUX_ELF_FDPIC_H */
-- 
2.43.0


