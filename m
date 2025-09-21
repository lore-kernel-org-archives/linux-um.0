Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E4FCAC5A8
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8p9taVRq2gq6tcyh60hYEpVIty1zhg9EsBjjZQFZvkY=; b=Z0FvSkJ8Ik3quwghvHc97HMKHf
	UfBcDzooSQgqTzWuRxu4Cp00wUyjEezVe1MOiiRoxzOjbdUbznlJ/1uCX8HTo3iO/5b97AJoknwoN
	7DN03wJTmGI1Bh4wZVMoKRetLgXfQVOnZ33IjN2k7emNqtA+Jk2c0pOqyIonwSE0IxQCSOJnurHT8
	EIe4rlhfCODA3SrdE2Boe/GkmuGiV5OaSZ2jQcMX6AEw54J4ronT7wgN51gToz/omjbhHZP4Bxia0
	Imsk4F8AD9vzFcm2e6iRBjjXW6vJH60/ChrY4P9S2r5xRiGmWxKglZzLouwvRDswxQ0cv/g8PxWwe
	AE3qWfIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0FCF-000000073ao-2Ijq;
	Sun, 21 Sep 2025 08:13:23 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0FCC-000000073Zj-3bOR
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 08:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758442398; bh=8p9taVRq2gq6tcyh60hYEpVIty1zhg9EsBjjZQFZvkY=;
	h=From:Message-ID:From;
	b=RwDQcvJCSqKgPtEE6Y6VTFKihOev/aZftmf36tAJ9ZOnkk6TQwj0dlDYNKYJsbQyJ
	 z2vcZHaD7LPaDbCTDG/qkbvBkflWietzyd1oO0XS1G8aFhpCNZ4NVTUcsZSR0G8oi6
	 BlFXEgQXbKoR1mGqKwaOVuNQwM81tEjPkHvF4nd4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D0D8AC072E;
	Sun, 21 Sep 2025 10:13:18 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58L8DIKA016800;
	Sun, 21 Sep 2025 10:13:18 +0200
Date: Sun, 21 Sep 2025 10:13:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 07/11] um: add infrastructure to build files using
 nolibc
Message-ID: <20250921081318.GB16684@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-8-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-8-benjamin@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_011321_182237_5328C4AC 
X-CRM114-Status: GOOD (  18.00  )
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

Hi Benjamin,

On Fri, Sep 19, 2025 at 05:34:16PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
> than libc. With this it is possible to move to nolibc in smaller steps.
> 
> Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
> simple and cannot handle threading. nolibc provides sys_* functions that
> do not emulate the libc errno behaviour and can be used instead.

Just for my understanding, in case we can improve portability, why is it
needed to disable errno processing here ? Even if it's limited, it
shouldn't cause trouble. I mean that if a program works with it defined,
logically it should also work without since the only difference is that
the errno global variable will not be defined nor assigned on syscall
returns.

> Guard the syscall definition as it is a macro in nolibc.

This one is interesting:

  --- a/arch/um/include/shared/os.h
  +++ b/arch/um/include/shared/os.h
  @@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
   /* tty.c */
   extern int get_pty(void);

  +#ifndef NOLIBC
   long syscall(long number, ...);
  +#endif

In nolibc, the syscall() definition indeed looks like this now:

  #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
  #define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
  #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
  #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
  #define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)

Except by mapping all syscalls to _syscall(6, ...) and always passing
6 args, I'm not seeing any easy way to dynamically adapt to the number
of arguments if we wanted to move it to a function. Also, a static
function would still conflict with the definition above. I'm wondering
about what extent the documented "long syscall(number, ...)" is valid in
fact, as I doubt it's really implemented anywhere as a generic function
taking the maximum amount of args.

Thus I think that the guard is indeed the only option to reconciliate these
two incompatible approaches. By the way I think it could be more future-
proof to do the guard on the syscall macro definition itself (which would
thus also resist it being passed by "-Dsyscall(x)=(...)" or any other form:

  +#ifndef syscall
   long syscall(long number, ...);
  +#endif

Regards,
Willy

