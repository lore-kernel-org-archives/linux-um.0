Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15312CE8E68
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=; b=emArH2J1B2XeRM7/6SgpPf1lMc
	P51dqH+nmEB9PXQaHFvaAtXWIpw03D+cARPfdHRWrV3VyhYBP9ft4iKNkoMeZakKuNpRcky7YNuGX
	68vsj931ZAPywbCikBVByVUD5xn6uRsoron/Ya733oIJx1wl/SqchMam4JVfnKv1zdSss1vx0Up+I
	KCm2KULMGJk+ffJ2Sm4qQzd0Df4TtvR9g55Rbgj+hvt1tMKlZHhcAOGZ6PsQOSC9bPnoSDmSKa0Dz
	zOk8mQC+Hm4L+R+/ywDv00Q+aD1F15z2linV0VEjhPg8UWESZ0TKfzHllYFrG1eLG59P/AfZDagQK
	FiQRujmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgS-00000000Ioc-2sOv;
	Thu, 24 Oct 2024 12:11:20 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wez-00000000IUp-1sLq
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:09:50 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so594773a91.3
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771788; x=1730376588; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=Gmp2xjFN2o+ZhIbHIlXTMwhXKv/TMeN/bWLp1t37RlP7s5qz31bhcKDfQZMxkPhpor
         0m+wT2tTsfEIqQc7CdQ6kijFotYEkA2GqY3BDCEwYK1KB0jVIyhMM6ULba3fuuoA/+eE
         QOVuVlquKGscDLCOxTJmwqV0vJ5KjBCydiFmKOcFpXQbuSKXIttYwaZoDAKglcAB0cVt
         S/ALrHVE5YyM13e0xDAshZfdvlwvJ8hcpHySuNhxhsvjAOOnT7oOesCXXjv/K+iyrHca
         /NiQKE8fEQsd71JR/81w7pDkL9KF2FTwo8L2qjZVhsRaZ1dSk8UpE81+jMhtDqvhNVlT
         hWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771788; x=1730376588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rxsmZtwDE9hveMIBPCsasEv3gNTZZ8QeBClxURXh1g=;
        b=qjFJJYbgB/ELIknHGpbKwL76SpzgGW7GsK9DyLFvy6PPz9md7ID0oAXZwx2j45CO53
         CxKdpnQdvaKbz9EjWTVxOjQpWaDqAszczj1PI59lur9yH5xHAkuJIyO9e4ZxwQHIlpAf
         kwyzcQoPjSqimUA2KBisebNyuT1DhDecQQYdMnovbuV0XbLEojfsK2L7PD4JmhN7JsoD
         zAsM2cyGyiYZiN5NceIqPA9cW5Kp8KuCI1OJs8rcBiLVSWnXyLtSvyXA0o5xRApoOcvv
         cD8DgrweI4G3jlMElCD0mElzBugmWNFtY2ZU0yIwG3NF0I/1hY/NlATHWDgDq9V3PBkg
         V+0g==
X-Gm-Message-State: AOJu0YxNSnbC4YU4H3q4q67FNw9K1Q4EVO8HR0fkuaNlMkxI60+2CWCP
	xC8467YxWrIP7tGU0BG0jwun2igN6mTsEpviBHN+dJe6aKrQBY7XJHsF0d9x
X-Google-Smtp-Source: AGHT+IEDeGgbLE/zgvIx9Neo7X/Tvc/kwVBKGo3SVswnkbyJjKLA71wygrf5Z7lZwgpXfxWF3CU2mQ==
X-Received: by 2002:a17:90a:f0d2:b0:2e2:973b:f8e7 with SMTP id 98e67ed59e1d1-2e76b70c381mr5909794a91.38.1729771788065;
        Thu, 24 Oct 2024 05:09:48 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df50eb7sm3335163a91.16.2024.10.24.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:09:47 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0CDB1D51249; Thu, 24 Oct 2024 21:09:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/13] fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
Date: Thu, 24 Oct 2024 21:09:09 +0900
Message-ID: <c327f6bfe8db1ceb5d45a8e0aeba4c46c6c8e064.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_050949_514227_47D197F7 
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


