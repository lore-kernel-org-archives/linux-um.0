Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzRtr-004Bjy-PC
 for linux-um@lists.infradead.org; Fri, 02 Jul 2021 22:44:45 +0000
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
References: <20210414055217.543246-1-avagin@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <6073e4c6-6fe8-0448-4586-5d04d7154164@kernel.org>
Date: Fri, 2 Jul 2021 15:44:41 -0700
MIME-Version: 1.0
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

On 4/13/21 10:52 PM, Andrei Vagin wrote:

> process_vm_exec has two modes:
> 
> * Execute code in an address space of a target process and stop on any
>   signal or system call.

We already have a perfectly good context switch mechanism: context
switches.  If you execute code, you are basically guaranteed to be
subject to being hijacked, which means you pretty much can't allow
syscalls.  But there's a lot of non-syscall state, and I think context
switching needs to be done with extreme care.

(Just as example, suppose you switch mms, then set %gs to point to the
LDT, then switch back.  Now you're in a weird state.  With %ss the plot
is a bit thicker.  And there are emulated vsyscalls and such.)

If you, PeterZ, and the UMCG could all find an acceptable, efficient way
to wake-and-wait so you can switch into an injected task in the target
process and switch back quickly, then I think a much nicer solution will
become available.

> 
> * Execute a system call in an address space of a target process.

I could get behind this, but there are plenty of cans of worms to watch
out for.  Serious auditing would be needed.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

