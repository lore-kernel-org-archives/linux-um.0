Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0553ED2446B
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4f8uaoElW6Tz/MJWwXbPIXXxPfOt+tP+zCNiNmUVAs=; b=qGmrZ6vbb2t+x7CGRRyK7M6zl1
	HRU6rq1u/stompotJOWoIMgKdhUK2E1YTxLXThT6imuKKhmApulGlcowl3+39ozglMvS6Hh74OLXj
	0G0YOpk0w18MsaAO/O3q8dHfNYQhwpij9hB7xC5La16o2alwxlVz1VOuTnUFI6xrbCX0QT+eU1Rig
	1iY+4j4ZG/Uy6MmiAvNJRZSF5BTPuVvYCdcuEhjZSYaWuj9QPTNfbml8iir4aTeWRHDBJDSsTlXV/
	w+7+/r0k49nwYy6A+xhefMkSi0IlNhMenI3spdvXVzaEe5NEP5jdj8gdL6szuVqEXhGeCD5ktWRXF
	ewBw5rzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tj-0000000FCFm-08gv;
	Fri, 11 Oct 2024 04:05:03 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6te-0000000FCBv-3qDA
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619496; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=r4f8uaoElW6Tz/MJWwXbPIXXxPfOt+tP+zCNiNmUVAs=;
	b=GB1HFqINithB5ti16xIvgXCDdSIeVOKtOtOZ/uN6WM3H/bwEv+wIfI1vDdkThkCW42Ti62n4euiX2hnkCGBs4Ju1/PXW6XQU5kFUBntpWIgNL1wvcXjTaOMetl1dBe3Bd1tlAtE9ndduEiz6Movqo/QXuSnLPK0d+95g/AlTtMg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33ty8_1728619494)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:54 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/9] um: Do not propagate mem parameter to kernel
Date: Fri, 11 Oct 2024 12:04:34 +0800
Message-Id: <20241011040441.1586345-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210459_208137_F7CD7522 
X-CRM114-Status: UNSURE (   7.66  )
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

Unknown kernel command line parameters "mem=2G", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/physmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 636830fe00f2..d60df3626727 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -139,6 +139,8 @@ EXPORT_SYMBOL(phys_mapping);
 static int __init uml_mem_setup(char *line, int *add)
 {
 	char *retptr;
+
+	*add = 0;
 	physmem_size = memparse(line,&retptr);
 	return 0;
 }
-- 
2.34.1


