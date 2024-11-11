Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C428D12D76
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=; b=RoDYG4vLg7oQ21uyFY8DbU91wZ
	0lgXzJvAWc3V12WFpn74BSvT88DPnE1CdtbKRSmt1XRsbsOwN7JrKKcQ3HhnK/25gBPdmMGStIasy
	QIQFTUtdRUoQrTIRjl4OAHV/bieLBCI0MZCoU7WvcF7+R9Fe6Z40NnHFF0kjGxkdl1rul7by4em9c
	O5uOM2wR6INdWiTLJtNtMw3XFjpVgkZthzfleX6PdY47vR9NkjKtPTsklCPoKGgiDi1UewjQ+TaIL
	qXLzXDQj5UMCl4cAWjLjczCmyWsvmHawtpfNNrBI9OrpBUnlYGBR2TzoiOS+R6pT4kxfeHJsUfFfN
	gRFEgG4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANtm-0000000GU5P-0hKe;
	Mon, 11 Nov 2024 06:27:42 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANtk-0000000GU51-0Ol9
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:27:41 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-20cf3e36a76so42567975ad.0
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306459; x=1731911259; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=LCmRtxst+CEMrTbO/Gk1FijQk2OZbyhCAJmPZrP/yzuKfQjiIZNsb7Wo6SM/M45LVP
         k4GmEOq8ZPTLIov1wzpRnaDjV4vxeqkGio+/IVGHazMPagFVc/QyAsPcUm4XnPxPkQaj
         InE2KqcxJjf5G9GGkN00de7dPGzyKSWRd0CghezCFg1AVndgAh8jPkA5pLbiNM4L5gSL
         I1766CuYt0q0ke0quqgHUw6ZbMI+NHVv7XU9EwTmVhuTNPelNafNyZypbajU2dyUZApq
         j83XtXQeEL7yiKavMIjjhb2KltKIPq/pJJEY1+J5yCWs8tJ7Rb0jztBUfR/fBuv/BCvp
         P8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306459; x=1731911259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=S5mmEjCThoOzoLt87ylHdlqJtVU8L4zfZCaq9BCkBBGOnVoHdkeGr1kqdQ1/CE6QmA
         Q1d2xq3KAi4qq03TkDTPAZ7eieCmlExUmBT9/D2Cx3DpRsdbYwE/OXgwNxhdAzOZb/eJ
         DYKgojaa4NhU1eIHwrFC9Quijlw7Trq0R79RNtra7c8meyn2qQl24TOAvU6lWp2Dus0y
         95dadog72rSaaCbBX4E9+DavhwoFU5Gc/e3iDHI3aTdEVJvT5Kx2NebX8QU8PsQaA/eY
         jS66w5Ru7Pr2hMcdyvoHNtKfCYZrVMvLQXSjxsIXSOT8WEARlkaP5bg7vRoQa09kUGae
         Uucw==
X-Gm-Message-State: AOJu0YyOjDfPGFU4sDXn5AaWZTwyzRE5455GvoAlWZtZrc0CTnzvxZ5V
	39Wrcef7Y/LS+PYdNW4VDO5pZtVho+6one6rnqAtw+qs7qaySfQE
X-Google-Smtp-Source: AGHT+IHwpmnY7dnXQcsSzHRDD73tGXzcdssS5VVzqSGyOahZ7QhXBU0+7Fxo/FbpiQKc5P/v4ljTRA==
X-Received: by 2002:a17:903:245:b0:20b:5645:d860 with SMTP id d9443c01a7336-211835bf105mr168324925ad.36.1731306458982;
        Sun, 10 Nov 2024 22:27:38 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc836bsm68741545ad.13.2024.11.10.22.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:27:38 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E5712DBA914; Mon, 11 Nov 2024 15:27:36 +0900 (JST)
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
Subject: [RFC PATCH v2 01/13] fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
Date: Mon, 11 Nov 2024 15:27:01 +0900
Message-ID: <e611dd2e38703af858e22ef877a9135ca861270f.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222740_158905_BEC599CF 
X-CRM114-Status: GOOD (  11.76  )
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
 fs/binfmt_elf_fdpic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

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
-- 
2.43.0


