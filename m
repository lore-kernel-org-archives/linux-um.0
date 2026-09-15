Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB21C88E77
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=; b=zVtYL9B2qX3nhUGldaB+s7nSW/
	YtalvUI8JyrYhQNn5J8Q6oQAJ1aZN8pLliiAuFmtBBvTQXCvjW2IyZLCwhs9KznsVv4+OzORcdMp8
	syZuSZDmuL133wM3I02LCElhTYoZDVaGork/pB3yxp/a9u9pIswflpUSch0ur8hp0lRG/+j+foE3s
	dkuSbdfsBK564IWDJfkI7Kip+vK3bQrD4zxTjOgntuQ1NgU4o1PfK1lvnmCk8Li4xU05kHjxTUYvV
	9MSqxNpxOdsYdkcBuKcAbwmo/m8r4M/CiYEOi4yBsZ1kIQbjJi9XK1JpmXz6NuAm8VcN7TeJ5Av1g
	cMlU5Blw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6YWz-00000007pm5-0zpv;
	Tue, 15 Sep 2026 19:09:25 +0000
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6YWt-00000007pkq-28r0
	for linux-um@lists.infradead.org;
	Tue, 15 Sep 2026 19:09:21 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254fa663c2so22203166b.3
        for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499358; x=1790104158; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=JCoLmafF/m93rMljci68gRg3FHiNBrq9mAd0wbJjMawQP0RVDHDqDKUOQQPGZW0x8I
         qNUp7dNMV7VISSilD30YHFl5dxOIAclXLlXEO5NX6V5vmQeo1ObofoEAUfKchMlsoL7E
         sRSVuTqmH/IugLdbBiI5oZ7qwdjsS76gmso+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499358; x=1790104158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=1l7Vxk5+LlCyF4fEh28bxYlU0oAZ2J6vtpWDSJGHB+wHjjgUHM2D/nMWVauJOrgQfM
         pcdgY1eU3joODrsn3jvEyPIRRLqTWfvaFx9Fq0xAvKs7xGa4XxTxVoG8Yt6MPVQrXXb2
         K7koIlha5TbXdR/021Xf2gJWbO4WMj0fhwrREsAOpqXpSTkZ8vs0B/w1aQgKPllwZqXm
         GcXwQFyOrqHsH+DzmB3nNFvcHEy5vyFVRNaCHB/CCkiycgLxr/vYBnjjbQDspcPJA87f
         MfwhH8SephYVGBbL0XVPKcla6LqUV5IV2tU3bs5i9Q3xOSnRqjncZVSmW7aex6z2E2e4
         sBJg==
X-Forwarded-Encrypted: i=1; AKwUvBx9PROqg6NDoXSwwp26Ot9W9IEI4ApjvXR4BAyrtt8JDi8B5E6m2JPia7H8Wm6TJ0Lt8xucmp2PZA==@lists.infradead.org
X-Gm-Message-State: AFuF++k/OzaSj1J7sSvse+20gsnWD1EsMLabfRzUTRvrbDHS8bhGx4bi
	tSdoLnKDdNcQYR+8zsBYIEw92JQJ5JkGMK+kv9hOTtAWDa7ky5L+eS45/4ZDXRJnpW7zZiopUhJ
	EOImmxxc=
X-Gm-Gg: AYBFou3t+ii9/a1aWs1O3iAu1Lwd0/6v/Zc1xcmjC7eb7etiZjZ+f63zxnukwZSMO7p
	Pnku62eQYHHC632P1D2KWLi0zoIF7sChyf6PNcME3CWS+V/rMhQ3XcUzq/cvgcRY0CmFlyjt8zF
	JGw4Uv3s3Ay3v4DaVnr+2f6mV+WndZjgjNtcveMUpVSw3oWfWymM36BhhUmgTJCO9OWdPkouJBc
	3oqa2pltoGnY+pmXcdcl4i+hEHUOE41sF5jsoQ0TNA4tFvkLAKYrWdExkHZ985p7w7dewwb9kJa
	XSNqyQGCbuqcQpIrPNBMxNoKG5+5EHcQoVimHyTu9O4aLgIPxkFlz98MWCWmL9Y9s+M6/oxPkgL
	qF5/co2SuD25SgTMwk7gOzreWDyKXuKWc+DYnSKahM6BqwbZkKFkpNVh+rkTnud6nTJ023VPgc/
	mVWE+nowOXNC0Bx86RfC7/WJDW02mdcPcpJBfd7IMoFekQOo0iisEMF7LRxSN/9nbxhOppDCwKr
	P4cerTJyJdvCwywscmMpdgLkzY2NsVLjeOsXsgYCwOilSZc6kA/vFebXTWD
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id a640c23a62f3a-c29b839a057mr1176055166b.2.1789499357649;
        Tue, 15 Sep 2026 12:09:17 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de07ef15sm18570966b.9.2026.09.15.12.09.15
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso33744166b.1
        for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByBj5V3n5Yxo/sIf/ujefTVQhnc6ubRV0dY1kTms6FcoBzYWAnENfRTbSWUEzRS/nRKgfu2E1d+Vw==@lists.infradead.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_120919_714401_A3332BDC 
X-CRM114-Status: GOOD (  16.54  )
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

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus

