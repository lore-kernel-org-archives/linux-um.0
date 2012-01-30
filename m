Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 30 Jan 2012 19:32:38 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120130193238.GM23916@ZenIV.linux.org.uk>
References: <1327512234-22578-1-git-send-email-richard@nod.at>
 <20120130182333.GK23916@ZenIV.linux.org.uk>
 <20120130192552.GL23916@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120130192552.GL23916@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] um: Use generic io.h
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jan 30, 2012 at 07:25:52PM +0000, Al Viro wrote:

> While we are at it, param.h and pci.h appear to be candidates for the
> same treatment, along with delay.h and auxvec.h.  mutex.h as well...
> BTW, we probably can kill arch/um/include/asm/asm-offsets.h - everything
> in there is using generated/asm-offsets.h directly.
> 
> FWIW, I'd probably kill current.h as well - replace get_current() in
> arch/um/kernel/process.c with get_current_pid() (i.e. task_pid_nr(current)),
> kill HOST_TASK_PID and switch arch/x86/um/bugs_32.c to use of get_current_pid()
> and we can switch to asm-generic/current.h just fine.

BTW, while looking at those headers - why do we need asm/user.h pulled from
arch/um/include/asm/ptrace-generic.h? 
