Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D31C982C1
	for <linux-um@archiver.kernel.org>; Wed, 16 Sep 2026 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=; b=Zg5ZJ+qJLzjYRxL0+j+iep1ivK
	qvQJZ9cjxY3kyYVrCp5b6v3v4iwalEtR6n2//NCAEz6Qvmsb9idWeTmasBvVhZJ0LF8Pj9ClZmFpC
	robvi00msxYJWwaEjf8oGbRfncRBfWnjbAjqMS0a4283vocTwcD+KYfIZQUPoc5TzD/ZlK3Oi4NFb
	M6MGoa40sdV+Y65nw4Cx3RGZG5qGuAVZ36Zpb3lYSJATzrjDSJ+GMIwZDOqEYDSmFr/14XaGnOG/W
	AfjiXLb/xi12N4cSkoueKUiHACWkZ8/tOqOUKf2dLuP1JNdRv+jvX1QkGMiSTfveSJ4evmaK3s/Vt
	lv9VODkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6mHf-00000008taL-1tw5;
	Wed, 16 Sep 2026 09:50:31 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6mHU-00000008tVh-47Dz
	for linux-um@lists.infradead.org;
	Wed, 16 Sep 2026 09:50:25 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e8185e037so3877845e9.3
        for <linux-um@lists.infradead.org>; Wed, 16 Sep 2026 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=YG8IDu1hpzeRLp17FHzRQhSgPoc14fmyUrHOWLvQmNou39MjUIsKQ6Gs+TVGl1s4Gi
         eQ+QjmC8Lun7yXfPZn/cmsTIUDhXFVaMGAuBBsFfDVvg8hRyB3/gb4wKK2iZryoH6J/j
         8jouLiHOwQjzAkMkZud4zpjZ73U664++80qnGNdeJ7RTZE9NfVmavAmV47oWLafecf4q
         QLZcjQ8JV5nV0JDpkrKNapX1La+SKFhaWkeAekpTi46zXrPv90shxGHIkfHMDp/eFV9N
         AG5BgfVm6/KWZR46/ISmicLqzexuA1X0hKKksIL/XXIcbH0lbDTtMRgQiPigB8Gp6CMy
         QM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552219; x=1790157019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=V8kT7Wz1rQamEf2Nnd7FzoO433nfevQfXBlLbfSqTQy7OYhsCfpXNVjvllGHqtF2SO
         8ACDISAl31vgRdy++yh8heDTSPDxZcMzMhDsmK6JyznwuYfwSm9ln9+UIDe2mZH4DPTv
         mPjH2qLHM4TFxDvL/ISvcHQ3ycA1gjxckPTmhf6/mPsvzotknMEzbzDaD3gaElv5EF5b
         f708gCVpFZ2ih8IvDz8KvSdMn0P943bG1n3LPA3XCzEO7opvAbnVhwa8/3N6mjfzwohD
         Wg9mPHLm6LUu3Srwmk/GzeuZJygLDgnJlprwWi1xbZi+sOon43JKdUj3YDFcBFJrfyli
         5apg==
X-Forwarded-Encrypted: i=1; AKwUvBw1Px+QLyAKt7t6Rh8t6Kv5luNwcLyJc2P40oDWtZaBj5BbiUfK3bxW7Nlmg4P5UWEKJrDkLI2xdg==@lists.infradead.org
X-Gm-Message-State: AFuF++kThijlHUe7TUO81RfToRVAD3wrRbJwQ/0GOLjkIynqBpDyfXyT
	exr4f9kHryT1ToJ5h4o7jh7kpmCHSqMR1d+N2NTOCLfZRLkr1LB2ZDmD
X-Gm-Gg: AYBFou21DmIe31g6bdTR9/dY91/BbVT1ku10lPCsXlRNwS1y1bPiQoPibvxmC8JSUGh
	TKzB+XFsx28U2kyav6BsvUQ+aS9F6G7rHAW91Pi0J7v44FKlpuK4GXq1/LsvOSABDeRzvJpue9t
	dnqoLcKV5d12za+pbDAoZ7eDR6vfZdiPAnHoTiiY2YYZVjBd5qVlV085pHMF/EPwwnmHVJm93Ai
	TJVtczYpQU7rjrnywbQlK7YpLESJb+IwkZ+gvGwEVGzHda9NlNgSHOOgGfUUm9jVx0hggb2Rvby
	XMjU9ySvz9sp5n5Z/oHfK1L72rZfvQLBHB8TesVFBl0zai120jgaIOqXFBbZOGgNNHfr3FCOp5v
	YpU+pUxXC+r6szEF781s//TGald9NB9damzwEVUqP+vg1Klc16La8aNnbeWn/EbOeNpMFpAdtfe
	7w7BiDTS1YbCCM5xQ7bfQuPgFekgWslk6Ljmty+jD39BEEmGkLMw9oTemVj7lxchUQpQB0OBUVO
	wTcFcPak9MsE5PhDm/Tjji65xoSan74EHg2P1c+ITyH4GU=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000;
        Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
	<CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
	<CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_025021_704973_CE12BD43 
X-CRM114-Status: GOOD (  27.62  )
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

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 


