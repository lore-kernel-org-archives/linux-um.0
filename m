Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2CACA5FED
	for <linux-um@archiver.kernel.org>; Tue,  6 Oct 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=; b=GEeT9ya7HJCJUyjheN/mm/KMLJ
	yIybLXU5NbfmX+Qq1kZkLLEw5F4mbTPfB1u8ROIcTx/kBlbSDOacLBL19P12Hc/LORv09u3Zz1tN3
	zSWGr8G55LK2LnpSJ9I0wwxkbhhFd1cjmgwbq1JwOvFjZ7YSWauY+Bf27moeRcx1FyEEBRn3zuVV3
	SsLO+7ul9daklBgf8expXDk7kNd8D1+QaPh7r36ap53RkE3PMv/xu0WoY63lN5y89xraHfuSwyROw
	2Eldne9faae2pHGH/PH6ZVHWFYEqx2tRPFVFuIqbgzuLEad8lPgbrPY2pzUsCW+QPA7krXsE7UOpo
	oTRuAo8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE7kt-000000017DJ-1g15;
	Tue, 06 Oct 2026 16:11:03 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE7kq-000000017Cv-1vYh
	for linux-um@lists.infradead.org;
	Tue, 06 Oct 2026 16:11:01 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-8ab3aaf416dso8847167b3.2
        for <linux-um@lists.infradead.org>; Tue, 06 Oct 2026 09:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791303056; cv=none;
        d=google.com; s=arc-20260327;
        b=GQ+7/G5D+1u4KXh8L5Zu7QJN2ABqtmU2R+UedDsEgSRU+JDlgP8JAwMVEjPPt8flMx
         trnsYLqF1LTMcZakFMGF55bezeKay7ACvXRpYqLvL0ksUSGaQshWT3/p3gsNPmb/k6tV
         misE8NjCuq9r+SqdRiVqd3S0N3Tal01HXwoIkios2sZjg1Gf3hnA6qX7YMUOacmaBXNx
         pc8I63PxG5noxUqp6SnYm3o3X3f+u6n4V0c2cxt2WG2PmtHvnsZRXQjyvIL0/lNpkRgq
         T0P+iBwGtxT0KXnsNVO6IRuNzL1Pp3gMtUrED5kMvLkJOZYyxL/KwW2ecy8dYmeVDdHs
         E3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        fh=L3BxNP6XlJywTG7N45wrZZQd86tYCWebkmmWYHHwxws=;
        b=GfpNMIk1BET8VwI7nzhraE80p+G8bdG6u1h2wN90KA1E6LcosqxdPWjF1HtTFfiB+a
         s+cPSFMrs/oOGZyCxwzwCjjxsiACImFzYpX+/qXwNI1VbFIgcyCfvl/yeAT9DerYreib
         MtirdYBU31Y7S0gcZBqWxYzSqj4gr+fWgnseYGz0U3bcDIxPsqT+gWsj0Goen1eZ7eMg
         luBgr6OLoSGdH9GCFNPeWRJUTcBjDKCrnid2jV8QO+ZVwuRQ1P1gVmKr2dx72yVmB4dS
         orr1+ofpa5Sv5rb+JP0yiT0CrZDQvJBsaxtCF45QIh+s2HS3aMHyxIxZisz3ZeuCyJ5B
         PkDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791303056; x=1791907856; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        b=Lt+7WLbABO5PaxFMd0JYAu0DOULlxnHlQaBF9b2dhY8WJAnxrbOfBHgl/1j/bKMuj0
         LlkPC785K6cQXAoIQyxPBnadmUyb3vk4E2eX9c2QVZySIdjF2O57iRS8ZmeyoHx0PpsF
         3su0QPFzX8auXxY52DtwxqRS+ViUeVCptvoA+UHTobq7ZWSiBMWgolbAbqUhjr0FVgzU
         M1nD1lWLmSloIdxjnKLBQMlt+1FNlGRBult6FPuQiWLURNG3JHzcJx+s5LcR0o0q4Nty
         ZyzfFoOiJWL+dqKrpPS6GZ6nZDxRK7gq7KweP5iRBIQvSZEJjFz9y8rahrqu625hU/vY
         U1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303056; x=1791907856;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfR6JmlAO4hB3DVN/nKPNuuxv4ZNwhQvNLDvwEb4/Vk=;
        b=oRYfoe59pbGfZVoFjX8SLvCIUjrad4ndKvL5a4LpI2BciLC5rMQ4MFDPsaWZu28k24
         RqehHuzjerlc62Pd9ktCDqLM1v/W+d3/IbmjV9yaAyTIQfg2PjX+7fYcZMLex4nHf0G2
         CyPvVgwCuc7B87hB147FxxVAZvJeKr1LGCD0ylhIVaqwpLrp3OAoNDcq+KAJRxMPBO35
         d2xJ85tb9Ydypj2TW2N/0E3SG6/l9DsFb8B2GX0t1n+dHka41ODTKrJHB7hJCTicBxbl
         L/YiHiaKugkDj+fcmjCL3FVWaamRZ94n2AyqpvHUNsXANSnc7DTgsjddaFeViVYMp/R1
         438g==
X-Forwarded-Encrypted: i=1; AKwUvBzLwuo145lNrcwwO2/NfnEpxhCZPw69PPabHoHfxTvcMNGu3AAcd+eddgv0BVlf/ppR13I2K5PIyg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJehH9gIMLSZjVqlbjwNX5gVp0ORqxGDIKlWRmfLUEVanhEnLrl
	bJ3sM3CYiKuncegp7iWlxBT45WdfdA432fV7HYSyCVVy8EOjcljIJqE4FkkEKJoNR5WGWWV6J4L
	8RUOPnaA810djrWg6vJXHEDvxcdOX4T1mYVDdp2R4
X-Gm-Gg: AYBFou1QaLOk7YGkD8tCh3/tjYdk8H0jeM95/po9eSn2ELeIjXSrEze8OihTZsxRXiM
	XefCrOawT0qQqN0f80pHun2yxw62Lnqj6GtfHIF/8R0HbLOkaxl9bKwdA7X3ibrOtpknmWJYPJS
	A+l0EyGVsVnXsP7DorIea9hLjbUo1gWPhS4SsNdYUoSVID4YlORLIMeDOgXAKTBnA5ezhI1oW3b
	XKZM13LAhDD0Grw2qqxoitf4aIPdOYmdBqeEP7hmF+mXKbjc9uS61v5N5MjoJexFl1063bzCoLP
	BhaNTR4oGUQjTHKO0fs6drUThuwp5CAptTzJYZJgoL9qBj0wFHf3Dw==
X-Received: by 2002:a05:690c:5302:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b04f40f097mr9171807b3.12.1791303054779; Tue, 06 Oct 2026
 09:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
In-Reply-To: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 6 Oct 2026 18:10:17 +0200
X-Gm-Features: AclHuK_OeB6Z7-eCIUVq_1RabrgIKOGeEVPLb2q2UdMqE46rpsfhYWgMuA5UU2w
Message-ID: <CANpmjNOaykC4McAj=gZghqPSQc9aGBP_CjgKmp3n2yjeJTxDSA@mail.gmail.com>
Subject: Re: [PROPOSAL] Replace gcov and kcov with llvm-cov
To: chuck@wolber.net
Cc: kasan-dev@googlegroups.com, nathan@kernel.org, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, oberpar@linux.ibm.com, ardb@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu, 
	johannes@sipsolutions.net, jpoimboe@kernel.org, justinstitt@google.com, 
	kees@kernel.org, kent.overstreet@linux.dev, linux-arch@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, luto@kernel.org, 
	marinov@illinois.edu, masahiroy@kernel.org, maskray@google.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	morbo@google.com, ndesaulniers@google.com, paulmck@kernel.org, richard@nod.at, 
	rostedt@goodmis.org, samitolvanen@google.com, tglx@linutronix.de, 
	tingxur@illinois.edu, tyxu@illinois.edu, wentaoz5@illinois.edu, 
	x86@kernel.org, peterz@infradead.org, sashal@kernel.org, 
	Aleksandr Nogikh <nogikh@google.com>, Taras Madan <tarasmadan@google.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_091100_628210_79059FBD 
X-CRM114-Status: GOOD (  24.15  )
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

On Tue, 6 Oct 2026 at 17:14, Chuck Wolber <chuck@wolber.net> wrote:
>
> Stemming from some hallway track conversations with maintainers at LPC
> 2026, I propose replacing gcov and kcov in the kernel with llvm-cov.

I know the origin of the discussion, and wanted to chat, but I guess
that didn't happen and instead we get this proposal. It would have
been good to understand the requirements of users of gcov and kcov
(more below).

> llvm-cov instruments at the AST which enables precise mapping back to
> source code regardless of optimization level.
>
> We have a set of patches [1] that implements kernel based llvm-cov. They
> need to be updated and some additional patches are required to address
> some stubs that are missing noinstr annotation. But otherwise I should
> be able to send a full set of patches (including taking on the
> maintainer role) to remove gcov and kcov and replace it with llvm-cov in
> fairly short order.

The hallway chat was supposed to figure out if there's a way to bridge
some of the gaps, but jumping the gun like this without having
addressed the requirements of kcov users does not make any sense at
all.  As for gcov, llvm-cov was designed as a better replacement for
gcov, so that makes more sense.

Ok, well you made me untangle the most important differences between
kcov vs. gcov/llvm-cov below so we have it for the record.

> If there is a desire to take this in pieces or implement other
> intermediate steps, let me know. Otherwise I can generate a monolithic
> set all at once.
>
> [1] https://lore.kernel.org/lkml/20240905043245.1389509-1-wentaoz5@illinois.edu/

llvm-cov is generally useful to have; llvm-cov is closest to gcov, so
that might make sense to replace.

KCOV, however, cannot be replaced by llvm-cov. KCOV isn't a coverage
reporting tool for users, it's a low-overhead interface for fuzzers
(syzkaller/syzbot and many others). llvm-cov has no equivalent of:

- per-task and remote (kthread/softirq/USB/vhost) coverage collection
(to avoid polluting coverage with concurrent tasks);
llvm-cov counters are global and polluted by everything else running;

- ordered PC traces (edge signal) and comparison operands (TRACE_CMP);

- performance: a per-task mmap'd buffer reset with one store, vs.
reading/resetting
megabytes of global counters after every program;

- GCC support (we may want to keep at least one GCC-supported coverage tool).

It's also UAPI (include/uapi/linux/kcov.h), with existing users.
syzkaller heavily relies on KCOV's features above to achieve good
performance and coverage; there's no reasonable way today to migrate
to anything else.

As-is, NAK on removing KCOV. Consider replacing gcov with it.

Thanks,
-- Marco

