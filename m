Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED25D2446F
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FGxvE++JZaYDMBJ9FqjCNXnX4zxFosLHXSH+gJCOYg=; b=Ca99PMIxVXsiPauBZvJ8Q+mggL
	n4XFaJIUC4MMHKCcqF6zMQoWsLTgHS6DR0ZeRiQqHinWhZOhNWVAPhDUFVg8BS1p55a5lV7BEFK7k
	r7CU0Hadbqf8hXZp19yH9Rsxx6GcDUkerz6FqbyyX+OMLrRMaMJYMpCchG54McrBjUPF1PEHeWs7k
	5RW3Ttlq6CIF7dFwuSB5izw1gUuziidIc0zT+IRJXrZwStTLgLp1kvBAlzdv+W7jhmRw10WKKd8JJ
	camwY3by6QoopYr8kMl4OaVVl68mQnwcW0WS4bPw8SVV8MV6+lzeWh0SV/Vj6iQdRXR5xOD2iAIA9
	HdwISKQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tk-0000000FCGJ-0vzi;
	Fri, 11 Oct 2024 04:05:04 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6te-0000000FCBx-3snO
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619497; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5FGxvE++JZaYDMBJ9FqjCNXnX4zxFosLHXSH+gJCOYg=;
	b=RccJMdrSA0xBpDROZg0wrWEsXKfhxf1EV8yo5GhyJM6RwNlNPzRJCzytmPAmXsVAPg2wleQH9oO7vsfpTCqwvkG4Kf3JIFOFz+BYjPKvjdB2vcIyGlonUnR5PWQoTXZpchtMrKqDvNiEwaU23tW9QeRWsfzNVRbxZhhsc0LDVgU=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tyg_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/9] um: Do not propagate dtb parameter to kernel
Date: Fri, 11 Oct 2024 12:04:36 +0800
Message-Id: <20241011040441.1586345-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210459_402542_D19022D3 
X-CRM114-Status: UNSURE (   7.41  )
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

Unknown kernel command line parameters "dtb=/foo", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/dtb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 4954188a6a09..73369446ed1e 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -31,6 +31,7 @@ void uml_dtb_init(void)
 
 static int __init uml_dtb_setup(char *line, int *add)
 {
+	*add = 0;
 	dtb = line;
 	return 0;
 }
-- 
2.34.1


