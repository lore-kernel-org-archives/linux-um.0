Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D8CC71157
	for <linux-um@archiver.kernel.org>; Sat, 21 Jun 2025 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X53vOJjIymMVYj3rg5nCjdf5UDKh2QhE/Cj2wkuLezE=; b=MTL+2pVZNuK6yekqZ4nP3swufe
	hpmMBy04JhG3e802P0vK50LNtkIATxPkAnAqqHKlsoD2onUneJj9DTaiTtdlOPlh82ShJYPLAUUFO
	t9x2p4fldsEOwJmDafTLvwuUQnN7uXd2SGWLUfGfPUOtjRypPA0ZmjK0Z0VwGCGxp00npZbMOC5LW
	RTSggrTaKuiI2spcZonCDuJ5w2rxyDte6tuOtMgSeD5+KwBMomS+0+qM6oL0+G4GqhBw/GOY2fLOb
	FOc1vLaBJl10SJK3Iq7TrNHUehxqRM40fcpwjrftVlwKenTJy93ZJs7l2wqZ5/TWti3p5qOkTNF9e
	qW0WweVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSxWJ-0000000HRHt-483G;
	Sat, 21 Jun 2025 12:40:31 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSxWH-0000000HRHZ-3YIs
	for linux-um@lists.infradead.org;
	Sat, 21 Jun 2025 12:40:31 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-234d366e5f2so36267405ad.1
        for <linux-um@lists.infradead.org>; Sat, 21 Jun 2025 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750509629; x=1751114429; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X53vOJjIymMVYj3rg5nCjdf5UDKh2QhE/Cj2wkuLezE=;
        b=dRhUXS7MUA/AHo8U/s5vh1o5poa8GthrYc4Lw/sdR5SnJNORI6nMouCsyVH8vzqBe3
         GH2fGx0OCvyfa/6JKPJIcwSg89yzcsVCXj5a3DMismJRtThLCmJ9ZGqZAIBroaD/2yiB
         w2Z7rP4rxJBK063XknEVRaN8NLP9fADF9hM7MZyPGIfb5BBmOrcRqo5ilxnzoJ7J+gML
         +o6UWw+I21YQQoXmNXYUmp/9gaHCWpj2oKwiGdQIq/pMEnt8lz6vjf4lmoXV0dGGJV6C
         9GCVbIb/zEu2ZtleC5hu5itoLnCaS1kKKZqxBQkzj8+LwzcYEmCpXbFpkPiGHb3mXBOh
         rJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750509629; x=1751114429;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X53vOJjIymMVYj3rg5nCjdf5UDKh2QhE/Cj2wkuLezE=;
        b=kwIHHxfD6CBT4zGqisktwFjjJyP40GaVGRep0Gfj1kh+YvqYM73SqTZZcrwsqY3QMx
         DZdqVjE9CFYnsaY7oS11RQkubChwtghsJfFE865MS09XGfbuYSomHGGYdgBOGQpgXBQT
         VKNb13nCXuUpAZcwdv8CqqgMX3PBB1I7I6ZagpATATRpxPsRFA+n8ntO+BJNXInCrJcJ
         YTFQASWQsqiJ6GDIvW4WqNXIoC+i6CjpbOpo2f/vhB1HqzmwPjHy8vrgzVEzi+3orU7X
         Mg8nvC5RkRnUTBd0nO74Dhq8bjzbuGeO0reGCzx/WWCXrJqEnhAiPVVq/3H3oqEP+Lji
         CZhg==
X-Gm-Message-State: AOJu0YxZzZhShAQJUnhRBZvzFYN8zl+TpCfn5ked+LKpDaw8TJCM0VJI
	cXezg3q56dxcBt3r0tN1a8wXlUUlMUCKovKiIAV1V8tRF1obCiJimAqP
X-Gm-Gg: ASbGncvaeeTF72uhSkVBarnEa/rMayZcrXMKZrBNXA2rfC8k5EzlL308rVRWQ7ogXsu
	KR3HvAc4A8ZRD4k0BTDxv7L+WZYld5gp30QID9LUQ/O8e0MRWrj0BZDvC91Qvrtb95TRJ7s8/QX
	eBKu4omMbZ7XzpN7ZW7ucz0VXVGxHrBXLG0I4tImhwMsxI/5c3r+93CRLX38IM1wcCt+wIl/pBD
	LTuHLJ54UkWKzRKoi8lTPJrK0174fiVQgbchAhe3ErQ0LsXtyXzGceURKi70z6l8BqTxZkYUx+P
	SST9i/U05XU1haF87NCDwcx4BL05gLRpk0eTkOvmlBcgM0JgCBq3AX/32CoyKUSiUm50XeyEjGG
	YqtRmucMz1Blw1JcQH6pAscDv/LMvr7uBWkb6PQ9lADMxAg81
X-Google-Smtp-Source: AGHT+IG6rnMFp0fPbWQL97P6anz8S84CbsAQpI5tkYA8t300ZsC8H2blMYMaqz/RjZW3WG8e7tkf/g==
X-Received: by 2002:a17:902:d58d:b0:235:ef56:7800 with SMTP id d9443c01a7336-237d9917c20mr84978105ad.30.1750509628618;
        Sat, 21 Jun 2025 05:40:28 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71ea8sm4210760a91.7.2025.06.21.05.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 05:40:27 -0700 (PDT)
Date: Sat, 21 Jun 2025 21:40:24 +0900
Message-ID: <m24iw95kuf.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/13] x86/um: nommu: syscall handling
In-Reply-To: <d1d08a207844b98d0beba96f48beaf73e30c3bd2.camel@sipsolutions.net>
References: <cover.1750294482.git.thehajime@gmail.com>
	<bc5a2a14d41add7a2a44b12a21d9ccfa68a6baa5.1750294482.git.thehajime@gmail.com>
	<d1d08a207844b98d0beba96f48beaf73e30c3bd2.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250621_054029_903024_BB1B2FDF 
X-CRM114-Status: GOOD (  20.22  )
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


On Thu, 19 Jun 2025 19:31:53 +0900,
Benjamin Berg wrote:

> > diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
> > new file mode 100644
> > index 000000000000..5d0fa83e7fdc
> > --- /dev/null
> > +++ b/arch/x86/um/nommu/do_syscall_64.c
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/ptrace.h>
> > +#include <kern_util.h>
> > +#include <sysdep/syscalls.h>
> > +#include <os.h>
> > +
> > +__visible void do_syscall_64(struct pt_regs *regs)
> > +{
> > +	int syscall;
> > +
> > +	syscall = PT_SYSCALL_NR(regs->regs.gp);
> > +	UPT_SYSCALL_NR(&regs->regs) = syscall;
> > +
> > +	pr_debug("syscall(%d) (current=%lx) (fn=%lx)\n",
> > +		 syscall, (unsigned long)current,
> > +		 (unsigned long)sys_call_table[syscall]);
> 
> You probably want to drop the pr_debug from the syscall path.

okay, I'll update those parts.

> > +	if (likely(syscall < NR_syscalls)) {
> > +		PT_REGS_SET_SYSCALL_RETURN(regs,
> > +				EXECUTE_SYSCALL(syscall, regs));
> > +	}
> > +
> > +	pr_debug("syscall(%d) --> %lx\n", syscall,
> > +		regs->regs.gp[HOST_AX]);
> > +
> > +	PT_REGS_SYSCALL_RET(regs) = regs->regs.gp[HOST_AX];
> > +
> > +	/* execve succeeded */
> > +	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
> > +		userspace(&current->thread.regs.regs);
> 
> That said, this is what I am stumbling over. Why do you need to jump
> into userspace() here? It seems odd to me to need a special case in the
> syscall path itself.
> Aren't there other possibilities to hook/override the kernel task
> state?

thanks, I found that this is a leftover of our early implementation
which doesn't have a proper schedule upon an exit from syscall.  we
can remove this part and I'll fix them after more investigation.

> > +	/* force do_signal() --> is_syscall() */
> > +	set_thread_flag(TIF_SIGPENDING);
> > +	interrupt_end();
> 
> Same here. The MMU UML code seems to also do this, but restricted to
> ptrace'd processes? Maybe I am just missing something obvious …

nommu doesn't have separate process/context to indicate a schedule to
the context here (syscall).  without that part we do not have a chance
to schedule tasks and signals to userspace.

But the force on SIGPENDING flag is not actually needed so, I'll
remove that part.

thanks for pointing out.

-- Hajime

