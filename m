Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ACCC25B10
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GpdWGEdILwXUM5/6KEOu/j+5xR1+Z8Cw14e6tYCwgew=; b=CDktDYUOFsfp2uQPOXhYh4kn7Y
	VEWicLy07lUT3NvAPtmGwQsPOCEXy7+TDEPzLYZY31ObqGnsCP4BijTpdnMfNQ8xXokQSAd6Nx2LT
	JVJFUx9waO4LiMwXpKhnl3GGNo+y8ntJ9LCPpiN0oKlCuJh9qv/QGTho0YTDQjHLxPw5cr8GWTiMY
	2Y+wG8XhoHrGatxSM3BrbTuq98glYpV6rDKGbaJtUg4k37hjTRpMiGd+iWdgj7cp/LedQgRXLS2na
	Gul6nClvnbk1NqpZdGA+Nzvk1gya7F09/0qvScLIp07mZRSVEHbebpQiqJ6GKaYKvCDVqT8DME1hM
	JNGPdwkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6UnW-0000000Coue-0ncJ;
	Mon, 13 May 2024 12:28:54 +0000
Received: from frasgout11.his.huawei.com ([14.137.139.23])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6UnS-0000000CorK-3B6A
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 12:28:52 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdJHn18MYz9v7Hm
	for <linux-um@lists.infradead.org>; Mon, 13 May 2024 20:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4BE5B140414
	for <linux-um@lists.infradead.org>; Mon, 13 May 2024 20:28:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3LyRfB0JmiJMSCA--.46264S2;
	Mon, 13 May 2024 13:28:25 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: x86@kernel.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] arch/x86/um: Disable UBSAN sanitization
Date: Mon, 13 May 2024 14:27:54 +0200
Message-Id: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3LyRfB0JmiJMSCA--.46264S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW5Gr4fZw4fur4kuw4xXrb_yoWDWFgE9F
	WIqFZxJ34fZ3ykJ348KF4YvF93Cwn5AryS9w43WF13ta15XF97GF4xG343Xr45J3ZFvFWU
	GF93ZFWUXr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5k-yAAAsb
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_052850_945667_87D46C22 
X-CRM114-Status: UNSURE (   7.80  )
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

From: Roberto Sassu <roberto.sassu@huawei.com>

Disable UBSAN sanitization on UML, since UML does not support it.

This fixes the error message when building the kernel:

  CALL    scripts/checksyscalls.sh
  VDSO    arch/x86/um/vdso/vdso.so.dbg
arch/x86/um/vdso/vdso.so.dbg: undefined symbols found

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 arch/x86/um/vdso/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b86d634730b2..ca79c0de582e 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,8 +3,10 @@
 # Building vDSO images for x86.
 #
 
-# do not instrument on vdso because KASAN is not compatible with user mode
+# do not instrument on vdso because KASAN/UBSAN are not compatible with user
+# mode
 KASAN_SANITIZE			:= n
+UBSAN_SANITIZE			:= n
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT                := n
-- 
2.34.1


