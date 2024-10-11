Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D3D2446C
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqBp18vUFTJ52DrJam+hRUvSyDLMH764FRvn01AkcTQ=; b=jpxk+S1wf3OahUG+VWLZN8ounJ
	ecnvzbrwg7tLshub9p+PlFWkEXW/8pirloLFFBC+2xESEI2YhzSlXcyCQIDmlYBnUsXsHk2hiTxqo
	+WlrgL9a6C7+Z4J9M6TQnHvuI2txsSS6yT7/uzrW2VcYB1Ip1mbHKv9IQLfOmCoFgz2mH5arpT+8e
	LqNmJdxQ5ngcV4BDd1+dHiB78GXpVQKbVA6YeCGIUxQKKP+swEeZ2bHCcMvN4LtEvhHMtpftQUVs+
	IQqgL2oXKq3VLrU0Y/IBofJpSBIXPNrgE9bVepPGPGoml9UbCsaTjHPMorNjEiHXDVJafO99h12uq
	fxeRgjzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tj-0000000FCFy-1QNg;
	Fri, 11 Oct 2024 04:05:03 +0000
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6te-0000000FCBg-2cZO
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619495; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JqBp18vUFTJ52DrJam+hRUvSyDLMH764FRvn01AkcTQ=;
	b=ZVjEf2uI3gVBF3CfmCO35OuHB6fqntR9jeZrUuACEF/B1/X26ul7qQ+CvPhSFPBkojM6IV6Kx+pHcsIOpfh8JTuyvMKNGYFRXaWHfJTFZgQHiqbJO0UBUbrFYPjn2DA9x0aLFQdWP8/Yf+x5IYaEaUbrIzphvp0XDeLvYa4M9hk=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tyR_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/9] um: Do not propagate uml_dir parameter to kernel
Date: Fri, 11 Oct 2024 12:04:35 +0800
Message-Id: <20241011040441.1586345-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210459_078532_F96158B7 
X-CRM114-Status: UNSURE (   7.68  )
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
be propagated to kernel, otherwise it will be passed to user space as
an environment option by kernel with a warning like:

Unknown kernel command line parameters "uml_dir=/foo", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/umid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index e09d65b05d1c..eb523ab1e218 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -358,6 +358,8 @@ char *get_umid(void)
 
 static int __init set_uml_dir(char *name, int *add)
 {
+	*add = 0;
+
 	if (*name == '\0') {
 		os_warn("uml_dir can't be an empty string\n");
 		return 0;
-- 
2.34.1


