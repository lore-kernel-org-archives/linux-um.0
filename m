Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111DAC44506
	for <linux-um@archiver.kernel.org>; Sat, 11 Jul 2026 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=; b=yytvvJ1EpqsxQT3GubxaoMlNxn
	8foLkfbrf0cPM1wTHHoxS1fGDDDsBHBczRUvEEF1uZ0JsyfdCA6fTdrkTYLjS+xDB9ta+ZzfXXHLQ
	0FKdoutEl/I6fpKAUnuYUn2jHNy5XJ28wpVB/mqki8bzoRlYhPerF0qf5+dHR948ajZGSgR7wlCsm
	YbypVFHWzMcJdz99P9At56vn7ZhoHIBJFWojC1eR2IPEuAb5WKmscIFCpHhAFKy9Jsq1fTFM7BhJg
	kdKMFvwYgPy1PxCgzKHme3cA5GFlUiQOzr2LzFBfdH6VdnGK/sAPifJkYPrgg5wO0Zq7Hr5oFEZhr
	ZgwIUNCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiWpn-00000006XDS-0iAu;
	Sat, 11 Jul 2026 12:29:31 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiWpi-00000006XBD-2XTG
	for linux-um@lists.infradead.org;
	Sat, 11 Jul 2026 12:29:29 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so2732021a12.3
        for <linux-um@lists.infradead.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=GA0jL0s2tVkzwhEz+w4lRGFAMI7NU2+JUgCxjFLGcG7Dw/Xd01z7pvrZscMC5uNkOG
         qo9vMPMDCtO8mIvvc8Bc/2zffsREo8T5VNV2likU2I5jp7wVhGHacHRKJzZzVGDGGrnF
         9wAgsYXrB9c3c2/ycPJx74FtPZlpdyTWi660vBgYOdt7RjpOfNT8emD6Kqgm6UnTPxyJ
         xm3U9l5xi4yyCY6S3ZFxF+jfAL+dmQOa1Op6p383uEtBuAHrbLC5zMHowFF0WjqnTmQa
         CsVJDSOtfp/F0Nt9B8Uh3sSoQ/7VobMSsjd0gdyocziSSDOrwNfIdi9x+QnmneJprtQ0
         7oTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=6QQ7fNpFeoVwbNWbz5RRPdsaxOFUAiynly6CGfAwguw=;
        b=pdd4ZRfb6jb1VWBwCMHz93oQrJUOT4DxaEdsuvhV/89dwj4eBVO2XZZA4YuQts78zo
         gNwRGyJrx5RplspRso0/BU0yZzOluwrBIVauo0fmk47pY3TQoATMHlIF3yPWojfLcof2
         Ob94xmsiRo1fBflXTdox/4SkWsNhSELLMq3CGx3KPzPL49+0W2G3nSSmekCkAkyq11zn
         fV4eZS4sHMVFnJoy9/bIwT/m3w4PYrNcNU1mpSePi+vtDByj60bjOT6q1L//SWOBUIbr
         nPHAGxRUZZbHwBHB1najiy/936sWW0fvwjL8ALIcEkcmL1O+aX4yu5JhgjC9uEJNFaIX
         o5eA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=AEPV4U7oDhfoNmqPDLaJ5QJXi/cv5i1t9ID+/SIMQcOTMF855h0YJxeIClVcO8nsxU
         /QHXNkyvYDFV9l9RfKYAv27CiZkFIhxggU4ZZ7em2xpr/rQMXmPbiGmKE0RiRswiq2en
         r1geol2s09atm+oDNqTF6Q867dOKKrsIfc1uNwZkJ2KXqTUVPbIKR/0YYRauvd/x50qj
         du+9HvPAU8TAwFLofxhJsiR5yT2kUBK/M6Zw3ksqFF3R2KB6SEgskVOEdZbT752LCQmX
         k1iHJ5ok59FaSc3Ka0tBupMMcM1rSw+2KcNHmwiaPfY4B8N+SQF6lFVqIbbpZrAqoNZM
         f0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=qbPAknR8L9T8jbjRbn+t/sOw4WDR9O6lNidxwnFMrcS1+9tCTmowsGYUlp2SaP/F+d
         TPxlpHDtb1b2UX734i5M4/vaoruXvYncyc0X5Xeqf9exAQAFkQfQL8IxFrS012OriALQ
         jZFx48Z+vveVhqruRltDyQsYDyU6eGxvy9IemUiFV5uyhQXNjH14fibhyk9lmV9jwRJ5
         SwX7pcegjiT/zm4X8YSwABcW2SXj4msh1Caa3z3ZDt/fTpiaWA1xotVcfffMftTnE4OX
         1Hf9UAQQRBRTtSIue2RMjLD8otirYYh/MO5yJ6K5nRPifu6XJi/UhmeHUYkSpSUCcf2w
         72zg==
X-Forwarded-Encrypted: i=1; AHgh+RoC/8weCCggScehdikDBnrXmPua+3q90P+Xgbq2P2VXJECXiOlQU4P+OIw1xhTiPYUjQFY4vsKrmA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxQv0HXvGrppGqttRp3GXomHBCaB0sY9YF7az9oIQtW6BOjITLu
	lK6QIAiTK0kPU9+JkU+izi43m5TBtdOE7g4jub167+iOAeOK0XxPvllD8tIqGJM/bnb9zS9ARZt
	0pqYG9uTC5lMYiPgStcz6QwrxayNQuNY=
X-Gm-Gg: AfdE7cmVZJAvmrum9zPCmTsk+c0tSwJExvsbbJmYU+VRtMQ9W3LWeS97rphu+EbDmuk
	MEM7ZE1gKh5CWec7gzRwUD78nARgRoOt6ABdhPi/ArOr8hajH+ftFB5GnxoXX5g5NTVHC/uIiA2
	MZB/nhEdYVGR8R0MZxUcwBSVX9J9mxvwbl7SCnsgOOiYIKvlPlEWVAzHEEE5xWQF2Id0BsD4TKx
	CIXb4gbTjcFH0Hc7UvZSTfBDB6yYMhjdUICx2J37WiM2PfpWyc+N9Sdq1FjqByjka6D5IzVDbZg
	AIcroqj0GkEwybnyPZEi4iBR/bsStd6YB7Rw+Hj9B285rs4Zs/f5BcjUW8d3ywY=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_052926_672701_140259C3 
X-CRM114-Status: GOOD (  18.41  )
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

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>

