Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71365C28B23
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPPU9buLQdK0KEoPmhG7JTfExV4QVuW+CpFuTqxAZGU=; b=ZEpRkNONblnnqj/esfWv0gIegZ
	vA1DNC275sDZYkLqKnsZ8x4U99iXU7vlHvccQG64OLgQtLGaxEhVROrh5iL9/RiJCo+48TFbdQP8q
	qm6WCWK7UreR7mJrlXZdohMCptW56JnQf0tXPkrmN1Ep2O1oRmPQYT0pNNoHvK6jClSDIVnoEyhlp
	OL3G1c+YMiyI0XljBwGzt0WmY+bA2IDxY+rv1Fx1Ic8IKH+8VgPXfhfL1w0vmXis6cU4xJCUc861B
	8IGWANx78+KYWA5K3Vxz8cVeYK1nsLS7Fzr4w/P5LE/hN0jEhxbmXXxh89ICSz9LEUCELOvFXNyeN
	8RD6Q3jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCpS-0000000BHQD-07lI;
	Thu, 06 Mar 2025 15:08:06 +0000
Received: from out0-209.mail.aliyun.com ([140.205.0.209])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCpP-0000000BHNn-0UYf
	for linux-um@lists.infradead.org;
	Thu, 06 Mar 2025 15:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1741273680; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gPPU9buLQdK0KEoPmhG7JTfExV4QVuW+CpFuTqxAZGU=;
	b=Za81Xr3tOptQRjD530QRHcHOlP2fmkYq/RrgPqeGQZ1G4zRMMB12ANFFDEt44Hfp6iUsdLysnmCyHlCzE1VjH9rYkuOboy8T+haXZka/ZIXCAY8pg1HNsjdie7jCsoeMnN1wVwUFuL2yrNhbH30kVcQDTy/Bb7TDRcA0KM8UO/Q=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.blx0wDK_1741273676 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 23:07:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 4/4] um: Prohibit the VM_CLONE flag in run_helper_thread()
Date: Thu, 06 Mar 2025 23:07:47 +0800
Message-Id: <20250306150747.2926434-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_070803_324984_8ADBC3BF 
X-CRM114-Status: UNSURE (   7.10  )
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

Directly creating helper threads with VM_CLONE using clone can
compromise the thread safety of errno. Since all these helper
threads have been converted to use os_run_helper_thread(), let's
prevent using this flag in run_helper_thread().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 5cb30773c511..d81d0a9363c7 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -122,6 +122,10 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
+	/* To share memory space, use os_run_helper_thread() instead. */
+	if (flags & CLONE_VM)
+		return -EINVAL;
+
 	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
-- 
2.34.1


