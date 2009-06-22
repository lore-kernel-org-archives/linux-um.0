Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1753593AbZFVIzl@vger.kernel.org>
Date: Mon, 22 Jun 2009 16:57:35 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
Message-ID: <20090622085735.GB6499@cr0.nay.redhat.com>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com> <4A3F4448.30502@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A3F4448.30502@panasas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Menage <menage@google.com>, akpm@linux-foundation.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jun 22, 2009 at 11:43:52AM +0300, Boaz Harrosh wrote:
>
>Stephan hi.
>
>The above breakage is the usual stuff we get every merge window. With people doing
>cross arch work and neglecting UML.
>
>Who is the person or people responsible for the large linux-next compilation rig?
>Is it possible to also add a UML traget, at least for the x86_64/x86_32 sub-arch?

Agreed.

Stephan, could you please also do compiling tests for UML in your -next tree?

Thanks!
