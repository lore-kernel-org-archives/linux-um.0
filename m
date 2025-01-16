Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6738CC02180
	for <linux-um@archiver.kernel.org>; Thu, 16 Jan 2025 10:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Zwhko6xqZpgutIeQHlaZpbldv56TeVrrz4iraqdjPA=; b=rkJub8txEY4Y8kTXeDlf1/H5if
	eAnkWTkm+VWIIxBY03Z1laWT+pR+j/oZZo+S4NRdruor2vTK9tqBuRR3gnY16K//cejG8fJchwyIp
	QixjKgR9CbpWIf3Ip26+o4M+2UJ6J0dq8bbw2cLfYZiH1h0eWhC38oN9TyHEd4HhZcLednOgWBoVt
	IRBg8BOV/9698W802kyGvrzyflpLWiL/kP/l8g1woifnsrIaEWOdpBHRlnovHVuisfqdigI7a3+bw
	KQ8Kdcm6wc6cA0IhgAGaFEjKN3Lrrn8LVMKOgTq1qFWoM72PwA3WyclVTpsqFEVQ0szjAZnsVYprb
	w44R1nhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYMos-0000000ESgW-0xqw;
	Thu, 16 Jan 2025 10:09:46 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYMoq-0000000ESg7-1Dd6
	for linux-um@lists.infradead.org;
	Thu, 16 Jan 2025 10:09:45 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2166651f752so15414125ad.3
        for <linux-um@lists.infradead.org>; Thu, 16 Jan 2025 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737022183; x=1737626983; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Zwhko6xqZpgutIeQHlaZpbldv56TeVrrz4iraqdjPA=;
        b=AaxLwCqZXo6Jtm6Eu4ZMJTvJWcEi94f/h3B0rkGAVPMsf+JU8+ZoRR2vFmKHTPogSu
         /UHXUs/ZEfMFBTVeGvfvuPFSKkLSX9Ecm3zLbAjhAzvnAluMfUDkXDTEaLanZ4kune8s
         HNdex/x6+HWhCNgXxK+LFJ2mHiwpYPiEArFhzPmqCjQP+L3GhH7kdbifzn1GUq9P+o0N
         EmC5dhbqdh5mEddiSh7Jd36xwDw0IyjinJ5c8XIZm2Z2KTUiixPGUw2X7KURyhxblzUA
         HenMtkA9zl/hgzVuPrOpXUDfHkumKrXlz5XmoRzsSA2Ochgq99ulLRYMKbHHLkLWpiLW
         PZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737022183; x=1737626983;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Zwhko6xqZpgutIeQHlaZpbldv56TeVrrz4iraqdjPA=;
        b=ou7upQ9zichevLmR8ikrhx2jjQvqE5FQiHtWW3JjFYnP/uDSS8uZZbLAEav5IeFjfy
         mJktc50YNTJbbsRjLdvAeBTelGtgTZaHsUspInKQefPOch5Vc/KNE9bkTziUxDl+Arpj
         l33WiSN5QS+Sc0yJZ/pk4F+QeUnKhrgZtmqJQgriz6Tqs5VVG3K/hsDYoPmdfFNEJTkg
         kZxBIAfgnU344eEnzQXO0mQ+R3xsiTG3P2oBgCuhiDY7gHBqKUIdzt6UFvnV1aQC8oH2
         J0czZo5Ohvbub6TLD7wg8x/tA4rFsGmh9U8IiW0NFInb6vD4LlA7JQLDuNV6eN5z5gIQ
         fPXw==
X-Gm-Message-State: AOJu0Yxq7T9My9hqWXNEKpA0qpGw3wVYhfRDvYOpG3M/rPXuSQLj+Tit
	SmklDsBBFR1zxWuVgFyTLQI5ua20VXLQL3YjyLGUS7xJKNDI/Afp
X-Gm-Gg: ASbGncvFOmf1tx+2RzRRqu2+axB9SZFdOOxY6rC53lPQrUpxO+VkSRuLFQmDIt6W+Gr
	AsUG6un3YadOt+HKyu9PR2AQSM2qkGFJnXEnyu6q4fjxym9Xw87K9Q35IQ2EMx3duoI8am8zs4J
	IZ4tT/9ZNqzdMT7RXf78jjOms/YwHiwIG92aYI6lqXUQ8f0bL6j0hDyHvRz5UXcqUhm6p/HA2aQ
	Oshv//HOJdXru5D8+Cpb06W9+kSub8iJYrBLSbTSfS5PocI1zavhtwzGKWmoHJxhAZtjdXyDi9l
	vGv8WnSRrkfR+n0Nx84PVQEIdp6iYHH9EWL/7VdroHE=
X-Google-Smtp-Source: AGHT+IEDEqbxScPBGv4ZU+tsKeDbG85yxndxB9MZV1MmYzRYNqhFIMisgV17oE3TblnMLBhkQTP5zg==
X-Received: by 2002:a05:6a20:c890:b0:1e1:a647:8a3f with SMTP id adf61e73a8af0-1e88d1d5a8dmr57778498637.22.1737022183153;
        Thu, 16 Jan 2025 02:09:43 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm11057771b3a.173.2025.01.16.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:09:42 -0800 (PST)
Date: Thu, 16 Jan 2025 19:09:38 +0900
Message-ID: <m2jzav3w9p.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v6 00/13] nommu UML
In-Reply-To: <6060a0e25f2b7903002e55182230da09c702b0e4.camel@sipsolutions.net>
References: <cover.1736853925.git.thehajime@gmail.com>
	<3db55c1586f66718c871b678ec10d6c2aa88fbb3.camel@sipsolutions.net>
	<m2cygo6hyl.wl-thehajime@gmail.com>
	<6060a0e25f2b7903002e55182230da09c702b0e4.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_020944_336952_835BF3EC 
X-CRM114-Status: GOOD (  39.40  )
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


Hello,

On Wed, 15 Jan 2025 18:30:41 +0900,
Benjamin Berg wrote:

> > > Maybe I am missing it, but I do not yet see proper FP register
> > > handling. This will be needed for task/thread switches and also signal
> > > emission/sigreturn. I am attaching the test program that I used to
> > > verify the correct behaviour when dealing with the recent changes to =
FP
> > > register handling in UML.
> >=20
> > thanks for the test program.
> >=20
> > I didn't address your comment on FP register handling as I couldn't
> > see any reproducer that causes the issue you raised (and maybe didn't
> > understand well the problem) so, the attached program helps a lot.
>=20
> Note that it doesn't directly test task/thread switches which only
> happen due to normal scheduling (i.e. via SIGALRM). So, it doesn't
> cover everything, but syscalls and signals are quite important by
> themselves. For normal UML both cases hit the same codepath, but I
> think in your case the SIGALRM entry point differs and should be tested
> separately.

indeed, scheduling works a different in nommu from normal UML.

> > Though nommu code only works with musl-libc, which I cannot use that
> > as-is, now I see what you meant with the first function, test_fp().
> >=20
> > (none):/# /root/test-signal-restore
> > pre-signal: 0.5
> > post-signal: 0.5
> > floating point register was not manipulated
> >=20
> > Tests on task switch (test_fp_ptrace) might need more work for me as
> > nommu only works with vfork(2) and vfork without exec(2) may not test
> > well on the implementation.
>=20
> Not sure you even have a working ptrace in nommu?

I don't think so.

> That reminds me. Please set arch_has_single_step to zero for nommu
> mode. If you figure out how to set the appropriate bit in EFLAGS when
> returning to userspace, then that would also work.

thanks, I'll fix this in the next revision.

> > and also I'm wishing to have this kind of useful tests as a reusable
> > way; as now I'm going to add a new configuration for UML, you're also
> > going for another SECCOMP mode over MMU, we may have at least 3
> > running modes for UML, which I think we should share the test
> > framework that we should pass.=A0 Not sure how it should be but using
> > Kunit is the first thing in my mind.
>=20
> My problem was, that I didn't know of a good place to put it. We could
> probably drop this test into tools/testing/selftests/x86, but how is it
> run then?
> As for kunit, that would be neat, but I it seems a bit more complicated
> to run userspace code from within the kernel.

thanks for sharing your experience.
I'll look for some nice place; for the moment, I would work with a
private/local environment.


for the fp register handling on syscall/signal, it is going to be like
this, not fully tested/verified yet though.  with this, single syscall
adds 80 nsec delay (in my environment), which seems reasonable to me.

diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_sysca=
ll_64.c
index 796beb0089fc..48b3d29e2db1 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -48,6 +48,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
        /* set fs register to the original host one */
        os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
=20
+       /* save fp registers */
+       asm volatile("fxsaveq %0" : "=3Dm"(*(struct _xstate *)regs->regs.fp=
));
+
        if (likely(syscall < NR_syscalls)) {
                PT_REGS_SET_SYSCALL_RETURN(regs,
                                EXECUTE_SYSCALL(syscall, regs));
@@ -66,6 +69,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
        set_thread_flag(TIF_SIGPENDING);
        interrupt_end();
=20
+       /* restore fp registers */
+       asm volatile("fxrstorq %0" : : "m"((current->thread.regs.regs.fp)));
+
        /* restore back fs register to userspace configured one */
        os_x86_arch_prctl(0, ARCH_SET_FS,
                      (void *)(current->thread.regs.regs.gp[FS_BASE
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep=
/ptrace.h
index 8f7476ff6e95..7d553d9f05be 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -65,7 +65,7 @@ struct uml_pt_regs {
        int is_user;
=20
        /* Dynamically sized FP registers (holds an XSTATE) */
-       unsigned long fp[];
+       unsigned long fp[] __attribute__((aligned(16)));
 };


-- Hajime

