Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A814F8E4B6
	for <linux-um@archiver.kernel.org>; Fri, 17 Apr 2026 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7vdHnEyb1fD9r2mCCkttgb+9H3gpnpt2zBEX+XuGA9A=; b=NzBxf97reRn7+ksYDuXo5awdkV
	yGZUNFzhFDxJ91oVuDkEeyNaRjah6zcGDKZibT5iEJug2mpjxzKexEG+IDGuEQSGJI3TXZ8yzif4l
	2mIo9rPMh6K0IggvI/BmjY4GJbvoHEHROZZVyggmUtJoOwG+84sSIjebPFl8Ewof+g0TuRerZ3KXG
	PzjRhmOHRYzXlsJLH+q91vLOYlL+12nUlKjt1ZOOlz/8WkJ2/P/a3almHLZMlt4MHqsLSXYSZzlrk
	fZhsImwBhouOTWFB/WJHigoWv3f6sXol2dzlI5r9xS5WmIEQPmzgG8ZRhrEhMlD2BeH7zkQ7C/K8T
	IWC6Ak+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDdlJ-00000003bni-2c7K;
	Fri, 17 Apr 2026 07:37:13 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDdlF-00000003blq-3pSr
	for linux-um@lists.infradead.org;
	Fri, 17 Apr 2026 07:37:11 +0000
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADndwsi4+Fpg_PXDQ--.78S2;
	Fri, 17 Apr 2026 15:37:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] um: vector: reject interface specifications with too many arguments
Date: Fri, 17 Apr 2026 15:37:04 +0800
Message-ID: <20260417073704.1817-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADndwsi4+Fpg_PXDQ--.78S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWxXw13Aw4kKFWkAw17GFg_yoWkWFg_Cw
	1DXanrGF1a9r4DCwn8Kr1rC3yFvFyDWr1UurW0yr9xuws3ZrsxAr40yF1fXw1xXFW7Xrs8
	Kr9rG34Fvr4SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj2YLD
	UUUUU==
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_003710_326845_7AD3F23F 
X-CRM114-Status: UNSURE (   8.87  )
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

uml_parse_vector_ifspec() stores parsed key/value pairs in the fixed
struct arglist token and value arrays, which are both sized to MAXVARGS.
The parser increments numargs as it discovers pairs, but it never checks
whether another slot is still available before writing into the arrays.

Reject interface specifications that exceed MAXVARGS instead of writing
past the end of the fixed argument arrays.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/um/drivers/vector_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 2ea67e6fd067..3bee634f2102 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -93,6 +93,9 @@ struct arglist *uml_parse_vector_ifspec(char *arg)
 	len = strlen(arg);
 	for (pos = 0; pos < len; pos++) {
 		if (next_starts) {
+			if (result->numargs >= MAXVARGS)
+				goto cleanup;
+
 			if (parsing_token) {
 				result->tokens[result->numargs] = arg + pos;
 			} else {
-- 
2.50.1 (Apple Git-155)


