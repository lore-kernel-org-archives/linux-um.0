Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E530C4332F
	for <linux-um@archiver.kernel.org>; Fri, 23 Dec 2022 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pwNAXeus1uAsWglXooJiqGP2/1/V3azboru/FK/4MHI=; b=Asyn4gq4MJ6436
	vtC7E9+oEoEU0aEHpD85JGkdkG53VHmJwgGpsF0wr8hIGQ1ILAySO7ZTdhhktdDfWBFw4HLlKVz0x
	yLOrqHSI8UCEgBisnTA3rbhty1oherew+osKGqgij47c+HehNFoFbDk7VeuGKNwrGsVBCUAzbRoLQ
	cNYfpuhbhBUPmy7HKevJvQ16rLye6yvwPqCLd3tbvLRKtc90sa5BAfNSg2RODM036W/Ws3miGfPZz
	KfwQcNNpjtkeYKv9CUHCIILjrN+1R0ggfD42FhnqTOixZlsXvMf8CVA+PywKmubpbfYZuO7GmWNAe
	5fTdluQp3n4BztMQJg2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8lo2-00AOu8-Jl; Fri, 23 Dec 2022 17:26:02 +0000
Received: from gnuweeb.org ([51.81.211.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8lo0-00ANnc-IU
	for linux-um@lists.infradead.org; Fri, 23 Dec 2022 17:26:01 +0000
Received: from localhost.localdomain (unknown [182.253.183.184])
	by gnuweeb.org (Postfix) with ESMTPSA id C0A467E2B5;
	Fri, 23 Dec 2022 17:23:46 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1671816232;
	bh=A+XWNt0Nw1fJTM/CspO4FSOwWhPIKN6FwGIstBqw8HU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ro5GbXoBTmgecVAU657w8poz0f6nNSJW2o3oA+t6QT6A3qUZIQupHqzt3xsYHLIE+
	 3IfQm1dn/PFBo2p5GE+5YDDdczJOgJYtdheUGNggZ3AyYOd1jkEBAjuUEN6cIFLkpB
	 eYUZ7sBNsANUhFLz0DDBhNSCS/2sg8RMPmpCQOd67upX+b0bXZ0t3HtoxCXjKWP46i
	 K05FFLyXR+SulclW/LyEPYWUPNiLiBEgA2yB0PgQscikxjI3VctWV0HKpaJB50emot
	 eMx1yZr9ycaCNBV50AU5Gsv7fhpEJprEQuzNKsASPeACLZ7IbnMrcwKSXp5rNqYyBt
	 V04dWcbPg/+qw==
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: x86 Mailing List <x86@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux User-Mode Mailing List <linux-um@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1] x86: um: vdso: Add '%rcx' and '%r11' to the syscall clobber list
Date: Sat, 24 Dec 2022 00:23:38 +0700
Message-Id: <20221223172338.3813186-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_092600_651448_6CC40618 
X-CRM114-Status: UNSURE (   9.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

The 'syscall' instruction clobbers '%rcx' and '%r11', but they are not
listed in the inline Assembly that performs the syscall instruction.

No real bug is found. It wasn't buggy by luck because '%rcx' and '%r11'
are caller-saved registers, and not used in the functions, and the
functions are never inlined.

Add them to the clobber list for code correctness.

Fixes: f1c2bb8b9964ed31de988910f8b1cfb586d30091 ("um: implement a x86_64 vDSO")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/um/vdso/um_vdso.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 2112b8d14668..ff0f3b4b6c45 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -17,8 +17,10 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-		"0" (__NR_clock_gettime), "D" (clock), "S" (ts) : "memory");
+	asm("syscall"
+		: "=a" (ret)
+		: "0" (__NR_clock_gettime), "D" (clock), "S" (ts)
+		: "rcx", "r11", "memory");
 
 	return ret;
 }
@@ -29,8 +31,10 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-		"0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
+	asm("syscall"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday), "D" (tv), "S" (tz)
+		: "rcx", "r11", "memory");
 
 	return ret;
 }

base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
-- 
Ammar Faizi


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
