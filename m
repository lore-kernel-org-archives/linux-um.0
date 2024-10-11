Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FA5D24470
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WZ7paHUzaVY/odtQMce80h9D0+PTfQEqps5tmCXYmKg=; b=D7VhlyGk3cFNnM9A8eCcDq/oIv
	LcHUcQK5vav/cMaLcd544todk6YnA0KymiRkzIg5KwBVcMRXqxVeJK80byeUp8qzPIcvMlPCyFmbD
	H7p6y3ndsezXJH+B8tf3OY8GVmtW2qCb3MXsr95xQL2+AyuvxKFrQa5Qqf27UPfe02EtGU2CUDIoF
	6VjzHmvt4sNGo+UD1abNEjWMbk8QQ45Lakz+mw2sU2o/LNevtBwCI/gZDkm8yL2KCzn2E01rmEf+m
	X+RTTIpl/vgp2kqTFoz1OMVw/G2+CMmrN0xRALHdiUBJ2hCRhqLH6Zu5NXjXEBCyNab581x8ym+sE
	Qe32bFJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6to-0000000FCL3-1aU0;
	Fri, 11 Oct 2024 04:05:08 +0000
Received: from out0-207.mail.aliyun.com ([140.205.0.207])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tg-0000000FCCJ-0dfS
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619498; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WZ7paHUzaVY/odtQMce80h9D0+PTfQEqps5tmCXYmKg=;
	b=BMq2vaX2KA2izb+1NhaMB4uPG0xuhm7rMovIct6vxjS8dfl2vpNSIRtOwCYSzHwUPFozOdISQi7uXHrhbterLF0bYhqvP227ERiskwfsbstYibZktSxA9i3N/QoBhQKJ1AzzXX4/HczVeVrJw7ukr/V0VS8/oqXvaJ9JeDSVnwU=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tvP_1728619490)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:54 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/9] um: Remove UML specific debug parameter
Date: Fri, 11 Oct 2024 12:04:33 +0800
Message-Id: <20241011040441.1586345-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210500_517175_3E1CEB55 
X-CRM114-Status: UNSURE (   7.49  )
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

It does nothing but emit a warning when 'debug' is provided in the
kernel command line. It can be a bit annoying, as 'debug' is also a
valid kernel parameter to enable kernel debugging.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 38cbb41a64bc..6d755a37d5c4 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -167,19 +167,6 @@ __uml_setup("root=", uml_root_setup,
 "        root=/dev/ubd5\n\n"
 );
 
-static int __init no_skas_debug_setup(char *line, int *add)
-{
-	os_warn("'debug' is not necessary to gdb UML in skas mode - run\n");
-	os_warn("'gdb linux'\n");
-
-	return 0;
-}
-
-__uml_setup("debug", no_skas_debug_setup,
-"debug\n"
-"    this flag is not needed to run gdb on UML in skas mode\n\n"
-);
-
 static int __init uml_console_setup(char *line, int *add)
 {
 	have_console = 1;
-- 
2.34.1


