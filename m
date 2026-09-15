Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095C2C982C5
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=; b=v9epuMF5M/7nvD8Lf+Rt/ZLgbg
	LhktxPa32AN2CjfmlCQ/CV+rt9af8QyW47D7IypIE5lCLeacrIJTYd+a/SST+d8F29CmToU9VoMhA
	erMfVT79T9+S7niEEZd0LLEtxPcztko1C8XB+VYv01DRf1t5jYbJDsbhD/n5ggY8qEQeAuhAgJZn4
	FBVg7/unS7Jd+cSmEQVDMSCi4hLIMHZixwRyNn3fwi0biyswgRk6AdHLeY9IFLwSfNXRxgXBzcfTg
	/Z2QBaDjLCu2tUNTJZEdg6yP729Mih2nG2zD7LHbBPqciZAgI9dY3gDFMADLGzq2WGBpdIN3+27uJ
	pZHTIUfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6XKI-00000007eiU-03HJ;
	Tue, 15 Sep 2026 17:52:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6XKH-00000007ehi-0exo
	for linux-um@bombadil.infradead.org;
	Tue, 15 Sep 2026 17:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=; b=II1ZAWppOE+auBYxlIuMLW1rFC
	aoCpsM+BcHGgtXaVEqtJwsUEljXAwRAJYn0tAaSOtwYpAG7mHy62V3CPEughDeZgHtwx2CgHsgFr/
	qCC5f6WKgWqyXG1+Xk7sLVYa+vWrZPaO5gae2vLt3MyES30qqUa2c6KTyv8Y3QCngjET+mTEXEjlY
	2nFS0LYR1NyTA2yg4ZsPMu6NBH9tvt0Rn8S8qdhhAISaF1qR0L3Cp1A7W8QiN4+DNIbkQwyJHobUW
	uQFpwXr4xLtUK/vxufWgRUNxIYbD0dr8FiIzhgxehJe3aazG4TQL7LPbb24+XZwP63gHy+6upSC9V
	OIMIqgbw==;
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6XKD-000000076jm-0WQJ
	for linux-um@lists.infradead.org;
	Tue, 15 Sep 2026 17:52:11 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2db425c9050so12155ad.0
        for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 10:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=er1zVq1n/s8QqUk8/2xTfuGLeHP8DTFbDVezDIMdWGm+oasWmgrjGAId75ZDJWX2dr
         GHioErUC9mnBHVjPUbbYUzaHGC+1leyu8iTy6VSLWEB8aT3P7TaVUNKPO+UWbeN75DXf
         xh6PBQY1k9fPULPPp9Ahgy62bAalioaKDUxgVcOZQJEXkG2OWC2zfaBYpGDaZ+Tbc/Kt
         rou1qyF1Fu38Xp3GrTLPevM5NAGbO0vGSXewcTuqArmo27vqgeYY0hTdxf2Til0mZOYI
         DhmVGYvPQVK6smnoUj1O+vW616oOebcVH7yVJaK+pMdsp443Gn5TSTxu/6voUnwk3vDC
         jccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=tR+qTWmYupUt/dvq/Mq4QpLtlGrGKYXNOMh6aIibb/g=;
        b=GiuU+WndS9y0a8L18pVoNcoS9kELjKtNMGkO68BDNbql1Lzj89fMNP65P6SNCyrGB2
         6uOQD7UbTjYGGdmPVqMTX/w5jt+N5ZMiSbfNGVV4OalmAAjOty1WW3y+CHEA1zGBxjlb
         ByUFvMazSe1j/KU6GKNn5ksxhGnnkAdqC69JPhchFaGmNoUIEA216MugrwnGCFn60ARz
         a36k/0rxWA4t8rd6ZJNNLyz7c261FtfANKtyHT4d6y7Zc49ElEiBQPJqv0jL8UCYHehw
         SVvg+zGKv+qwJlorwmVZfclbTGTqBb5lc3zPIgDDZpgFG+xu+IqkvTJ1Ea/AR9vcCIjn
         bnSQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=v+jO3VJgsnUifpclVFgNdjMcyvUQpnfqHupbIlBGRjnhWtWE97SE9rvGpSIP4pxkSe
         x+TvQSB6BHu7aEaHVF9i+Tkjn617UD9utZMuaCUc0LThFbRvTGBMXVgV2g0cwI0Knhbo
         hW3mOw6slYadATKIlham/UojDKkSqdscHxokQinPCKNPvQf6Bk92Oi1tMmd41AMbVFZM
         xuiw9lXEdvF382NtEcq3V0oehVbN+DF7OVLQeEIAL+ezLrt1HfUv+BOtS2uEKRtM0bXX
         f7OiH78VHG9JEHFH3s+FQmSvt5YdwToBiThIfGmvfkVqDbnj8R5JV7vxFzC2V52td+se
         gxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=tmI1qKeZ7DOaSqUQ0zNAX8axNd+jKws6ENObKmJKHwReesxcEDGR7Ntf6ZxrLCahHJ
         1RkYVu3YLArAHws2c7Mt5NUQJk/N1IXAZ5HiyTrBKLDip2TMa0s1RQsj8aL976w3YK1h
         75ZbLp1NyCW1d4bP4fG36CNG1lN18eHhsHuOFMyItgwe1n5hZd23PZ1LQBOhn8tKtYP1
         VGCPmF9x+BQMZPiAVtwgj6jFTwSt9ZRp5bDfjXwgoT8jFWACpas5gF5or+QbmhQ+F3HL
         mM/FwSRi9LVxzkVzFsSd+mo3hxO7heSARMqjsCbjoU94FXZwarfVVOQiK6mFnJ8pLWLz
         kp4g==
X-Forwarded-Encrypted: i=1; AKwUvBx9DL+YFzCxNKan39+E1eia2+f3onNQktA55q7EJBA5tQcEAOIHEOx7KEtTwBJxxyfDLo0iV+T54A==@lists.infradead.org
X-Gm-Message-State: AFuF++k1FoKG68N48+1OZ8OYu4Q+t9EruSZmIwXowIZXpxRuo+qrXbNR
	q6x6oEcZOGMZrg+lTWk+XC1lW93qyz+6kgdQyuqK/2BuozGoJGEWuOBf8eNnbQH4tIBjYBUcCmv
	tx19+ZZZQ+6VY9DMrrW85JZZxyEvHcgxrIpaTyoi6
X-Gm-Gg: AYBFou21IJyJA2vp+gH8L5y58mgWk++e17PYs2rgMCf5ZrQ0U2EEoPd8WQI4paHXRMk
	PAAG3Czrb/UI5JK6/xciKo1pRe4xpaQnOPQH9+DllhJUsQjjWgIdB/SbLObSvZ6T75MloPH76TQ
	DDZor6QToa2Mzl81huYomyi6TkP4fOmzWlWORUpR3Wc9uGs2IfkbEt7odRVSi0L/b4eSvapyIo8
	+F3SBDojSX5WMkyfFSdmOXiQfYqq5kI62KnaiuL7B4573+xSbz5Hk8FBFU59vrFWQBTKlM9Rslz
	A1JI0P5eKxIhlx/owLTRPc6nOUmvbsCV1wyGGqm4OIUdWPHNgd7XDoSW/w5Bvv2g92GWIuxJlMx
	Ajm49ckLoJzSE6dbHGv0dSesQIAUZ6rk6IVLeBGbnJyf35v3I/BQ=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_185209_279498_C23365FE 
X-CRM114-Status: GOOD (  14.61  )
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

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.

