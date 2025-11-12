Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C3ECCFA1A
	for <linux-um@archiver.kernel.org>; Wed, 12 Nov 2025 08:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezHl29JJ257PYLhUUv6D8vVZx3H5wVWhTdhSBo2FgQI=; b=fNdqvhzZ+yqq422JhcwTDGtfMC
	n4PozdrEPX3W6BzagGykey0OyJZ99mPOTcEXMZFlnORY/DmNk8MOlUbGobkWxw4ar+AksyCcjBKIw
	Cer0LKYw1gvijatDI08XxIBGNRBaaFrTFr0/jiokiNaGG6QuVTOimVmQXj+tmno7Dps7kNlkEgtCB
	kPF0cH8N3yGSJFryLBYKCURQne1tyL6obzDFbxr7PzQTFrw3en5nr0Dvah2SSlygLiyQzFQP2GWNV
	CQ/U6j7YC5fOr9WgZT9B/pHsfdsuHu1UbMkW1dOcTxWjRGV1LvI8EpcQki7jAk5oUWTa6TMstTlB3
	bjmdJoXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6bA-00000008OoY-2QMC;
	Wed, 12 Nov 2025 08:53:04 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6b7-00000008OnR-2upO
	for linux-um@lists.infradead.org;
	Wed, 12 Nov 2025 08:53:03 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-7ade456b6abso498980b3a.3
        for <linux-um@lists.infradead.org>; Wed, 12 Nov 2025 00:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762937581; x=1763542381; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezHl29JJ257PYLhUUv6D8vVZx3H5wVWhTdhSBo2FgQI=;
        b=NOcg/eayi+fOxqieWyKxjn3W/j8Hb1Gu/OnO7c3xzI5cdqW4Ah8WBVPTqMYRZwid5l
         qTAWvQG2xdz+LB9LXqLyvCMsU9GjrnNCr0Tvy/m8Qaad3qPDCd0Q0sk54DMyb8cKT3IP
         IOR00+VXurx+bG4/XLRd3MmI2UWTUvRsXlZUF6XRQ0ZDXWPJjgASapaPUYRFgGbGTmcw
         9d/Xk8g0k+17MzBDinEdumD+hVmE2qJHJLAaMw9nxyfAQzSbCyLb0pOqBOSFL7JwUT/g
         m5JjEVWSGZTIik1fBjeelzBansX1n3C8Sbs+B3reEEBuiFBHvXFCqX9xuyJihFI5XADs
         LugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937581; x=1763542381;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezHl29JJ257PYLhUUv6D8vVZx3H5wVWhTdhSBo2FgQI=;
        b=cvLGjKZ6BrrHeQ8ZoqwNf1uGtcXyP5NUj57Y+CIcEacmb4HHd6XLIfWkUE0n5pwuh+
         Yn6uDsgH3KnVmxkkFvynsQgWAwe4q4T1KR8w/4fU+KCwdx9TfxJWLhF0GMU7gzgLSdLS
         SF6xUKoeh6kuYCrtFFZhowLfQFJamu6u6uFT+O5GCRLzRgAj+UUWXyVVJil3Gz7Ad/A8
         5r3H9Oxo7xZNFcJbpxeAY/TAS6cWNh4Gq6477CHNjlHqKR+hVQDqXl42bPNlbZ3npQLz
         6wwyOIR/kugJ+bvoepi1YuExE7i6zodk/ef7DbD6FS3l86C2OlBFB5S7KXHDQ3U6Y1XW
         lkwg==
X-Forwarded-Encrypted: i=1; AJvYcCXsT1rPbMWHlF/StpGXOWRbUl7BWwwrslj/NfS/JVPeymkZ8i4tRKY5Qrbc5XN3hlhzhpZqa7WtOg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1tyuRFYUKErwI2MJjRfZ+WiRY21M58LpW63ncGWQXQ4iVahmq
	B5Mkx0U2OQ1eiZVGEucuth4z2SpXFHS26ziAH/7LRMnWyh6/ZChJxtqK
X-Gm-Gg: ASbGnctcumOCtY3rO5Z/mYnlsMryeHAX4jmsZYC+R4IUeICGL7IDfG9Y+WqYwRP3wRa
	EC1BjRYCp3tHuxiBJp9C+Z8aNEzftRTyMeOcJOsdsmNdt1sOFB1vgeBM3gBuCvVzBt0ouL2+N5o
	0C6rSovwt+ZQXUH+EAfx5eDhAdhCWGJikUPo7rP62oDro5V+0eYa3RxV9nvlK2UqHif/V63Qp04
	1K91IGamio2XQLdWw0NIcJflEPzlDabwJe8y1g2wqFdym3/8cLccRLdcBX+waAh4samiufk1X+2
	JbQOtqBK6MHKyA5TN1Lb/cUStnRnAPN5f68KalcNzolAauz25zOfElbnK0K5AxCyS1l9p1b0Rsq
	B33+Egy/y8V0LCW/ZfSPspC9V8seZi46xt908wNzZwSYMwouMIUU6JRG0PBLBtETOkpn3MmO4g9
	sm+9YS0E70eEwTyR03VLX881kAozUGoxy/r8Qx0ZPNAfVskYn4+RkIaXPOjYj8ZV5NWv31jz06p
	5PDJ+OoJZNqh93qbvK40Q==
X-Google-Smtp-Source: AGHT+IELMHgcHN0Rd99ypTZDkVpVLhDqHiZKTu61iMaVvnkDSCt9UR5AaCNm+bZFIRupx2m+PRTS/w==
X-Received: by 2002:a05:6a21:33a8:b0:352:220d:e5fe with SMTP id adf61e73a8af0-3590c200fc9mr2880955637.50.1762937580424;
        Wed, 12 Nov 2025 00:53:00 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b81cd4a98asm1115386b3a.22.2025.11.12.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:52:59 -0800 (PST)
Date: Wed, 12 Nov 2025 17:52:56 +0900
Message-ID: <m2bjl7y6mv.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: hch@infradead.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
In-Reply-To: <0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
References: <cover.1762588860.git.thehajime@gmail.com>
	<aRGs8lPjH22NqMZc@infradead.org>
	<m2framxerm.wl-thehajime@gmail.com>
	<0a84c16f862026c82271c0adbc91d98b812a78b4.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_005301_771002_C669F457 
X-CRM114-Status: GOOD (  42.73  )
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



On Tue, 11 Nov 2025 17:01:25 +0900,
Johannes Berg wrote:
> 
> On Mon, 2025-11-10 at 21:18 +0900, Hajime Tazaki wrote:
> > 
> >   What is it for ?
> >   ================
> >   
> >   - Alleviate syscall hook overhead implemented with ptrace(2)
> >   - To exercises nommu code over UML (and over KUnit)
> >   - Less dependency to host facilities
> 
> FWIW, in some way, this order of priorities is exactly why this hasn't
> been going anywhere, and every time I looked at it I got somewhat
> annoyed by what seems to me like choices made to support especially the
> first bullet.

over the past versions, I've been emphasized that the 2nd bullet (testing)
is the primary usecase as I saw several actually cases from mm folks,

https://lists.infradead.org/pipermail/maple-tree/2024-November/003775.html
https://lore.kernel.org/all/cb1cf0be-871d-4982-9a1b-5fdd54deec8d@lucifer.local/

and I think this is not limited to mm code.

other 2 bullets are additional benefits which we observed in a
comment, and our experience.

https://lore.kernel.org/all/20241122121826.GA26024@lst.de/
[2] https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf

but those are not the primary goal, so I'm not pushing this aspect
with usecases.

> I suspect that the first and third bullet are not even really true any
> more, since you moved to seccomp (per our request), yet I think design
> choices influenced by them persist.

this observation is not true; the first bullet is still true even
using seccomp.  please look at the benchmark result in the patch
[12/13], quoted below.

summary: most of tests show that um-nommu+seccomp is x4 to x20 faster
than um-mmu+seccomp (and ptrace).

.. csv-table:: lmbench (usec)
  :header: ,native,um,um-mmu(s),um-nommu(s)

  select-10    ,0.5319,36.1214,24.2795,2.9174
  select-100   ,1.6019,34.6049,28.8865,3.8080
  select-1000  ,12.2588,43.6838,48.7438,12.7872
  syscall      ,0.1644,35.0321,53.2119,2.5981
  read         ,0.3055,31.5509,45.8538,2.7068
  write        ,0.2512,31.3609,29.2636,2.6948
  stat         ,1.8894,43.8477,49.6121,3.1908
  open/close   ,3.2973,77.5123,68.9431,6.2575
  fork+sh      ,1110.3000,7359.5000,4618.6667,439.4615
  fork+execve  ,510.8182,2834.0000,2461.1667,139.7848

.. csv-table:: do_getpid bench (nsec)
  :header: ,native,um,um-mmu(s),um-nommu(s)

  getpid , 161 , 34477 , 26242 , 2599

the 1st bullet saying ptrace(2) is somehow misleading now.  this might
be rephrased with "a separate process handling userspace", instead of
"ptrace".

# when I started this patchset, the seccomp patch wasn't in upstream.
  saying ptrace(2) wasn't not that much wrong.

> People are definitely interested in the second bullet, mostly for kunit,
> and I'd be willing to support them in that to some extent.

so (again) the 2nd bullet is the primary use case at this stage.

> However, I'm not yet convinced that all of the complexities presented in
> this patchset (such as completely separate seccomp implementation) are
> actually necessary in support of _just_ the second bullet. These seem to
> me like design choices necessary to support the _first_ bullet [1].

separate seccomp implementation is indeed needed due to the design
choice we made, to use a single process to host a (um) userspace.  I
think there is no reason to unify the seccomp part because the
signal handlers and filter installation do the different jobs.

I don't see why you see this as a _complexity_, as functionally both
seccomp handling don't interfere each other.  we have prepared
separate sub-directories for nommu to avoid unnecessary if/else
clauses in .c/.h files.  we haven't seen any functional regressions
since this RFC version (which was 6.12 kernel).

> [1] and then I suppose the third, which I'm reading as "doesn't need
> seccomp or ptrace", but I'm not really quite sure what you meant
> 
> I've thought about what would happen if we stuck to creating a (single)
> separate process on the host to execute userspace, and just used
> CLONE_VM for it. That way, it's still no-MMU with full memory access,
> but there's some implicit isolation between the kernel and userspace
> processes which will likely remove complexities around FP/SSE/AVX
> handling, may completely remove the need for a separate seccomp
> implementation, etc.

this would be doable I think, but we went the different way, as
using separate host processes (with ptrace/seccomp) is slow and add
complexity by the synchronization between processes, which we think
it's not easy to maintain in the future.

this was natural for us (not sure for maintainers) when we add a new
functionality, consider several options to implement, and took one of the
option which is faster, simpler, and having less cost to maintain.

the avoidance of separate processes is probably the core of our design
choice we made for nommu UML.  I'm not strongly pushing the benefits
of 1st/3rd bullets, but I thought describing the characteristics of
what _this_ patchset can should be useful.  thus in the document.

additionally, if the design choice we made introduces any breakages on
existing code, or maintenance burdens, I would understand your concern
on the complexity, but I don't think this is the case.

> It would, on the other hand, make it completely non-viable to achieve
> the first and third bullets, so given your pursuit of those, one some
> level I understand the design right now. I'm yet to be convinced,
> however, that those are even worthy goals for (upstream) UML, what use
> case would that enable that we really need?

the usecase for those are inherited from the original implementation,
[2] above, which is running UML on containers with less host dependency
and speedups.  but again, this is not the primary goal at this stage.

if you think that the document should not describe the potential
benefits/usecases which are not related to the primary goal of the
functionality, I'd agree to remove those descriptions.

> Especially considering that
> over a longer perspective, NOMMU architectures _are_ on their way out,
> and UML will certainly follow once that happens, it won't be the last
> remaining NOMMU architecture.

I'm aware of this nommu removal discussion, but also saw there are
expressions not to support this direction.  This patchset is still
useful even now.

> So the only value I see in this is for testing over the net couple of
> years, which really doesn't need any sort of significant optimisation or
> less reliance on host facilities.

I agree the former, but not the latter.

- there is a value with a real usecase,
- there are different ways to implement it but this went with the
  one with potential (additional) benefits,
- without breakages to the exising (MMU) uml code.

with that, we're proposing this patchset.

> Where do you see this differently?

thanks for the careful prompt for me.
I hope my answer clarifies your concerns.

I also wish to understand concerns of maintainers, due to the single
process design of nommu for um userspace, and the codebase is still
young so may have unexpected influence to others.  but this is exactly
the reason why I also put myself to MAINTAINERS in order to take care
of this patchset even it is small (1.3k loc).


-- Hajime

