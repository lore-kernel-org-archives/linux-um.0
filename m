Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2874BCD13CF
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQrdUk9Qs95YbYxvkhvXPIF077+rLJVqqSG6sH4DY10=; b=Gm/iBTIwB3bLk6p2hEUo9QZbKV
	wsKXlmltp3i5bky/dreuBT+qK0P3/3+dSVOHlZj/wECO6mCQ1R43/84ITPQyqkyYIp9Y70ZBH9l9v
	zwgMFh2QZ7scSlR87F8DxKyWyKKkajHeRSWtWoKu1cG2MRmRzFcMET4YmxnLCp0cKvVnj1c3FUHi2
	AIkV1Ljife8Xj76LThWMxVPEAE/3CJ1NCoDf4SpJTthZgcLkfyHl8NbgRkVkEPAkf/Ik/NlUNrSY1
	1fMHZ/p4DSNvYxvUUnuPasjfs6VKcoQ5k4xZKDHEPRTWmCqMUuLtPHWrKPqIawbxt2ssTmAqYOq0I
	AN/f6Wxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl8xY-0000000Epxz-1JTw;
	Mon, 02 Sep 2024 15:27:16 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl8wb-0000000EpeW-1zkr
	for linux-um@lists.infradead.org;
	Mon, 02 Sep 2024 15:26:19 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-20549ca1fe3so2978775ad.1
        for <linux-um@lists.infradead.org>; Mon, 02 Sep 2024 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725290776; x=1725895576; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQrdUk9Qs95YbYxvkhvXPIF077+rLJVqqSG6sH4DY10=;
        b=lJH5wavFXiLHm9xkGovYTm8cw0ZplHoS2Ya1WNhJImw40Ipi5VGwNoV4HINNe4JnYb
         HlmtwYO46BSEhkDwCDJGQFs9gwoH5icQMURr8LCOpEc+++iA0FYs0Msmizz9B/Q15T8H
         ywf+KkPfSgp14BHYrr6fYY3ySW9aAy+61W1pNLjagwce50YFW7OLYK2ykisXWj8zf1bl
         OMS8kUyXxWDbFGaLUWJAzt17N1660BIJfga0OyUX4bu7mogzF5PmsEEwD5L9fKdC8tVV
         yIuYPYPMkJnv8t553vXaads/lkbCEuJTQrBCfumRejjuERHZCHrkZ8P5bsIrh1YjWG5s
         vb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290776; x=1725895576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQrdUk9Qs95YbYxvkhvXPIF077+rLJVqqSG6sH4DY10=;
        b=OdDBxSgi0NE5VCaY13ZJxvykhN8dxzXFCjYbeHv9BaaiWvpyl4UOtii2JSSPNtemFx
         OzkbLaJ2NczzJttNGkWuqohUYcVeV7DE0bJSwjK/6kK1IR0K4+oZtiksFvhfe29/n9/M
         Ozv799A3VoKrn2Yjhp469CA46a+mzLI5A7YP94O744KEcvV50Af5WW8A3Au/x7s1nIC1
         HI2YBxWJugDn2i/feY5Iaj06u0SeoU+oGpyEo9lez7R29KGD7RHN6+Q2k8CBN0IFQayp
         eebUU0gX7qjwg3rbPo+RS7syB1cwDRcIRNGxdjs/XJ3Eq3dNz0iXN4gXhr7GdvwTxK6Z
         eOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8LXSI5wsJr61XF+19QkQ+XHVXyGR+XBGi45grwNqlTNU9u64S0qhUS0iW520oNIp1YSIQVSSM4g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yym1mYA8owIphimH80VPj0vgtCqDrjnm8p0FcncZ9gQ4b6TOL5q
	YtKx32W0E7cS+QXL4d//vsCfWu9hq9+Y+QQUEeRUP1wnfQyeA8sRpTH3A7zRYug=
X-Google-Smtp-Source: AGHT+IEIj7UpxJT8a0mIACuZXNoTi9evmUotnGeb8wHYPTVQQPCrd38PWufROqKQIhaL5lvUsVlKgg==
X-Received: by 2002:a17:902:e549:b0:205:8948:3578 with SMTP id d9443c01a7336-20589483694mr10763885ad.2.1725290776144;
        Mon, 02 Sep 2024 08:26:16 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::901f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d04a3sm67470855ad.110.2024.09.02.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:26:14 -0700 (PDT)
Date: Mon, 2 Sep 2024 08:26:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Hildenbrand <david@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] mm: make copy_to_kernel_nofault() not fault on user
 addresses
Message-ID: <ZtXZFc9kZAUMD4e0@telecaster>
References: <cover.1725223574.git.osandov@fb.com>
 <5fa50d78-6764-4f99-87b3-7bd7edbeea5a@csgroup.eu>
 <ZtVbrM4rQsGFJo_t@telecaster>
 <861d448c-ce1d-4b74-87eb-9b211dfebbb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <861d448c-ce1d-4b74-87eb-9b211dfebbb1@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_082617_649579_E2382E6A 
X-CRM114-Status: GOOD (  32.45  )
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

On Mon, Sep 02, 2024 at 10:56:27AM +0200, David Hildenbrand wrote:
> On 02.09.24 08:31, Omar Sandoval wrote:
> > On Mon, Sep 02, 2024 at 08:19:33AM +0200, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 02/09/2024 à 07:31, Omar Sandoval a écrit :
> > > > [Vous ne recevez pas souvent de courriers de osandov@osandov.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > > > 
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > Hi,
> > > > 
> > > > I hit a case where copy_to_kernel_nofault() will fault (lol): if the
> > > > destination address is in userspace and x86 Supervisor Mode Access
> > > > Prevention is enabled. Patch 2 has the details and the fix. Patch 1
> > > > renames a helper function so that its use in patch 2 makes more sense.
> > > > If the rename is too intrusive, I can drop it.
> > > 
> > > The name of the function is "copy_to_kernel". If the destination is a user
> > > address, it is not a copy to kernel but a copy to user and you already have
> > > the function copy_to_user() for that. copy_to_user() properly handles SMAP.
> > 
> > I'm not trying to copy to user. I am (well, KDB is) trying to copy to an
> > arbitrary address, and I want it to return an error instead of crashing
> > if the address is not a valid kernel address. As far as I can tell, that
> > is the whole point of copy_to_kernel_nofault().
> 
> The thing is that you (well, KDB) triggers something that would be
> considered a real BUG when triggered from "ordinary" (non-debugging) code.

If that's the case, then it's a really weird inconsistency that it's OK
to call copy_from_kernel_nofault() with an invalid address but a bug to
call copy_to_kernel_nofault() on the same address. Again, isn't the
whole point of these functions to fail gracefully instead of crashing on
invalid addresses? (Modulo the offline and hwpoison cases you mention
for /proc/kcore.)

> But now I am confused: "if the destination address is in userspace" does not
> really make sense in the context of KDB, no?
> 
>   [15]kdb> mm 0 1234
>   [   94.652476] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> 
> Why is address 0 in "user space"? "Which" user space?

Sure, it's not really user space, but it's below TASK_SIZE_MAX, so
things like handle_page_fault() and fault_in_kernel_space() treat it as
if it were a user address. I could
s/userspace address/address that is less than TASK_SIZE_MAX or is_vsyscall_vaddr(address)/.

> Isn't the problem here that KDB lets you blindly write to any non-existing
> memory address?
> 
> 
> Likely it should do some proper filtering like we do in fs/proc/kcore.c:
> 
> Take a look at the KCORE_RAM case where we make sure the page exists, is
> online and may be accessed. Only then, we trigger a
> copy_from_kernel_nofault(). Note that the KCORE_USER is a corner case only
> for some special thingies on x86 (vsyscall), and can be ignored for our case
> here.

Sure, it would be better to harden KDB against all of these special
cases. But you can break things in all sorts of fun ways with a
debugger, anyways. The point of this patch is that it's nonsense that a
function named copy_to_kernel_nofault() does indeed fault in a trivial
case like address < TASK_SIZE_MAX.

Thanks,
Omar

