Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYZly-00BcXB-5d
 for linux-um@lists.infradead.org; Mon, 19 Apr 2021 19:41:33 +0000
Message-ID: <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Fix stack pointer alignment
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 19 Apr 2021 21:41:19 +0200
In-Reply-To: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
References: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
MIME-Version: 1.0
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, linux-um@lists.infradead.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>

On Mon, 2021-04-19 at 10:32 -0500, YiFei Zhu wrote:
> 
> On the other hand, glibc reserves the 16 bytes it needs on stack
> and pops itself, so by the call instruction the stack pointer
> is exactly the caller-supplied sp. It then push the 16 bytes of
> the return address and the saved stack pointer, so the base
> pointer will be 16-byte aligned if and only if the caller
> supplied sp is 16-byte aligned. Therefore, the caller must supply
> a 16-byte aligned pointer, which `stack + UM_KERN_PAGE_SIZE`
> already satisfies.
> 
> On a side note, musl is unaffected by this issue because it forces
> 16 byte alignment via `and $-16,%rsi` in its clone wrapper.
> Similarly, glibc i386 is also uneffected because it has
> `andl $0xfffffff0, %ecx`.

I wonder if this isn't really a glibc bug?

After all, the man page states no alignment restrictions, except when
documenting the error codes:

EINVAL
stack is not aligned to a suitable boundary for  this  architecture. 
For example, on aarch64, stack must be a multiple of 16.

> To reproduce this bug, enable CONFIG_UML_RTC. uml_rtc will call
> add_sigio_fd which will then cause write_sigio_thread to go
> into segfault loop.

It must also depend on the glibc version, because I've definitely been
testing UML_RTC on 64-bit, on Fedora 32 at the time.


That said, I agree with pretty much everything else you said here.

> 
> Similarly, signal stacks will be aligned by the host kernel upon
> signal delivery. `- sizeof(void *)` to sigaltstack is
> unconventional and extraneous.
> 
> On a related note, initialization of longjmp buffers do require
> `- sizeof(void *)`. This is to account for the return address
> that would have been pushed to the stack at the call site.
> 
> The reason for uml to respect 16-byte alignment, rather than
> telling GCC to assume 8-byte alignment like the host kernel since
> commit d9b0cde91c60 ("x86-64, gcc: Use
> -mpreferred-stack-boundary=3 if supported"), is because uml links
> against libc. There is no reason to assume libc is also compiled
> with that flag and assumes 8-byte alignment rather than 16-byte.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838
> [2] https://c9x.me/x86/html/file_module_x86_id_180.html
> 
> Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

