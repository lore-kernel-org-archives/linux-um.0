Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B7EFA3759
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2c4Is/vsWdFxz2R54FOipOYVdVbcYQtMX4Mdzmmn/o=; b=g4FeeIqiVi/CFAUyZzXPHx4g61
	/5751Q+yrm+678XiWWI+qmNndH3pGxirWSd0byTNNbOZsiUQxvtJc//I3SksUlQiWCgG9XiQPEqsf
	S+XBTpFVFdSM3t4nGi2CPellwD/Cu1eZmn85vmTZvAfRU0Q49lud0Bt5Q8O4GmNYWtotVtG6ZFWE9
	ogJGO4SPtyBP/xus7sua+PNKs+H5p746UVbQmCGSW0diHpnp4cLzLVzrb99gZsQ6y1Z/9ZDA6EQPb
	+CM7IdLidAUsPBRm+IzAjCq1QO1JYbZ9DPW2SuQ2RPnKANMcGGn9KJxfZlEN+Megz0Ka19U/syMhK
	00nos2nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6Te-0000000G3Cd-01Kx;
	Fri, 13 Sep 2024 13:36:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6TF-0000000G38a-2R0Z
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z2c4Is/vsWdFxz2R54FOipOYVdVbcYQtMX4Mdzmmn/o=;
	t=1726234581; x=1727444181; b=vkddfxq76Z4wEvflUllfoVrG01KVKlTOY/hV/F4zlmQFHSa
	JP7NvbsKdwuaxpHY0fBnqnhaqXUbFR4snkplnYdSberWilV/ss5D8t8Ed48SmvtcDmAyV6tgeveZR
	K0N6uaamcWipbj8+S5LdjJkYGEhyl03trO+WTtl2fWfhqMj+GPyfVlj7b7ClIz5pQBkJLrbTdXVXt
	qtnUEi79hQ2Urli+UV92HdbcNBOkKpZDJ0E0zXW4VkAoRzn3cWb2VhApCwoj1wJgc12z/jXYq5gCJ
	StySBWb4FAQ9mVsoF2dKarRvZlsrndWwT88wd8hVgeyRvBiAq+hgiU+Dob6Zreug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6TD-0000000GXf6-0NaL;
	Fri, 13 Sep 2024 15:36:19 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/5] um: Remove unused os_getpgrp function
Date: Fri, 13 Sep 2024 15:36:01 +0200
Message-ID: <20240913133602.963167-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913133602.963167-1-benjamin@sipsolutions.net>
References: <20240913133602.963167-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063621_639369_8D37EA7C 
X-CRM114-Status: UNSURE (   7.40  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The function is not used anywhere.
---
 arch/um/include/shared/os.h | 1 -
 arch/um/os-Linux/process.c  | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index a94093bfa5e4..e54f64f55bb7 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -204,7 +204,6 @@ extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
 
 extern int os_getpid(void);
-extern int os_getpgrp(void);
 
 extern void init_new_thread_signals(void);
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index d1f5e6002805..f20602e793d9 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -53,11 +53,6 @@ int os_getpid(void)
 	return syscall(__NR_getpid);
 }
 
-int os_getpgrp(void)
-{
-	return getpgrp();
-}
-
 int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 		  int r, int w, int x)
 {
-- 
2.46.0


