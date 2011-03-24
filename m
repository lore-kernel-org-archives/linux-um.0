Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Mar 2011 09:25:23 +0100
From: Tejun Heo <tj@kernel.org>
Message-ID: <20110324082523.GA12038@htj.dyndns.org>
References: <4CC69B22.2050708@kernel.org>
 <20101025224111.7798.38960.stgit@warthog.procyon.org.uk>
 <12101.1288088542@redhat.com>
 <4CC6C62F.1000804@kernel.org>
 <4CC6C941.2080003@kernel.org>
 <4CC6CD4D.3010501@kernel.org>
 <4CC6E05A.8040508@kernel.org>
 <AANLkTi=WWCPJeQ8DVv1j7GF0J61DiUupiOEuxDCW8_Xd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <AANLkTi=WWCPJeQ8DVv1j7GF0J61DiUupiOEuxDCW8_Xd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [Uclinux-dist-devel] [RFC PATCH] percpu: always align percpu
 output section to PAGE_SIZE
To: Mike Frysinger <vapier@gentoo.org>
Cc: torvalds@osdl.org, Alexander van Heukelum <heukelum@fastmail.fm>, linux-am33-list@redhat.com, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, uclinux-dist-devel@blackfin.uclinux.org, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Akira Takeuchi <takeuchi.akr@jp.panasonic.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello,

On Thu, Mar 24, 2011 at 02:46:01AM -0400, Mike Frysinger wrote:
> On Tue, Oct 26, 2010 at 10:06, Tejun Heo wrote:
> > The linker script macros PERCPU_VADDR() and PERCPU() are used to
> > define this output section and the latter takes @align parameter.
> > Several architectures are using @align smaller than PAGE_SIZE break=
ing
> > percpu memory alignment.
>=20
> hmm, i just pushed through a fix in the Blackfin tree as we hit a boo=
t
> failure otherwise:
> -   PERCPU(4)
> +   PERCPU(PAGE_SIZE)
>=20
> > This patch removes @align parameter from PERCPU(), renames it to
> > PERCPU_SECTION and makes it always align to PAGE_SIZE. =A0While at =
it,
> > add PCPU_SETUP_BUG_ON() checks such that alignment problems are
> > reliably detected and remove percpu alignment comment recently adde=
d
> > in workqueue.c as the condition would trigger BUG way before reachi=
ng
> > there.
>=20
> seems this still hasnt made it to mainline.  has it stalled or
> something ?  feel free for the Blackfin bits:
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Heh, I just forgot.  I'll queue it with your Acked-by added.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

