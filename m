Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6F2D2F7F9
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2V0ApgjItLuyOesEDQRZL0OmA9spSZb4In4L/5xLGf8=; b=ZDDxwJiUyoZ0kbTOH00svNyxyL
	S/9ZIKNnOvKQUDId53jiKpEmseAw3wLwlySKMYZagi7W77KZiRLPgjRye8DrQ1020MCrQWErQ02g7
	HQnwb4lW5LMfXmcA8Pl8ZnDNM1sbglgs6CWvPor+UZ+OwGoG5evo1cFIiX1DANcWsBUp7CGZuWoOA
	8iMIlE7uu93GPBAP+ta6Bng5HE1ZV5JuIb+kXGA96LZLz8on6P0S7V/5FamzLzdMMdOd9aEL7obLw
	F5kMarhsGeguPT46pCZpenN57s30GD132czMW4ZaPIBQ/yR9KGrErbjalB74sg9jLV4ccy+yx2fNg
	3So17pkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Kpj-0000000Dz5T-1RAf;
	Thu, 17 Oct 2024 07:22:07 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Klq-0000000DyWk-3Tjy
	for linux-um@lists.infradead.org;
	Thu, 17 Oct 2024 07:18:11 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6cbf340fccaso5057696d6.1
        for <linux-um@lists.infradead.org>; Thu, 17 Oct 2024 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729149481; x=1729754281; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2V0ApgjItLuyOesEDQRZL0OmA9spSZb4In4L/5xLGf8=;
        b=EiiMc/h7gBYiLnR/1MhcSYamYPWO5LAq3SIwc1+vsWSTzvBaiGIAnPv5pOTTpDsXJF
         Mw2O2Ab7Com7KK/rWey9iZhrTEL5ep8amASbrlAce9iQLKlaHBP1AMn17OoaTAwWeeKe
         yHWXoJ2ICc+e4scUuBcpJ2Rt/bvY1FwyLamea5TrE/13OYgQu/mzQ38ueGIOMeBeZKc3
         vMzn2ymcizJ7f9C9Rdmlu5asF82sYu6Mi/GZ2JPwtMXskwBQgZgkaeDXdQyAfxbfQAlg
         KNC+UEhOlST/C5IEPAshTnAKp6/OY7lSvbPaBH7EDwNiolQo1Ezw8+711++JV0ySVTlY
         +89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729149481; x=1729754281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2V0ApgjItLuyOesEDQRZL0OmA9spSZb4In4L/5xLGf8=;
        b=lhv28koSyEm0voRuoNAVfw2I4HKbbE3Rsx0wfX5xzJfAsDs265Nnvw/kkxh7Rv306c
         JmAhDdJYmpLpGZ9YCsuKZrlOFMGuFkppVZdPBUtWX/z79u515JAH8WLZbr58/Mw9nP1V
         p+sPnrRjaWta732uwvrS6BC37Jcf9ELPkHvAfuIT7jkUhGL3GO8N/iDSlFh4WHM85MPi
         vkP2CzoqL+yXfKm/tDsIE7zwmEXntKTTBo+0tjLjh2Su/I8aEq+jIc7qjU9aAUkqR9s2
         iPtapPo8OCCTca1tsn/48xPTbUOEl0FICHuOu1FqyosMLnmU68mgo5hESdtsV6CYQt7l
         fKiQ==
X-Gm-Message-State: AOJu0YzBCj8/2frsq8m7NUWd9e8pjjxUQKovW9zUml1QSumSl9JXLFsi
	tsH5yGJ732ei3ykaDQlG7rPxgNihvwiTpDUDQXPsgRHCKbwjqyqs9AyAZcWoZBSql9hA8uMO75E
	/HbhC/Elah/s/8muBMmM3L4PA5ZqcOlb/t1Wd
X-Google-Smtp-Source: AGHT+IE7++osXxsNikn2WMyJeQO1KnPESi4SzLp0+XyWELIA5AwNwO0A4uF/fVqRYPz1SiAfh2/1SnVTD42w6j79nnA=
X-Received: by 2002:a05:6214:3984:b0:6cb:e9da:bd4 with SMTP id
 6a1803df08f44-6cc3782459dmr37908006d6.5.1729149481203; Thu, 17 Oct 2024
 00:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240919124511.282088-1-benjamin@sipsolutions.net> <20240919124511.282088-3-benjamin@sipsolutions.net>
In-Reply-To: <20240919124511.282088-3-benjamin@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Thu, 17 Oct 2024 15:17:48 +0800
Message-ID: <CABVgOS=boUoG6=LHFFhxEd8H8jDP1zOaPKFEjH+iy2n2Q5S2aQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] um: use execveat to create userspace MMs
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>, 
	KUnit Development <kunit-dev@googlegroups.com>, Kees Cook <kees@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a1b5d40624a6fcbf"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_001806_922936_76611D71 
X-CRM114-Status: GOOD (  44.95  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--000000000000a1b5d40624a6fcbf
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 20:45, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> Using clone will not undo features that have been enabled by libc. An
> example of this already happening is rseq, which could cause the kernel
> to read/write memory of the userspace process. In the future the
> standard library might also use mseal by default to protect itself,
> which would also thwart our attempts at unmapping everything.
>
> Solve all this by taking a step back and doing an execve into a tiny
> static binary that sets up the minimal environment required for the
> stub without using any standard library. That way we have a clean
> execution environment that is fully under the control of UML.
>
> Note that this changes things a bit as the FDs are not anymore shared
> with the kernel. Instead, we explicitly share the FDs for the physical
> memory and all existing iomem regions. Doing this is fine, as iomem
> regions cannot be added at runtime.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>
> ---
>
> v9:
> - Avoid clash of libc __close_range with the kernel version,
>   thanks to Tiwei Bie for pointing this out
>
> v8:
> - Make changes suggested by Johannes Berg
>
> v7:
> - Rename stub_elf to stub_exe
> - Move into architecture independent directory
> - Fix 32 bit issues
> - Improve tempfile logic
> - Other cleanups
>
> v6:
> - Apply fixes pointed out by Tiwei Bie
> - Add temporary file fallback as memfd is not always supported
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---

It turns out that this breaks the KUnit user alloc helpers on x86_64,
at least on my machine.

This can be reproduced with:
./tools/testing/kunit/kunit.py run usercopy

Though the 32-bit version works:
./tools/testing/kunit/kunit.py run usercopy --kconfig_add CONFIG_64BIT=n

The error we're getting is:
start_userspace : expected SIGSTOP, got status = 139
Could not create userspace mm

This basically is the result of the stub_exe segfaulting very early on
in its execution.

It seems that this is due to the stack being misaligned, and so the
generated SSE instructions are faulting. The workarounds I've tested
here include:
a) Build the stub with -mno-sse
b) Decorate real_init() with __attribute__((force_align_arg_pointer))
c) Decorate __start() with __attribute__((naked))

The last one seems to validate my theory as to why this is occurring:
__start's prologue is misaligning the stack, as __start is not
actually _called_ from anything, so there's no 8-byte misalignment to
hold the return address.

If this makes sense, I'll send a patch out with whichever the
preferred fix(es) are. My guess is that (c) is the "proper" fix,
though I'd not _miss_ SSE if we chose to disable it for the handful of
instructions here anyway.

Cheers,
-- David

>  arch/um/Makefile                        |   3 +-
>  arch/um/include/shared/skas/stub-data.h |  11 ++
>  arch/um/kernel/skas/.gitignore          |   2 +
>  arch/um/kernel/skas/Makefile            |  33 ++++-
>  arch/um/kernel/skas/stub_exe.c          |  88 ++++++++++++
>  arch/um/kernel/skas/stub_exe_embed.S    |  11 ++
>  arch/um/os-Linux/mem.c                  |   2 +-
>  arch/um/os-Linux/skas/process.c         | 181 ++++++++++++++++--------
>  8 files changed, 271 insertions(+), 60 deletions(-)
>  create mode 100644 arch/um/kernel/skas/.gitignore
>  create mode 100644 arch/um/kernel/skas/stub_exe.c
>  create mode 100644 arch/um/kernel/skas/stub_exe_embed.S
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 00b63bac5eff..31e367e8ab4d 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -61,7 +61,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
>         $(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap      \
>         -Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
>         -Din6addr_loopback=kernel_in6addr_loopback \
> -       -Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
> +       -Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
> +       -D__close_range=kernel__close_range
>
>  KBUILD_RUSTFLAGS += -Crelocation-model=pie
>
> diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
> index 2b6b44759dfa..3fbdda727373 100644
> --- a/arch/um/include/shared/skas/stub-data.h
> +++ b/arch/um/include/shared/skas/stub-data.h
> @@ -12,6 +12,17 @@
>  #include <as-layout.h>
>  #include <sysdep/tls.h>
>
> +struct stub_init_data {
> +       unsigned long stub_start;
> +
> +       int stub_code_fd;
> +       unsigned long stub_code_offset;
> +       int stub_data_fd;
> +       unsigned long stub_data_offset;
> +
> +       unsigned long segv_handler;
> +};
> +
>  #define STUB_NEXT_SYSCALL(s) \
>         ((struct stub_syscall *) (((unsigned long) s) + (s)->cmd_len))
>
> diff --git a/arch/um/kernel/skas/.gitignore b/arch/um/kernel/skas/.gitignore
> new file mode 100644
> index 000000000000..c3409ced0f38
> --- /dev/null
> +++ b/arch/um/kernel/skas/.gitignore
> @@ -0,0 +1,2 @@
> +stub_exe
> +stub_exe.dbg
> diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
> index 6f86d53e3d69..fbb61968055f 100644
> --- a/arch/um/kernel/skas/Makefile
> +++ b/arch/um/kernel/skas/Makefile
> @@ -3,14 +3,43 @@
>  # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>  #
>
> -obj-y := stub.o mmu.o process.o syscall.o uaccess.o
> +obj-y := stub.o mmu.o process.o syscall.o uaccess.o \
> +        stub_exe_embed.o
> +
> +# Stub executable
> +
> +stub_exe_objs-y := stub_exe.o
> +
> +stub_exe_objs := $(foreach F,$(stub_exe_objs-y),$(obj)/$F)
> +
> +# Object file containing the ELF executable
> +$(obj)/stub_exe_embed.o: $(src)/stub_exe_embed.S $(obj)/stub_exe
> +
> +$(obj)/stub_exe.dbg: $(stub_exe_objs) FORCE
> +       $(call if_changed,stub_exe)
> +
> +$(obj)/stub_exe: OBJCOPYFLAGS := -S
> +$(obj)/stub_exe: $(obj)/stub_exe.dbg FORCE
> +       $(call if_changed,objcopy)
> +
> +quiet_cmd_stub_exe = STUB_EXE $@
> +      cmd_stub_exe = $(CC) -nostdlib -o $@ \
> +                          $(KBUILD_CFLAGS) $(STUB_EXE_LDFLAGS) \
> +                          $(filter %.o,$^)
> +
> +STUB_EXE_LDFLAGS = -n -static
> +
> +targets += stub_exe.dbg stub_exe $(stub_exe_objs-y)
> +
> +# end
>
>  # stub.o is in the stub, so it can't be built with profiling
>  # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
>  # disable it
>
>  CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
> -UNPROFILE_OBJS := stub.o
> +CFLAGS_stub_exe.o := $(CFLAGS_NO_HARDENING)
> +UNPROFILE_OBJS := stub.o stub_exe.o
>  KCOV_INSTRUMENT := n
>
>  include $(srctree)/arch/um/scripts/Makefile.rules
> diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
> new file mode 100644
> index 000000000000..bc6ba2e4d805
> --- /dev/null
> +++ b/arch/um/kernel/skas/stub_exe.c
> @@ -0,0 +1,88 @@
> +#include <sys/ptrace.h>
> +#include <sys/prctl.h>
> +#include <asm/unistd.h>
> +#include <sysdep/stub.h>
> +#include <stub-data.h>
> +
> +void _start(void);
> +
> +noinline static void real_init(void)
> +{
> +       struct stub_init_data init_data;
> +       unsigned long res;
> +       struct {
> +               void  *ss_sp;
> +               int    ss_flags;
> +               size_t ss_size;
> +       } stack = {
> +               .ss_size = STUB_DATA_PAGES * UM_KERN_PAGE_SIZE,
> +       };
> +       struct {
> +               void *sa_handler_;
> +               unsigned long sa_flags;
> +               void *sa_restorer;
> +               unsigned long long sa_mask;
> +       } sa = {
> +               /* Need to set SA_RESTORER (but the handler never returns) */
> +               .sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000,
> +               /* no need to mask any signals */
> +               .sa_mask = 0,
> +       };
> +
> +       /* set a nice name */
> +       stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace");
> +
> +       /* read information from STDIN and close it */
> +       res = stub_syscall3(__NR_read, 0,
> +                           (unsigned long)&init_data, sizeof(init_data));
> +       if (res != sizeof(init_data))
> +               stub_syscall1(__NR_exit, 10);
> +
> +       stub_syscall1(__NR_close, 0);
> +
> +       /* map stub code + data */
> +       res = stub_syscall6(STUB_MMAP_NR,
> +                           init_data.stub_start, UM_KERN_PAGE_SIZE,
> +                           PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED,
> +                           init_data.stub_code_fd, init_data.stub_code_offset);
> +       if (res != init_data.stub_start)
> +               stub_syscall1(__NR_exit, 11);
> +
> +       res = stub_syscall6(STUB_MMAP_NR,
> +                           init_data.stub_start + UM_KERN_PAGE_SIZE,
> +                           STUB_DATA_PAGES * UM_KERN_PAGE_SIZE,
> +                           PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
> +                           init_data.stub_data_fd, init_data.stub_data_offset);
> +       if (res != init_data.stub_start + UM_KERN_PAGE_SIZE)
> +               stub_syscall1(__NR_exit, 12);
> +
> +       /* setup signal stack inside stub data */
> +       stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
> +       stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
> +
> +       /* register SIGSEGV handler */
> +       sa.sa_handler_ = (void *) init_data.segv_handler;
> +       res = stub_syscall4(__NR_rt_sigaction, SIGSEGV, (unsigned long)&sa, 0,
> +                           sizeof(sa.sa_mask));
> +       if (res != 0)
> +               stub_syscall1(__NR_exit, 13);
> +
> +       stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
> +
> +       stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
> +
> +       stub_syscall1(__NR_exit, 14);
> +
> +       __builtin_unreachable();
> +}
> +
> +void _start(void)
> +{
> +       char *alloc;
> +
> +       /* Make enough space for the stub (including space for alignment) */
> +       alloc = __builtin_alloca((1 + 2 * STUB_DATA_PAGES - 1) * UM_KERN_PAGE_SIZE);
> +       asm volatile("" : "+r,m"(alloc) : : "memory");
> +
> +       real_init();
> +}
> diff --git a/arch/um/kernel/skas/stub_exe_embed.S b/arch/um/kernel/skas/stub_exe_embed.S
> new file mode 100644
> index 000000000000..6d8914fbe8f1
> --- /dev/null
> +++ b/arch/um/kernel/skas/stub_exe_embed.S
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +
> +__INITDATA
> +
> +SYM_DATA_START(stub_exe_start)
> +       .incbin "arch/um/kernel/skas/stub_exe"
> +SYM_DATA_END_LABEL(stub_exe_start, SYM_L_GLOBAL, stub_exe_end)
> +
> +__FINIT
> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
> index cf44d386f23c..857e3deab293 100644
> --- a/arch/um/os-Linux/mem.c
> +++ b/arch/um/os-Linux/mem.c
> @@ -42,7 +42,7 @@ void kasan_map_memory(void *start, size_t len)
>  }
>
>  /* Set by make_tempfile() during early boot. */
> -static char *tempdir = NULL;
> +char *tempdir = NULL;
>
>  /* Check if dir is on tmpfs. Return 0 if yes, -1 if no or error. */
>  static int __init check_tmpfs(const char *dir)
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index b6f656bcffb1..2caaa9e85752 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -10,8 +10,11 @@
>  #include <sched.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <fcntl.h>
> +#include <mem_user.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
> +#include <sys/stat.h>
>  #include <asm/unistd.h>
>  #include <as-layout.h>
>  #include <init.h>
> @@ -189,69 +192,135 @@ static void handle_trap(int pid, struct uml_pt_regs *regs)
>
>  extern char __syscall_stub_start[];
>
> -/**
> - * userspace_tramp() - userspace trampoline
> - * @stack:     pointer to the new userspace stack page
> - *
> - * The userspace trampoline is used to setup a new userspace process in start_userspace() after it was clone()'ed.
> - * This function will run on a temporary stack page.
> - * It ptrace()'es itself, then
> - * Two pages are mapped into the userspace address space:
> - * - STUB_CODE (with EXEC), which contains the skas stub code
> - * - STUB_DATA (with R/W), which contains a data page that is used to transfer certain data between the UML userspace process and the UML kernel.
> - * Also for the userspace process a SIGSEGV handler is installed to catch pagefaults in the userspace process.
> - * And last the process stops itself to give control to the UML kernel for this userspace process.
> - *
> - * Return: Always zero, otherwise the current userspace process is ended with non null exit() call
> - */
> +static int stub_exe_fd;
> +
>  static int userspace_tramp(void *stack)
>  {
> -       struct sigaction sa;
> -       void *addr;
> -       int fd;
> +       char *const argv[] = { "uml-userspace", NULL };
> +       int pipe_fds[2];
>         unsigned long long offset;
> -       unsigned long segv_handler = STUB_CODE +
> -                                    (unsigned long) stub_segv_handler -
> -                                    (unsigned long) __syscall_stub_start;
> -
> -       ptrace(PTRACE_TRACEME, 0, 0, 0);
> -
> -       signal(SIGTERM, SIG_DFL);
> -       signal(SIGWINCH, SIG_IGN);
> -
> -       fd = phys_mapping(uml_to_phys(__syscall_stub_start), &offset);
> -       addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
> -                     PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
> -       if (addr == MAP_FAILED) {
> -               os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
> -                       STUB_CODE, errno);
> -               exit(1);
> +       struct stub_init_data init_data = {
> +               .stub_start = STUB_START,
> +               .segv_handler = STUB_CODE +
> +                               (unsigned long) stub_segv_handler -
> +                               (unsigned long) __syscall_stub_start,
> +       };
> +       struct iomem_region *iomem;
> +       int ret;
> +
> +       init_data.stub_code_fd = phys_mapping(uml_to_phys(__syscall_stub_start),
> +                                             &offset);
> +       init_data.stub_code_offset = MMAP_OFFSET(offset);
> +
> +       init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
> +       init_data.stub_data_offset = MMAP_OFFSET(offset);
> +
> +       /* Set CLOEXEC on all FDs and then unset on all memory related FDs */
> +       close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
> +
> +       fcntl(init_data.stub_data_fd, F_SETFD, 0);
> +       for (iomem = iomem_regions; iomem; iomem = iomem->next)
> +               fcntl(iomem->fd, F_SETFD, 0);
> +
> +       /* Create a pipe for init_data (no CLOEXEC) and dup2 to STDIN */
> +       if (pipe2(pipe_fds, 0))
> +               exit(2);
> +
> +       close(0);
> +       if (dup2(pipe_fds[0], 0) < 0) {
> +               close(pipe_fds[0]);
> +               close(pipe_fds[1]);
> +               exit(3);
>         }
> +       close(pipe_fds[0]);
> +
> +       /* Write init_data and close write side */
> +       ret = write(pipe_fds[1], &init_data, sizeof(init_data));
> +       close(pipe_fds[1]);
> +
> +       if (ret != sizeof(init_data))
> +               exit(4);
> +
> +       execveat(stub_exe_fd, "", argv, NULL, AT_EMPTY_PATH);
>
> -       fd = phys_mapping(uml_to_phys(stack), &offset);
> -       addr = mmap((void *) STUB_DATA,
> -                   STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
> -                   MAP_FIXED | MAP_SHARED, fd, offset);
> -       if (addr == MAP_FAILED) {
> -               os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
> -                       STUB_DATA, errno);
> -               exit(1);
> +       exit(5);
> +}
> +
> +extern char stub_exe_start[];
> +extern char stub_exe_end[];
> +
> +extern char *tempdir;
> +
> +#define STUB_EXE_NAME_TEMPLATE "/uml-userspace-XXXXXX"
> +
> +#ifndef MFD_EXEC
> +#define MFD_EXEC 0x0010U
> +#endif
> +
> +static int __init init_stub_exe_fd(void)
> +{
> +       size_t written = 0;
> +       char *tmpfile = NULL;
> +
> +       stub_exe_fd = memfd_create("uml-userspace",
> +                                  MFD_EXEC | MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +       if (stub_exe_fd < 0) {
> +               printk(UM_KERN_INFO "Could not create executable memfd, using temporary file!");
> +
> +               tmpfile = malloc(strlen(tempdir) +
> +                                 strlen(STUB_EXE_NAME_TEMPLATE) + 1);
> +               if (tmpfile == NULL)
> +                       panic("Failed to allocate memory for stub binary name");
> +
> +               strcpy(tmpfile, tempdir);
> +               strcat(tmpfile, STUB_EXE_NAME_TEMPLATE);
> +
> +               stub_exe_fd = mkstemp(tmpfile);
> +               if (stub_exe_fd < 0)
> +                       panic("Could not create temporary file for stub binary: %d",
> +                             -errno);
>         }
>
> -       set_sigstack((void *) STUB_DATA, STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
> -       sigemptyset(&sa.sa_mask);
> -       sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
> -       sa.sa_sigaction = (void *) segv_handler;
> -       sa.sa_restorer = NULL;
> -       if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> -               os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
> -                       __func__, errno);
> -               exit(1);
> +       while (written < stub_exe_end - stub_exe_start) {
> +               ssize_t res = write(stub_exe_fd, stub_exe_start + written,
> +                                   stub_exe_end - stub_exe_start - written);
> +               if (res < 0) {
> +                       if (errno == EINTR)
> +                               continue;
> +
> +                       if (tmpfile)
> +                               unlink(tmpfile);
> +                       panic("Failed write stub binary: %d", -errno);
> +               }
> +
> +               written += res;
> +       }
> +
> +       if (!tmpfile) {
> +               fcntl(stub_exe_fd, F_ADD_SEALS,
> +                     F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_SEAL);
> +       } else {
> +               if (fchmod(stub_exe_fd, 00500) < 0) {
> +                       unlink(tmpfile);
> +                       panic("Could not make stub binary executable: %d",
> +                             -errno);
> +               }
> +
> +               close(stub_exe_fd);
> +               stub_exe_fd = open(tmpfile, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
> +               if (stub_exe_fd < 0) {
> +                       unlink(tmpfile);
> +                       panic("Could not reopen stub binary: %d", -errno);
> +               }
> +
> +               unlink(tmpfile);
> +               free(tmpfile);
>         }
>
> -       kill(os_getpid(), SIGSTOP);
>         return 0;
>  }
> +__initcall(init_stub_exe_fd);
>
>  int userspace_pid[NR_CPUS];
>
> @@ -270,7 +339,7 @@ int start_userspace(unsigned long stub_stack)
>  {
>         void *stack;
>         unsigned long sp;
> -       int pid, status, n, flags, err;
> +       int pid, status, n, err;
>
>         /* setup a temporary stack page */
>         stack = mmap(NULL, UM_KERN_PAGE_SIZE,
> @@ -286,10 +355,10 @@ int start_userspace(unsigned long stub_stack)
>         /* set stack pointer to the end of the stack page, so it can grow downwards */
>         sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
>
> -       flags = CLONE_FILES | SIGCHLD;
> -
>         /* clone into new userspace process */
> -       pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
> +       pid = clone(userspace_tramp, (void *) sp,
> +                   CLONE_VFORK | CLONE_VM | SIGCHLD,
> +                   (void *)stub_stack);
>         if (pid < 0) {
>                 err = -errno;
>                 printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
> --
> 2.46.0
>
>

--000000000000a1b5d40624a6fcbf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgoCoA05egQn0d6XHsulczy4pnJXxz
vICMIcUmB1mV3jkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDE3MDcxODAxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJqp7vZQq0nNxigaDeQ0fR/+c3p9L+MHqDnmaxwa8J0KHd9r
5O2wiUUOiyw6ufIhxilzTmjfhLkXzLNw3QAkUoK4jmUsyfR3T/yJ2QzvA8dUZ+b2WMRzyZhZbyF1
ZHJfCtK/T6tAMy6HOxFDpbMQEwgTfaWgcWlNJnoqAT4n3PTOLV/vXtCZCGZBoKhG3LgwtIpxCgeW
0VB73nxiAO0QO+l+Z/AKpskz5p4/KXLe3vTrKLVxS42/Js8CLsnss+rWsfz2sq9tBJiWov16h5vr
sl4pZuBiGwVBHqR2E+KWt1vn+E29S1/cDfeBK2/Q4u2vvD3xT7F7dvSWb/8LUIHG4/I=
--000000000000a1b5d40624a6fcbf--

