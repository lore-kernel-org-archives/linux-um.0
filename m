Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9089FDEE4D
	for <linux-um@archiver.kernel.org>; Thu, 23 Apr 2026 22:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Subject:Cc:To:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQVMdPT0W05WSFGyTO5xjCpqytiwI4srcleJk1it/Yk=; b=SCIvK8l58WZDXPpFqxPMTiJKBa
	QkldzL9xFtLe3+g4CVcouAKjqMQMHHhgaRjDOrDUmFPqnQpHAE7PiSYvpqdxfS38BYIs01neSM/3s
	KUxM2TNKgGHpQasRXKJTPlpGPgfPUuz9KL5X0sxZIJieQwhyNj1doS929Kdsj740UMDPf0N64Mdzo
	SiXhtEleV1hSb06m5BYFmgg3uc93T64nhFXUBecM9bw+fhAt88ZxzkA/91BfKviFrVB5NsR5rnFYY
	dBRiwDCCd1YS6hhRfVkDkBw0Iz/jzEZPQ4BU1zvv+cp2cBwGu7dYOHUtuQS/FZ1dRLJwFFN/U8/Cp
	tj98hbEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG2qf-0000000COJi-14hh;
	Thu, 23 Apr 2026 22:48:41 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG2qc-0000000COJG-0m6P
	for linux-um@lists.infradead.org;
	Thu, 23 Apr 2026 22:48:40 +0000
Received: from 06-uml-vector-v2.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAAntwq6oeppDoBsDg--.55735S2;
	Fri, 24 Apr 2026 06:48:27 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 23 Apr 2026 23:35:00 +0800
Message-ID: <20260424070106.1-uml-vector-v2-pengpeng@iscas.ac.cn>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH v2] um: vector: reject too many interface arguments
In-Reply-To: <20260417073704.1817-1-pengpeng@iscas.ac.cn>
References: <20260417073704.1817-1-pengpeng@iscas.ac.cn>
X-CM-TRANSID: zQCowAAntwq6oeppDoBsDg--.55735S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWxXw13Aw4kKFWkAw17GFg_yoWkWFX_u3
	Wqqanrur1S9r4Duw1UKr1rC3ySvFyDWryUCrW0yr9xuw4SvrZxAr40yF1fXw1xX3y7Zrs8
	Gry7G34FyrWFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vE77IFxVWUZVW8XwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JU6v38UUUUU=
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_154838_608614_814D6E66 
X-CRM114-Status: UNSURE (   6.27  )
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
Changes since v1:
- remove the blank line between Fixes and Signed-off-by

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


