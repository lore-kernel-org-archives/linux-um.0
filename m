Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E49CDD54F
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsRBPlb7y5hjrsMnp1UcoaS7iAwH025ryvDmnQFiNG8=; b=J+0byj7YyGb3I6snb29/ol0cvC
	apPhy/H4znICwdzxs8wSH56qI1MLUmpZn26z9xNXj6HSOLf2nUWx/uiv7ABXrHQY66Gc7kPXCUPYl
	6JA7ml6QTXbfuLZqhlvnpof/3I3wXlr+ACSDG82oG8QbI+XZQZxOgE53c9pFIZ+KCXD+fzIpISwaN
	hT7s+54efSBCJeJjKACVehe4zKeChxjEb++ztsqn9ITs/5/0W4ioFZYBM8h/6iYJIV3gBqzgSRX7M
	Z2AKmAK5VSL/E8ZRsWaTJYUEFWBNUFKjtRNonvFR3nlQhUIlk7dQZoDQx7Apt76ZdQBkLm0ZMl1x/
	myhmNODQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXW-0000000AGow-0f66;
	Thu, 19 Sep 2024 12:45:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXT-0000000AGnZ-3eE3
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jsRBPlb7y5hjrsMnp1UcoaS7iAwH025ryvDmnQFiNG8=;
	t=1726749939; x=1727959539; b=CFUJCYxdYi24lPOXgHylgfxTo4cm8qeVp1Dwb7+f8ubmjoT
	rBlc94OJDT/lmGdBGpeXvf3puaBmmPl1NbepR3wVpdvGgSuvGh6WTjel7Rw29yxxtBLZeWC5+bxQp
	IIbkTke8CUJj6b+0doTsI8ULqWbt479c2XZ/2Km/4QQKe2Mx7VtL/Nu9PscAjlcINH+PRAeMpGh72
	uU61VD5qKzyYad9MUJb63h2jwxfC4PfHvI485AUHOmlx62YwTSeYvpYTeMW7ePc1frzNierRy1qsg
	Ks0ZV6aONhiW7pd+TaB0sY2OSduky6LtWE3UvI8vOkt4msgq/+9gFapyC0TFnubw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXQ-000000047AZ-42gE;
	Thu, 19 Sep 2024 14:45:37 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 03/10] um: Set parent death signal for userspace process
Date: Thu, 19 Sep 2024 14:45:04 +0200
Message-ID: <20240919124511.282088-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054539_937584_481F26DF 
X-CRM114-Status: UNSURE (   8.93  )
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

Enable PR_SET_PDEATHSIG so that the UML userspace process will be killed
when the kernel exits unexpectedly.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/skas/stub_exe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index bc6ba2e4d805..04f75c577f1a 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -32,6 +32,9 @@ noinline static void real_init(void)
 	/* set a nice name */
 	stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace");
 
+	/* Make sure this process dies if the kernel dies */
+	stub_syscall2(__NR_prctl, PR_SET_PDEATHSIG, SIGKILL);
+
 	/* read information from STDIN and close it */
 	res = stub_syscall3(__NR_read, 0,
 			    (unsigned long)&init_data, sizeof(init_data));
-- 
2.46.0


