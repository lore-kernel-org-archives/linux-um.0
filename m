Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B38C46CA2
	for <linux-um@archiver.kernel.org>; Fri, 15 Dec 2023 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/RtAnJXmdqql3S5s+cOjOsOvIvsbnGXhZr8LvLkQ/1A=; b=boVj9+utupt/Yw5X5LPmlzYFy5
	KEtyUXlX0SfC+nwnNIMQbgqImlED7CJGDNqessKC+BU6pcYyT7mGX6iCN/aKw5+jLFInWkMH4uYqt
	uqri+4NWybCYRLK6xpW2IZsiszfc7yEtTLwt90nRBddbggaRE0437F4XqCflZWqQMvBiU++Vzr1G4
	LlQLkdDCtzh5WM8e5dqDuNXqFcAsXHJVSgQPgbDiHxkxJPx8wzOy10jTh6fiD0bs768dAe1tO84BP
	52SNLsaBw+JqN4iCcMDxBzo+W0H0+ZoOiZDcKc2QgkUNR5mnPr8kepWnzYkxtAtxFs7kOd2ie18fX
	pc8D1D3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE76G-003C0x-2m;
	Fri, 15 Dec 2023 12:15:28 +0000
Received: from frasgout12.his.huawei.com ([14.137.139.154])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE76C-003Buk-2V
	for linux-um@lists.infradead.org;
	Fri, 15 Dec 2023 12:15:27 +0000
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ss75157Cpz9v7bj
	for <linux-um@lists.infradead.org>; Fri, 15 Dec 2023 19:57:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 13B081400F4
	for <linux-um@lists.infradead.org>; Fri, 15 Dec 2023 20:14:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.148.243])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV86Q3xlRz6QAg--.57272S2;
	Fri, 15 Dec 2023 13:14:57 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH 0/2] um: improve UML page fault handling
Date: Fri, 15 Dec 2023 13:14:29 +0100
Message-Id: <20231215121431.680-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCnpV86Q3xlRz6QAg--.57272S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWw1UGr4kJF4rXw1rKryfJFb_yoWxWrX_AF
	y8trWUGFWjyFZIvay5ta17WFW29FWvgFyxA3Wkt390ywn8Z34UZas8tFy5Xr93WF4rur1k
	ArnxJrn7Krn7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0Ew4C26cxK6c8I
	j28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj0JPt
	UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_041524_976060_7B6351C6 
X-CRM114-Status: UNSURE (   5.57  )
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

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Improve UML handling of segmentation faults in kernel mode. Although
such page faults are generally caused by a kernel bug, it is annoying
if they cause an infinite loop, or panic the kernel. More importantly,
a robust implementation allows to write KUnit tests for various guard
pages, preventing potential kernel self-protection regressions.

Petr Tesarik (2):
  um: do not panic on kernel mode faults
  um: oops on accessing an non-present page in the vmalloc area

 arch/um/kernel/trap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

-- 
2.34.1


