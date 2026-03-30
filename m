Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA753FF4946
	for <linux-um@archiver.kernel.org>; Mon, 30 Mar 2026 06:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xv6/ZeDGYexoa/mwjc+SiZM70Leb/BKjtuZKejAsOyQ=; b=1Iw9RCf5p/dApNm5pjTeRXR48K
	TljMl0DwGxPsTeVFOVtoZmw8aBKMYZ+IIfQsRJBOMewVvVVxe6B6TxYpFly/EJ3f7g005EH2FpZym
	RKHYxTbp4Fmd/n+DMmFTV7AkcaxCMIXe3aC+HOblZGGLSawZgeWXDDnW+wmcyQ09vxDalfhRiZjdo
	mXMEVvRbKErX/oCxLiU7QfKEAQIkYKFTqFrF79qs9v51HdoWI9zIk3xnW1F6FwAo1BZJyPHqfeZrW
	ldLbYwAJ2c2MFijNm0TVmxrKjosT4rnFF83udSNIdusotUMo0jPx4OmS0QnWTcA08GHd8XdWPZkDM
	RyxfkBDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w767x-0000000Agqj-2j79;
	Mon, 30 Mar 2026 06:29:33 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w767u-0000000Agps-14EM
	for linux-um@lists.infradead.org;
	Mon, 30 Mar 2026 06:29:32 +0000
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAC3Sw9BGMppOoTpCw--.28728S2;
	Mon, 30 Mar 2026 14:29:21 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 4/4] um: account for the separator in add_arg() bounds checking
Date: Mon, 30 Mar 2026 14:29:21 +0800
Message-ID: <20260330062921.40824-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAC3Sw9BGMppOoTpCw--.28728S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF47Zr4xAF48Ww18WFWUtwb_yoWkArb_Wr
	n7J3WkZr1xu3W2qF13W3yrZrySv397tas2kw1xu3yYkwnrJay8uws3tFs5Xr15Wr1fA3yD
	X3s5tr13Ar1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5oGQDUUUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260329_232930_666889_CFCC8B18 
X-CRM114-Status: GOOD (  10.46  )
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

add_arg() checks whether command_line and arg fit in the fixed
COMMAND_LINE_SIZE buffer, but when command_line is non-empty it inserts
an additional space before appending arg. The current guard does not
account for that separator, so a non-empty command line can pass the
check and still overflow by one byte.

Count the separator when command_line already contains data.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/um/kernel/um_arch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e2b24e1ecfa6..93eebaf1d236 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -44,7 +44,12 @@ static char __initdata command_line[COMMAND_LINE_SIZE] = { 0 };
 
 static void __init add_arg(char *arg)
 {
-	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
+	size_t len = strlen(command_line) + strlen(arg) + 1;
+
+	if (command_line[0])
+		len++;
+
+	if (len > COMMAND_LINE_SIZE) {
 		os_warn("add_arg: Too many command line arguments!\n");
 		exit(1);
 	}
-- 
2.50.1 (Apple Git-155)


