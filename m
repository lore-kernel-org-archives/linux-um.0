Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56627D2446C
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsXLx7unjaR1Z1JlqwiOWIQ7xIjntSghjwdL0iHHK+U=; b=X84RLHku96ZwFtuI/OzwIc8jyu
	3J4MHED2GOESLIMKBspr38Nn/il2CK1Mkdi7OvxztKD4Jhcv/Rnp1r8JFoMFIc+FvGNDfp2U96U1k
	eFnlNDIg6Mgzckm6l/hDdP25xSqUwz2kSe3704oQ4ff20TBtiSjZss9btRpGSIEnsZLCEgh/XMfwa
	iHyinVdAVzBGCg6dIqaybJYpFSlbcJD+2j6fT1B9KNca7jLXP0z2I5ypQgy+4XZGzq9CUOHRZLBdO
	XrkPfcbfdEr7qR1UFf61+grxVKxil3U1DkZJjmA7uC8KiT9zagszgVF637xJogWb6i/NLrzqRjQKn
	OewZr22g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tn-0000000FCK5-2W96;
	Fri, 11 Oct 2024 04:05:07 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tg-0000000FCCI-0Q2k
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619498; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KsXLx7unjaR1Z1JlqwiOWIQ7xIjntSghjwdL0iHHK+U=;
	b=LI8ORsUrRalsT8LwNZDp9mWw+j6P46A0xXvxKXOgglh/0ebdwGP5VaLGcXvOQ9WAr+ZTNTMiK9LVbFE8zsSm2oPDrx3b21HyJQtRtRJx5Pm/DVbd7SCHlkOyYZDW/uI4oODym5lIZ2X9dl6ub85SlVIAOY3J0zvSGFPlkPVIAy8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tyt_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/9] um: Do not propagate noreboot parameter to kernel
Date: Fri, 11 Oct 2024 12:04:37 +0800
Message-Id: <20241011040441.1586345-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210500_341302_73EC0E87 
X-CRM114-Status: UNSURE (   7.93  )
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

This parameter is UML specific and is unknown to kernel. It should not
be propagated to kernel, otherwise it could be passed to user space as
a command line option by kernel with a warning like:

Unknown kernel command line parameters "noreboot", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/skas/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 2286486bb0f3..8b328eb9d1f7 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -622,6 +622,7 @@ static bool noreboot;
 
 static int __init noreboot_cmd_param(char *str, int *add)
 {
+	*add = 0;
 	noreboot = true;
 	return 0;
 }
-- 
2.34.1


