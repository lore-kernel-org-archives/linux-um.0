Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLBdhuG1G0xLJk5=XrdT4Vd6ac88_Pz3QKksn5SVPFAxQ@mail.gmail.com>
References: <1468274222-31726-1-git-send-email-mic@digikod.net> <CAGXu5jLBdhuG1G0xLJk5=XrdT4Vd6ac88_Pz3QKksn5SVPFAxQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 28 Jul 2016 11:29:45 -0700
Message-ID: <CAGXu5j+CODSZa9bZGda2ovwB62y9TkQD8Wqh9KvMrE=SoJxZjg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix seccomp for UM (next)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, James Morris <jmorris@namei.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jul 11, 2016 at 6:59 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 11, 2016 at 5:56 PM, Mickaël Salaün <mic@digikod.net> wrote:
>> Hi,
>>
>> This series fix the recent seccomp update for the User-mode Linux architecture
>> (32-bit and 64-bit) since commit 26703c636c1f3272b39bd0f6d04d2e970984f1b6
>> (close the hole where ptrace can change a syscall out from under seccomp).
>>
>> Regards,
>>
>> Mickaël Salaün (3):
>>   um/ptrace: Fix the syscall_trace_leave call
>>   um/ptrace: Fix the syscall number update after a ptrace
>>   seccomp: Remove 2-phase API documentation
>>
>>  arch/Kconfig                  | 11 -----------
>>  arch/um/kernel/skas/syscall.c | 10 +++-------
>>  arch/x86/um/ptrace_32.c       |  3 +++
>>  arch/x86/um/ptrace_64.c       |  4 ++++
>>  4 files changed, 10 insertions(+), 18 deletions(-)
>
> Ah, perfect! Thanks for fixing this! James, can you pick this up for -next?
>
> Acked-by: Kees Cook <keescook@chromium.org>

James, can you take these fixes for v4.8? We'll need them for um to
work correctly again. (They appear to still be missing from -next.)

Thanks!

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

