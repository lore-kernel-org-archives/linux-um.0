Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXzTj-00AJ6B-Mu
 for linux-um@lists.infradead.org; Sun, 18 Apr 2021 04:56:20 +0000
Received: by mail-pl1-x631.google.com with SMTP id o16so2413646plg.5
 for <linux-um@lists.infradead.org>; Sat, 17 Apr 2021 21:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210417163949.530921-1-zhuyifei1999@gmail.com>
 <9722b8ce233ad4d7020588f9dd60a3037455754d.camel@sipsolutions.net>
In-Reply-To: <9722b8ce233ad4d7020588f9dd60a3037455754d.camel@sipsolutions.net>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Sat, 17 Apr 2021 23:56:03 -0500
Message-ID: <CABqSeATg2558BgMWMBs3O3vuR9wWS30d=x2iug3S-M1eMFi+qQ@mail.gmail.com>
Subject: Re: [PATCH] uml/helper: Fix stack alignment
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Apr 17, 2021 at 2:40 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> How about the same pattern in start_userspace() and new_thread()?
> Doesn't matter for some reason? Or just didn't hit it yet because
> there's no 16-byte "thing" on the stack?

I see. I was not aware they were there. Didn't hit :)

* start_userspace -- yes, the exact same pattern via clone.
* new_thread -- no, this is a longjmp buffer that sets the instruction
pointer and stack pointer directly. It emulates a call instruction, as
if the return address has already been pushed. Let me give an example.

The clone trace works like:

  ; 16-aligned
  callq  *%rax ; push 8
  push   %rbp ; push 8
  ; 16 aligned
  mov    %rsp,%rbp

However, for a longjmp buffer, it will jump directly to `push %rbp`,
so a 8-offset is needed to account for the missing offset from `callq
*%rax`.

In my case, if I remove this offset from new_thread, init_thread_regs,
and start_idle_thread, it will segfault loop in ZSTD_getParams while
initializing btrfs.

Other places I found similar patterns:
* init_thread_regs & start_idle_thread -- no,  longjmp buffers, same
as new_thread.
* ubd_driver_init -- yes, same as run_helper.
* set_sigstack -- This one is interesting:
  * um on native x86_64: a quick test reveals that whether the offset
is used does not affect the stack pointer. In the code, upon signal
delivery (in the host kernel) get_sigframe calls align_sigframe, so
unaligned stack pointers make no difference.
  * um on um x86_64: I'm having trouble testing um within um, getting
a weird error ("start_userspace : expected SIGSTOP, got status = 2943"
when starting init, might try to debug later), but the code in
handle_signal also aligns the stack.
  * The man page of sigaltstack and a quick google search shows that
the conventional usage of sigaltstack does not reduce the size of
stack by sizeof(void *), so I think it's probably best to follow the
convention here.
* stub_clone_handler -- This looks fragile:
  * As far as I understand, it splits the STUB_DATA page into half,
the higher-address half for the parent to run the stub (from
init_thread_regs) and the lower half are switched to in the child.
This is fragile. The clone syscall to the host is done in the middle
of a function body and we are depending on the compiler optimizations
that it won't store any shared variables on stack that would be
missing once the stack pointer is set to something else. Similarly,
the base pointer is still shared between the two processes. It's also
dependent on optimizations to say shared variables won't overwrite
each other.
  * I'm thinking, considering that we don't have CLONE_VM set in the
stub, is it possible to force the child to map a private page for use
as a stack, so modifications to the stack done inside the child are
not seen by the parent?
  * That said, it's still potentially trouble-causing if during the
body of the function the stack pointer isn't aligned. I can't think of
any case where GCC would want to use aligned SSE instructions in the
stub, however.

I also realized, I've been compiling um with CONFIG_FRAME_POINTER,
hence the use of rbp. I just also checked how if the bug can be
reproduced without CONFIG_FRAME_POINTER, and yes, the same segfault
loop, and the assembly just bases the pointers off of rsp rather than
rbp, still assuming the 16 byte alignment.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

