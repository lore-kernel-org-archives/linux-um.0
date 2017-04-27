Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Apr 2017 07:04:14 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] um: Fix to call read_initrd after init_bootmem
Message-Id: <20170428070414.50ace979df068df258ba92ce@kernel.org>
In-Reply-To: <5ca2f3ce-eba3-d306-b52f-061361c59bb1@nod.at>
References: <149326283034.18877.3371130154502733533.stgit@devbox>
        <149326290055.18877.8217119813162466170.stgit@devbox>
        <5ca2f3ce-eba3-d306-b52f-061361c59bb1@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Richard,

On Thu, 27 Apr 2017 15:53:25 +0200
Richard Weinberger <richard@nod.at> wrote:

> Masami,
> 
> Am 27.04.2017 um 05:15 schrieb Masami Hiramatsu:
> > Since read_initrd() invokes alloc_bootmem() for allocating
> > memory to load initrd image, it must be called after init_bootmem.
> > 
> > This makes read_initrd() called directly from setup_arch()
> > after init_bootmem() and mem_total_pages().
> 
> Thanks for fixing this! Did you figure since when this is broken?
> I think that should go into -stable.

Thank you for quick response!
As far as I can see, v4.9 kernel has this issue, but v4.4 is OK.
Let me bisect it.

Thank you,

> 
> Thanks,
> //richard


-- 
Masami Hiramatsu <mhiramat@kernel.org>

