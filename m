Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] um: Add seccomp support
References: <1451421347-9468-1-git-send-email-mic@digikod.net>
 <CAGXu5jLsEzacZ23Gw2moTdomvDc4ZRHieu_Yi=qpf1NHb2EXzA@mail.gmail.com>
 <CAHse=S9vWXtf13ueAcOdFTCerQHspNp_Lpx3Bf+Mu1yKaqPh7g@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <568D2244.9080306@nod.at>
Date: Wed, 6 Jan 2016 15:18:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAHse=S9vWXtf13ueAcOdFTCerQHspNp_Lpx3Bf+Mu1yKaqPh7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: David Drysdale <drysdale@google.com>, Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net, Meredydd Luff <meredydd@senatehouse.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 06.01.2016 um 15:15 schrieb David Drysdale:
> On Mon, Jan 4, 2016 at 8:13 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Dec 29, 2015 at 12:35 PM, Mickaël Salaün <mic@digikod.net> wrote:
>>> This series add seccomp support to User-mode Linux (i386 and x86_64
>>> subarchitectures) and fix ptrace issues. This apply on v4.4-rc7 and pass all
>>> the 48 tests from selftest/seccomp plus the UML ptsc test.
>>>
>>> Changes since v2:
>>> * remove get_syscall() from os.h and don't include it in syscall.c [1/4]
>>> * rebase to v4.4-rc7
>>>
>>> Changes since v1; addressed Richard Weinberger's comments:
>>> * fix a new PTRACE_SETREGS bug on x86_64 [1/4]
>>> * fix an old PTRACE_SETREGS bug when updating orig_ax on i386 [1/4]
>>
>> Thanks for working on this!
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> Feel free to pull this through the uml tree.
>>
>> Thanks!
>>
>> -Kees
> 
> I also had a version of Meredydd Luff's original patch in my local tree so I
> could do UML testing of Capsicum (which uses seccomp for some of its
> userspace implementation).  I've replaced my patch with this version, as
> it's much more complete, and all my tests still work.  Which I guess is
> kind of:
> 
> Tested-by: David Drysdale <drysdale@google.com>

Thank you guys!
I'm queuing this for 4.5.

Thanks,
//richard
