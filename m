Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB5210D1495
	for <linux-um@archiver.kernel.org>; Sun, 29 Mar 2026 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vPUDs9herVbVdCq0bGYVZbmn199dX3bbrORgulYooRg=; b=n1lBtE05t9gqxF5zQ3i8ov1W7C
	WrYMCDNP0IKpiRaFdUkeY89vWHimSI4ak8zZuWsAxcEtG1SloSaWNBCrnj0uO/pJFgv5PtQV+vOea
	ah2mvRHdAfaohS++Qk8hUe5VlaB2TnbR7uxcBpPqaUvxFfnBlKD/rf2qkzpTRTODXZxl7qZ+xOEzG
	2zPjOFMw7pxc8Ox8nKNkYY9CcCSMYFBqKGC7sr/RpWgW8UtGgcm3Ehw9bc4aLv/+123LRUL/Fy9SZ
	7oGVkw8zCOMacgYWoyMDUuXsoJUrrPTajnZ1yoJUM1Lpn014oY/y4drfN0xHNISzjZ4uUNlP0c55T
	F//YW0og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6gXF-00000009VfV-0oPc;
	Sun, 29 Mar 2026 03:09:57 +0000
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6gXB-00000009Veb-2n5R
	for linux-um@lists.infradead.org;
	Sun, 29 Mar 2026 03:09:56 +0000
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAB3IGz5l8hpjed8Cw--.19840S2;
	Sun, 29 Mar 2026 11:09:46 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] um: mconsole: validate notify socket path length
Date: Sun, 29 Mar 2026 11:09:45 +0800
Message-ID: <20260329030945.32368-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3IGz5l8hpjed8Cw--.19840S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWkJw43Kw4xXr4UJr45GFg_yoWkXwcE9r
	y5Zws3KryfuFyDtF13Cwn3XrWak34kZFnxuF4jqFWaya43Wr1akrWvy3sxur1UWr1rWFs7
	Aas7AryF93WjgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUU
	UU=
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260328_200954_088544_1B8F002D 
X-CRM114-Status: UNSURE (   8.26  )
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

mconsole_notify() copies the notify socket path into sockaddr_un.sun_path with strcpy(). There is no local check that the supplied path fits in the fixed Unix-domain socket path buffer.

Reject notify socket paths that do not fit in sun_path instead of copying them blindly.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/um/drivers/mconsole_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index a04cd13c6315..2c0d2984055c 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -198,8 +198,11 @@ int mconsole_notify(char *sock_name, int type, const void *data, int len)
 	if (err)
 		return err;
 
+	memset(&target, 0, sizeof(target));
 	target.sun_family = AF_UNIX;
-	strcpy(target.sun_path, sock_name);
+	if (snprintf(target.sun_path, sizeof(target.sun_path), "%s", sock_name) >=
+	    sizeof(target.sun_path))
+		return -EINVAL;
 
 	packet.magic = MCONSOLE_MAGIC;
 	packet.version = MCONSOLE_VERSION;
-- 
2.50.1 (Apple Git-155)


