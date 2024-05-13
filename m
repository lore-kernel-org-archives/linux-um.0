Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF10BC25B10
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sdYuaBFPSp+zIyDKL2Lix71i/tZ+jK3fWyV6sL7/xTc=; b=VzSf+Uct91SQ7hF//SyCZkqVhA
	f293P+KpFzooPCOcUJtFV/sn64pt+qCtjeDEP1zhMGnllUHysY309LNz0BZSKL9oqCAJuvuyOQ2uo
	fLYJdLQVYdtJ49RjU+fBdZ5hPYD0XrLc/X0r/AnF+7Umnb7xiMpet5HZ3s2Os9xkxuejUz2rxSkgy
	DEvIwvrJzjs5Xyp360txS6M1ljLxyzMMTCJXz+Ie9pkewVe/lxXP4ZLL6lagW/rumNTamVQiGN5y9
	FnnzQu9ssHDfnyNaBej+ZqAGpB/ZsaQB8kt4fmWm8UsB6jd893BNRh2nhP247KIWPp9Sq191YqJ2z
	L5imloIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VTD-0000000Cx2U-0nrn;
	Mon, 13 May 2024 13:11:59 +0000
Received: from frasgout13.his.huawei.com ([14.137.139.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VT7-0000000Cx0v-0d28
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 13:11:56 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VdKFc4Rvmz9v7Hl
	for <linux-um@lists.infradead.org>; Mon, 13 May 2024 20:54:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C0993140418
	for <linux-um@lists.infradead.org>; Mon, 13 May 2024 21:11:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC38SV9EUJmnBMTCA--.48417S2;
	Mon, 13 May 2024 14:11:37 +0100 (CET)
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
	keescook@chromium.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] x86: um: vdso: Disable UBSAN instrumentation
Date: Mon, 13 May 2024 15:10:24 +0200
Message-Id: <20240513131024.1309073-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwC38SV9EUJmnBMTCA--.48417S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy5AF45XFykAF13ArWxtFb_yoWDZrbEkF
	WIqFZ3G34a9397A3y5GFWYvF97Cwn7Arn3u3y3uF13tay5Xas7GFsrG343Xw4rJF9F9FWU
	WF93ZFWUXw4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5lAMQADse
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_061153_508834_D3714755 
X-CRM114-Status: UNSURE (   7.91  )
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

The UBSAN instrumentation cannot work in the vDSO since it is executing in
userspace, so disable it in the Makefile. Fixes the build failures such as:

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


