Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Fix to call read_initrd after init_bootmem
References: <149326283034.18877.3371130154502733533.stgit@devbox>
 <149326290055.18877.8217119813162466170.stgit@devbox>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5ca2f3ce-eba3-d306-b52f-061361c59bb1@nod.at>
Date: Thu, 27 Apr 2017 15:53:25 +0200
MIME-Version: 1.0
In-Reply-To: <149326290055.18877.8217119813162466170.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Masami,

Am 27.04.2017 um 05:15 schrieb Masami Hiramatsu:
> Since read_initrd() invokes alloc_bootmem() for allocating
> memory to load initrd image, it must be called after init_bootmem.
> 
> This makes read_initrd() called directly from setup_arch()
> after init_bootmem() and mem_total_pages().

Thanks for fixing this! Did you figure since when this is broken?
I think that should go into -stable.

Thanks,
//richard

