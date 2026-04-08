Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64008FD5F92
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:References:
	In-Reply-To:Cc:To:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hgFCpBQihoHdthu6uuECNMS8dLlL66LemOTFgOGP1zY=; b=0+vuMtkI/vJB3EenJYwdr4tbfr
	4i4v5EEq6NrEcDtkS2O3kW0lttHOZQoGqmnSQUGV1z98hiL/k393hNGHSTu1P5NW2JTamOstFJigR
	nKUIOt+3ZngdB6wy32Nw7g7d61cxoZK2OAgfmlB+z7VUB8G+el0IkMcyTs5iu8QeXIGswR+PO1R89
	mR+wnDByAy0vDmvf8zTC/azhNq4NeVPwd5Ph+AVd7Qer43mu4oANLAIy+xInUBeIuNK3jhk9ya3Mj
	HiZN2/wSUvrWKvmdPnmAL/vYIK6tuy8ZusBbAMySPve1sY1KLTC9bYtzEFWdAnscQfjIZ8DIEcwK0
	DH9oih+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAO69-00000008VkR-40yo;
	Wed, 08 Apr 2026 08:17:17 +0000
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAO67-00000008Vk4-0wLN
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 08:17:16 +0000
Received: from 0001-um-mconsole-v2.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowACXueAED9ZpM6pYDQ--.19818S2;
	Wed, 08 Apr 2026 16:17:09 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Wed, 8 Apr 2026 15:35:13 +0800
Message-ID: <20260408160001.1-um-mconsole-v2-pengpeng@iscas.ac.cn>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, Serge E. Hallyn <sergeh@kernel.org>, Christian Borntraeger <clg@fr.ibm.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260329030946.32410-1-pengpeng@iscas.ac.cn>
References: <20260329030946.32410-1-pengpeng@iscas.ac.cn>
Subject: [PATCH v2] um: mconsole: use bounded version string formatting
X-CM-TRANSID: rQCowACXueAED9ZpM6pYDQ--.19818S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZw4rKF1fCFW7trykJw18Zrb_yoW8Jr1fpF
	98Z34qgrs3uw1UGryUtFnY93Z5G3Wvqr48Kw1kKw1UuF1DWFW0yFWSqa4jy3yDJrykGrW2
	vFs8AF15CF45Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_011715_624403_9B5EB04E 
X-CRM114-Status: UNSURE (   6.18  )
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

mconsole_version() formats several UTS strings into a fixed 256-byte
local buffer with sprintf() and no length bound.

Use snprintf() so the version reply stays within the local buffer.

Fixes: e9ff3990f08e ("[PATCH] namespaces: utsname: switch to using uts namespaces")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

---
Changes since v1:
- wrap the changelog paragraphs to 72 columns
---
 arch/um/drivers/mconsole_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index e2a9e8879f58..18d0ec15557c 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -106,9 +106,9 @@ void mconsole_version(struct mc_request *req)
 {
 	char version[256];
 
-	sprintf(version, "%s %s %s %s %s", utsname()->sysname,
-		utsname()->nodename, utsname()->release, utsname()->version,
-		utsname()->machine);
+	snprintf(version, sizeof(version), "%s %s %s %s %s",
+		 utsname()->sysname, utsname()->nodename, utsname()->release,
+		 utsname()->version, utsname()->machine);
 	mconsole_reply(req, version, 0, 0);
 }
 
-- 
2.50.1 (Apple Git-155)



