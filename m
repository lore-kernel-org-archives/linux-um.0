Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F988C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C37iWuxReGiLZkAfXWF1w5IRHGvzGpQ3i/Zp2vQGAAg=; b=YJlzdflykpGvEF
	P8E/blsT0xi2i7TjGPdxBZwb8+8eoqN8dsvacmoyrhbRslmx5Rciw5Y28cPwM4Up01SJsM7j++Xex
	S3kN65YrqmUUZT2WN7pMSYkwv1OYBKannyXGBEiVR7EdpBt2yBGgN1gEnyzVy0PD2pgybRV3/MB9g
	BPQOhd7B5a2JeDa4QKHdhpc8a8mUjBH7P1Z7uQVQpzYgn9iBOY+OhoYySitJyyxbnrG2VTDKdGiHX
	J/hJ+ZsIDdp+iARVMwaIR3iDMaSBjl4XBrVd74s7QyDkZXdGBFOy+kts8l3x+GFQSQYqzzei7p8xu
	Gf7lUFJUcI+tAy4hlqKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUc-007o3p-41; Tue, 22 Nov 2022 10:27:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTN-007nM8-1J
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=C4+XHN7BBREUG7/PyU0yixAZ8+BaDGWADxsoILrdsfA=; b=fBLZZU4RoA3dBInuLFA+loWj1K
	OXTZdJ54qL2CWvJEaXiE7HmtgrEVxFTtZvexwYkR7sZdd7NbmtGTbRPIdlmQ35c9icr8mV/EwId+1
	pXGrla201I1/JZ2/F/v7SFwQTCz9hTY0jy+yWDpbld3zCXkYdc+SBymOX+USLM9qsc0t4E2++UO3+
	dlXSwAMx69fA51yzE7XeUB+qF3PhhybewYUGooFmLp0uwaiC08CrdABXAD+olYWEed3TSSdFU7B3U
	CMhyzYpPlMJ3lqicLjesscayI31vdUB4YqHbnviK9UrNPCdfT22pvlAOIU49pkyuDx9Lhlr/nUQ1h
	1A0/LQcA==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1m-6V
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C4+XHN7BBREUG7/PyU0yixAZ8+BaDGWADxsoILrdsfA=;
	t=1669111857; x=1670321457; b=x4HAzsUFaecPFlgzdTHQ6YLAB+w3dGTicELpoCyey4kvuG3
	LZVFjHd+D+An6v/dFt2hCWhmHeTApC11N2NxuDBcQLXl0zDGTtoStOocF6RwKE34ko3JmNAVn4USP
	s+cs9JfigEHzGAFgNl/kLs9BaB1iJbe2MiC4Sf2wWorr83teutpW1+q+I6rlOoTa4lnwb6/AyCAoE
	KXarI5SRWDA4VAGL5pybVUpkg3b0uerLR2B9XLujwGMuV6R5aZxXRwEpyxmgyw0RiXdCgFeFfEcNA
	IoovT8Z8UuwUAY19no1t/H+80y8aisTRHq830xJ1h+ozTcsxHC4NMHVqdFx2uzZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEp-006IGn-1m;
	Tue, 22 Nov 2022 11:10:47 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 13/28] um: Mark 32bit syscall helpers as clobbering memory
Date: Tue, 22 Nov 2022 11:07:44 +0100
Message-Id: <20221122100759.208290-14-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101059_579325_3DC83FE6 
X-CRM114-Status: UNSURE (   7.38  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

The 64bit helper are marked to clobber the memory, but the 32bit ones
are not. Add the appropriate clobber to the 32bit helper routines so
that the compiler cannot do invalid optimizations.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/shared/sysdep/stub_32.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index dc04d8cc2791..cdb3396679e1 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -16,7 +16,8 @@ static __always_inline long stub_syscall0(long syscall)
 {
 	long ret;
 
-	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall));
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall)
+			: "memory");
 
 	return ret;
 }
@@ -25,7 +26,8 @@ static __always_inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
 
-	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1));
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1)
+			: "memory");
 
 	return ret;
 }
@@ -35,7 +37,8 @@ static __always_inline long stub_syscall2(long syscall, long arg1, long arg2)
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2));
+			"c" (arg2)
+			: "memory");
 
 	return ret;
 }
@@ -46,7 +49,8 @@ static __always_inline long stub_syscall3(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3));
+			"c" (arg2), "d" (arg3)
+			: "memory");
 
 	return ret;
 }
@@ -57,7 +61,8 @@ static __always_inline long stub_syscall4(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3), "S" (arg4));
+			"c" (arg2), "d" (arg3), "S" (arg4)
+			: "memory");
 
 	return ret;
 }
@@ -68,7 +73,8 @@ static __always_inline long stub_syscall5(long syscall, long arg1, long arg2,
 	long ret;
 
 	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
-			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5));
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
+			: "memory");
 
 	return ret;
 }
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
