Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708AC44506
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aT1mgykKIjplp+s22AEABT75vPOdQw6AoiJWmWFEB/s=; b=Xu6oo1j/xZBtpoUWBNrBN3T9sg
	dbvVJF9uAJx66C6eWnMiXqe1FlyLutH20HmInU9/JiaZqOYQp7gsQqZChkN15gu8221Kv5hN65/1O
	Z4f0GZIfbrQeYLa+keefkMM44RX9j2f7GGT3gSXhsIXvoBEXUslYNtQ+Eh1xHIaHUyhFbaYf41pST
	3VWBZ/vxByHBO6H3HJSn7qtCVXt1roh0hhEx21xnWKDzFUrCYpSKLxiZflqVeAW2ccTQa9WGEXbev
	70cl5VCVNCQLcnkmQkzFiS9eQ5NMrSpjPHS7U1xhgPfv19KSHCy/EPiYeVnB2LG3Oy6Zf+qmmLF+1
	wwdWml9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEW-00000005jiD-2CCY;
	Fri, 10 Jul 2026 20:54:04 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIET-00000005jgE-3P1f
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:54:02 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-381507c9380so1023134a91.0
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716841; x=1784321641; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aT1mgykKIjplp+s22AEABT75vPOdQw6AoiJWmWFEB/s=;
        b=MuXV6FR5HU/dsNu21Pq7Bfs0uWI/15MyGh0NHjwtywq7CbI1/0WnaTiCV7rLqEg7em
         MJGngzUhozmYIbLofZ3a90TjTBNCTCJndrLt/xMfpuAgwk2P9BzZjELfYAJwVaov+fwN
         PL34mV0NIn6ACNk94e7NR7329otocuzhBDGR50hupCtuZAP1b09yUvWMSajufstylaWt
         dP2QydEYg4PLDY3arU/nihwvAhmtiP1xormyZetUTMc0xDDSf/hkIG5gAxQvynzD00+b
         ZGp0j4M7kbb+KSO+Ytl9cPZJ5Xax9lDT0q+Jge5qrOAIv9TJ/rG5v2NX8mFDF5/kQbjR
         nArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716841; x=1784321641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aT1mgykKIjplp+s22AEABT75vPOdQw6AoiJWmWFEB/s=;
        b=jUISYT8SFxdN/bwFUVwXFFj5qUzflwMgv1/JfI4458+4J/ggqbUcgWAikOzm3An6ko
         90lKL4lr4uH0N9I9LdA1h96XPqeKf7cUw7iYCEXvbreJ5y6pp+P9fuYszlWuuYqRG/Md
         85UKPyGtIVwN+6JRdgZGLJZrKaeu7M24iAaNTvd3R+/iCJtUe5E3/f8nqt7vy9LP09Wd
         X5wEEY32AkaSRV4vgukeDRgujyF+1bitO8TNno7U4AuD9Wvi1LlFSQ9y48MpnXskMOMj
         /GHyzxU+hjONdqBFHdmNKFl3xwAlHOBpjNpDbrM7zQew/KZ9PPQ2AelH3IMRfbRunETN
         H/iw==
X-Forwarded-Encrypted: i=1; AHgh+RoTRsKxN78X0PceZr7lTvStBui1hIoOfnigdit/+wcOg+Ckc5HhEHbTOk8m29zo9g3BWjOlGsGD5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxy74UOIAjWnnaco9rKYq3zqSTBVAqteF2AD9IiaGNDmioHs9nq
	a7g1rHrOYLDWhgPAhaZPwDbHlHN/siOWju3aP2YBtnCV/+DSObMB2bGH
X-Gm-Gg: AfdE7ck/iun+sxQ06+DWlS9QFQTcWgAFURP38wLZFfVez9dGunSpNu3CeATbrCO3L98
	LczP6C2P+wVDP9miUkQp7LEw2NXwTJNB7fZWDkvJTytdYLVshBrJUqlYgi6j+ifhkm2yZCZzswT
	cV24Ug+1VGbG5RcC4N0fGAD7n+IeWMKTlGIJER1hElCrFAPRp374qt7mTTYBzxFryFXkEmdkNBT
	KfHsRizk2uFQIlncfxjBoRBgwj+z4s4GZpCzhlxNbduqfszk9xXEmovIgiBgRedxYKpFi0b2lEC
	HWqmYfk+ryL9PkI1Ma8S7DStR00e7MX5lWsyCrAG44+x7Nar9T2thIhF+naPGSB27Ct6P56v/CY
	z4m2PaP7+WIy2V/B1FgRbUAAAfjSlg90SRwWiXIlk+/s1jqpziZe7JFjTU3VehVKTascS8735Jh
	aFHgMRuxF7ZEQxpFFHV9YiMElnTfiaB9KDVPW1eBS+GAa93H0aF1hQ8s0=
X-Received: by 2002:a17:90b:5545:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-38dc74d0274mr494219a91.4.1783716840931;
        Fri, 10 Jul 2026 13:54:00 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:54:00 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH 4/6] um: forbid mmap/munmap in the stub seccomp filter
Date: Fri, 10 Jul 2026 13:53:22 -0700
Message-ID: <20260710205324.1343217-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135401_853736_B4446347 
X-CRM114-Status: GOOD (  11.85  )
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

From: Cong Wang <cwang@multikernel.io>

In seccomp mode the monitor now installs all guest mappings via
pidfd_mmap(), so the stub has no legitimate need to mmap/munmap after
its filter is in place (the pre-filter bootstrap mmaps are unaffected).
Drop the STUB_MMAP_NR and __NR_munmap allowlist arms and fix the jump
offsets; both now hit SECCOMP_RET_KILL_PROCESS. A hijacked stub can no
longer map arbitrary physmem. The filter exists only in seccomp mode,
so ptrace (SKAS0) is untouched.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/kernel/skas/stub_exe.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..a88274449168 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -165,16 +165,18 @@ noinline static void real_init(void)
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 offsetof(struct seccomp_data, nr)),
 
-			/* [10-16] Check against permitted syscalls */
+			/*
+			 * [10-14] Check against permitted syscalls. mmap and
+			 * munmap are deliberately absent: in seccomp mode the
+			 * monitor installs all guest mappings via pidfd_mmap(),
+			 * so a stub that attempts mmap/munmap hits the KILL at
+			 * [15].
+			 */
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
-				 7, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_recvmsg,
-				 6, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_close,
 				 5, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_recvmsg,
 				 4, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_close,
 				 3, 0),
 #ifdef __i386__
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_set_thread_area,
@@ -186,10 +188,10 @@ noinline static void real_init(void)
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
 				 1, 0),
 
-			/* [17] Not one of the permitted syscalls */
+			/* [15] Not one of the permitted syscalls */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
 
-			/* [18] Permitted call for the stub */
+			/* [16] Permitted call for the stub */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
-- 
2.43.0


