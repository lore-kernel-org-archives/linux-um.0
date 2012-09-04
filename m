Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5046346F.802@xenotime.net>
Date: Tue, 04 Sep 2012 10:03:43 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <20120904171330.f6b0a922a754ba0f3acc123b@canb.auug.org.au>
In-Reply-To: <20120904171330.f6b0a922a754ba0f3acc123b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: linux-next: Tree for Sept 4 (uml + execve)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 09/04/2012 12:13 AM, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20120824:
>


UML on x86_64 (defconfig):

fs/built-in.o: In function `kernel_execve':
fs/exec.c:2342: multiple definition of `kernel_execve'
arch/um/kernel/built-in.o:arch/um/kernel/syscall.c:57: first defined here
fs/built-in.o: In function `sys_execve':
fs/exec.c:2327: multiple definition of `sys_execve'
arch/um/kernel/built-in.o:arch/um/kernel/exec.c:77: first defined here


-- 

~Randy
