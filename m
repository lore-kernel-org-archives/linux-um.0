Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D82C678D4
	for <linux-um@archiver.kernel.org>; Fri,  3 Mar 2023 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MhIQtWC/usq4ZjeVYmL9snvV0ObrN4aacgjx9rp2A1Q=; b=Mk2schpgSrA6dF
	XSYiwF/kF0zP5RwQRkUgH3zK/EMPI2FSuXHMkioMQ+GGfIxAY4Ae+SrHpKoOscNCwPAfap3yBmlVh
	h+dZvwUD1uUplMIaIxN720ioQQN7er4ZRVKxZDQyRTR3zaMLFrbrP2g+VdSYczWqZ01T8DID5QgfT
	XIgioAc2mRnnGyuhTS3bOSCS0HZy70MmRA6Cl+MVE+CtvjefhrDiJPeIQl7tSpekEt1T5rCqAIUCB
	u9gAOYuMmTgeP60H6sNyyKD+HQ/5PSpiUikzsKfvCMmbUi4wMwR/YNNOwFVmrXF5JXNR/VxrH65zq
	Y6F40iLDSYgKOYGHmP0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY0uV-005Rj8-IR; Fri, 03 Mar 2023 08:37:03 +0000
Received: from frasgout12.his.huawei.com ([14.137.139.154])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY0sb-005QQW-4X
	for linux-um@lists.infradead.org; Fri, 03 Mar 2023 08:35:07 +0000
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSgyv3tVBz9v7bc
	for <linux-um@lists.infradead.org>; Fri,  3 Mar 2023 16:25:43 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnqQQfsQFk4axpAQ--.11916S2;
	Fri, 03 Mar 2023 09:34:45 +0100 (CET)
Message-ID: <6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com>
Subject: Cannot compile UML in Ubuntu 20.04.5 anymore
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 03 Mar 2023 09:34:36 +0100
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwAnqQQfsQFk4axpAQ--.11916S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWfGw43KF1rAr1UuFyUWrg_yoWxtFg_u3
	W2g34kur1kAr47Cr1rWa1vvr17Ga47Kry5X3WFq348WF9xGFWSk3W3XF93AFyUKws0vr1k
	Ca48XFykur4agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4onZwAAs7
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_003505_366950_3FAC858A 
X-CRM114-Status: UNSURE (   3.51  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

SGkKCml0IGxvb2tzIGxpa2Ugb25lIHJlY2VudCBjb21taXQgY2F1c2VzIHRoZSBrZXJuZWwgYnVp
bGQgdG8gYnJlYWsuCgogIEdFTiAgICAgc2NyaXB0cy9nZGIvbGludXgvY29uc3RhbnRzLnB5Cklu
IGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvc3RkbGliLmg6MTAxMywKICAgICAgICAg
ICAgICAgICBmcm9tIGFyY2gvdW0vb3MtTGludXgvaGVscGVyLmM6NjoKL3Vzci9pbmNsdWRlL3g4
Nl82NC1saW51eC1nbnUvYml0cy9zdGRsaWItZmxvYXQuaDogSW4gZnVuY3Rpb24g4oCYYXRvZuKA
mToKL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdGRsaWItZmxvYXQuaDoyNjox
OiBlcnJvcjogU1NFIHJlZ2lzdGVyIHJldHVybiB3aXRoIFNTRSBkaXNhYmxlZAogICAyNiB8IHsK
ICAgICAgfCBeCiAgQ0MgICAgICBpbml0L25vaW5pdHJhbWZzLm8KCkl0IHdvcmtzIGFnYWluIGJ5
IHJldmVydGluZyBjb21taXQgODg0OTgxODY3OTQ3ICgicnVzdDogYXJjaC91bToKRGlzYWJsZSBG
UC9TSU1EIGluc3RydWN0aW9uIHRvIG1hdGNoIHg4NiIpLgoKJCBjYXQgL3Byb2MvY3B1aW5mbwoK
Wy4uLl0KCnByb2Nlc3Nvcgk6IDMxCnZlbmRvcl9pZAk6IEF1dGhlbnRpY0FNRApjcHUgZmFtaWx5
CTogMjMKbW9kZWwJCTogNDkKbW9kZWwgbmFtZQk6IEFNRCBSeXplbiBUaHJlYWRyaXBwZXIgUFJP
IDM5NTVXWCAxNi1Db3JlcwoKVGhhbmtzCgpSb2JlcnRvCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=
