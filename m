Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Apr 2017 07:40:39 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] um: Fix to call read_initrd after init_bootmem
Message-Id: <20170428074039.7b95c958b7e156594db1f096@kernel.org>
In-Reply-To: <20170428070414.50ace979df068df258ba92ce@kernel.org>
References: <149326283034.18877.3371130154502733533.stgit@devbox>
        <149326290055.18877.8217119813162466170.stgit@devbox>
        <5ca2f3ce-eba3-d306-b52f-061361c59bb1@nod.at>
        <20170428070414.50ace979df068df258ba92ce@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 28 Apr 2017 07:04:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Richard,
> 
> On Thu, 27 Apr 2017 15:53:25 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > Masami,
> > 
> > Am 27.04.2017 um 05:15 schrieb Masami Hiramatsu:
> > > Since read_initrd() invokes alloc_bootmem() for allocating
> > > memory to load initrd image, it must be called after init_bootmem.
> > > 
> > > This makes read_initrd() called directly from setup_arch()
> > > after init_bootmem() and mem_total_pages().
> > 
> > Thanks for fixing this! Did you figure since when this is broken?
> > I think that should go into -stable.
> 
> Thank you for quick response!
> As far as I can see, v4.9 kernel has this issue, but v4.4 is OK.
> Let me bisect it.

Finally, git bisect shows that below commit caused this issue.

b63236972e1344b247750451e2be0a06cd125f21 is the first bad commit
commit b63236972e1344b247750451e2be0a06cd125f21
Author: Richard Weinberger <richard@nod.at>
Date:   Sun Jun 12 21:56:42 2016 +0200

    um: Setup physical memory in setup_arch()
    
    Currently UML sets up physical memory very early,
    long before setup_arch() was called by the kernel main
    function.
    This can cause problems when code paths in UML's memory setup
    code assume that the kernel is already running.
    i.e. when kmemleak is enabled it will evaluate current()
    in free_bootmem(). That early current() is undefined and
    UML explodes.
    
    Solve the problem by setting up physical memory in setup_arch(),
    at this stage the kernel has materialized and basic infrastructure
    such as current() works.
    
    Signed-off-by: Richard Weinberger <richard@nod.at>

:040000 040000 94b9403e37b4d14b54f801198af71aed66b07a30 641f2309b7badd723f1996f141aad962255dd689 M	arch

For the stable, any kernel later than v4.8 has this issue.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

