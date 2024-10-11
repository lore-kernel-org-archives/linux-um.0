Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1DD24471
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Se+HDEpWKr4lq3f8uBsVRYaVltXK6GKDvy+iKLq80QQ=; b=q+8UISsPoN2iFQzzeEOirv1PnU
	topSHd8MneYOiqiWP19xhrH7KHW8BEQUTtlcI8ktBVuODzWz5OlW0peNQn7NNoXrx9XE9mkGibnw6
	gPn2fQGqfI1dEy6w3T7MNy6UDOinmf+kJ9pNELHNCQdDnhIX7FWS7NaUs4P7BfeiiE1NXv9BdBu0E
	Ai0Tzd+pr4ggnjTQAdq4cCBY6Hn5DVjiOn7kscuzaZ6OQEh58/inI3uif6CcB9jzlM4S75Pg56NYu
	uylQdT4XfFAZ/kNBcxD5Xrtd3wKM/TWKU2R6QmU84AYcM/p1GDxF08LXCJk+i8SXlKBgmNNLQ1g4q
	JPPITc7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tk-0000000FCH1-3gAk;
	Fri, 11 Oct 2024 04:05:04 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tf-0000000FCCF-3KSK
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619497; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Se+HDEpWKr4lq3f8uBsVRYaVltXK6GKDvy+iKLq80QQ=;
	b=ZSS9vBJKaEIY21dyOVVkGnUR/EsHfn0TYsy23cLcdgWE0AbD7jGmrFZM/YDUcojrm5ZZ/SSZzhI+SXKA+k3WYFgO+/GF+s3JJI0YHncQt2fzsrimrM9axxD9EEv5Ue7dtArlRKLwwrKI4nR7dVqtbrBV6BORVpUetJHc9pivARM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tzx_1728619496)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 9/9] um: Do not propagate initrd parameter to kernel
Date: Fri, 11 Oct 2024 12:04:41 +0800
Message-Id: <20241011040441.1586345-10-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210500_034464_1CBAFCBD 
X-CRM114-Status: UNSURE (   6.50  )
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

This parameter is UML specific. It specifies the name of the file
containing the initrd image, which is unknown to kernel.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/initrd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 47b8cb1a1156..99dba827461c 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -34,6 +34,7 @@ int __init read_initrd(void)
 
 static int __init uml_initrd_setup(char *line, int *add)
 {
+	*add = 0;
 	initrd = line;
 	return 0;
 }
-- 
2.34.1


