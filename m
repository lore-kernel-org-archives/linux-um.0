Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1757579AbZCMHm0@vger.kernel.org>
Date: Fri, 13 Mar 2009 15:42:32 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/2] ptrace_vm: ptrace for syscall emulation virtual
	machines
Message-ID: <20090313074232.GA8933@hack>
References: <20090204080236.GA17452@cs.unibo.it> <20090310214436.GC5213@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090310214436.GC5213@cs.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Roland McGrath <roland@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Mar 10, 2009 at 10:44:36PM +0100, Renzo Davoli wrote:
>Cong,
>
>I have updated the PTRACE_VM patches.
>The patches have been rebased to linux-2.6.29-rc7 but apply to linux-2.6.29-rc7-git3.
>
>The set is composed by two patches.
>The first one is for all those architectures where PTRACE_SYSCALL is
>managed via tracehook (x86, powerpc etc).
>Given the wonderful work by Roland McGrath this patch is now
>architecture independent and straightforward simple.
>
>The second one is the support of PTRACE_VM for user-mode-linux.
>It provides PTRACE_VM for UML processes and uses PTRACE_VM of the hosting 
>kernel.
>

Hello, Renzo!

Thanks very much for your patches!

I am sorting these, give me some more time, since I am not so familiar
with ptrace. :^)

And also let's Cc Roland to see if we can get any feedbacks from him.

Thanks.

-- 
Do what you love, f**k the rest! F**k the regulations!
 
