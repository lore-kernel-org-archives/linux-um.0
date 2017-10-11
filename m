Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANRm+Cys9jhHr6uWkUkUbAqFPQid1AkERG2-j1qt4-VNTkqjQg@mail.gmail.com>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-10-khuey@kylehuey.com>
 <CANRm+Cys9jhHr6uWkUkUbAqFPQid1AkERG2-j1qt4-VNTkqjQg@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Tue, 10 Oct 2017 20:56:52 -0700
Message-ID: <CAP045AoC+z73gkAShdkxQyY0FV0m+eW+sLH73Rvjq7wjwX2ytA@mail.gmail.com>
Subject: Re: [PATCH v16 09/10] x86/arch_prctl: Selftest for ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Oct 10, 2017 at 8:35 PM, Wanpeng Li <kernellwp@gmail.com> wrote:
> Hi Kyle,
> 2017-03-20 16:16 GMT+08:00 Kyle Huey <me@kylehuey.com>:
>> Test disabling and reenabling the cpuid instruction via the new arch_prctl
>> ARCH_SET_CPUID, retrieving the current state via ARCH_GET_CPUID, and the
>> expected behaviors across fork() and exec().
>>
>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>> ---
>>  tools/testing/selftests/x86/Makefile      |   2 +-
>>  tools/testing/selftests/x86/cpuid_fault.c | 251 ++++++++++++++++++++++++++++++
>
> I'm not sure why this commit is not merged to upstream. I test
> 4.14-rc3 w/ this testcase on a haswell client, however I encounter the
> below splat, any idea?

Thanks for pointing out that this never got merged.  That's quite
disappointing, especially after reviewers insisted I write this test.

The failure you're seeing is because the values of ARCH_GET_CPUID and
ARCH_SET_CPUID changed and the values hardcoded in the test are no
longer accurate.  If you set them to the correct values (0x1011 and
0x1012 respectively) the test should pass.

- Kyle

> # ./cpuid_fault_64
> cpuid() == {d, 756e6547, 6c65746e, 49656e69}
> arch_prctl(ARCH_GET_CPUID); ARCH_GET_CPUID is unsupported on this kernel.
>
> Regards,
> Wanpeng Li
>
>>  2 files changed, 252 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/x86/cpuid_fault.c
>>
>> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
>> index 38e0a9ca5d71..acda4e5fcf25 100644
>> --- a/tools/testing/selftests/x86/Makefile
>> +++ b/tools/testing/selftests/x86/Makefile
>> @@ -6,7 +6,7 @@ include ../lib.mk
>>
>>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt ptrace_syscall test_mremap_vdso \
>>                         check_initial_reg_state sigreturn ldt_gdt iopl mpx-mini-test ioperm \
>> -                       protection_keys test_vdso
>> +                       protection_keys test_vdso cpuid_fault
>>  TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
>>                         test_FCMOV test_FCOMI test_FISTTP \
>>                         vdso_restorer
>> diff --git a/tools/testing/selftests/x86/cpuid_fault.c b/tools/testing/selftests/x86/cpuid_fault.c
>> new file mode 100644
>> index 000000000000..e3b93c28c655
>> --- /dev/null
>> +++ b/tools/testing/selftests/x86/cpuid_fault.c
>> @@ -0,0 +1,251 @@
>> +
>> +/*
>> + * Tests for arch_prctl(ARCH_GET_CPUID, ...) / arch_prctl(ARCH_SET_CPUID, ...)
>> + *
>> + * Basic test to test behaviour of ARCH_GET_CPUID and ARCH_SET_CPUID
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <signal.h>
>> +#include <inttypes.h>
>> +#include <cpuid.h>
>> +#include <err.h>
>> +#include <errno.h>
>> +#include <sys/wait.h>
>> +
>> +#include <sys/prctl.h>
>> +#include <linux/prctl.h>
>> +
>> +/*
>> +#define ARCH_GET_CPUID 0x1005
>> +#define ARCH_SET_CPUID 0x1006
>> +#ifdef __x86_64__
>> +#define SYS_arch_prctl 158
>> +#else
>> +#define SYS_arch_prctl 384
>> +#endif
>> +*/
>> +
>> +const char *cpuid_names[] = {
>> +       [0] = "[cpuid disabled]",
>> +       [1] = "[cpuid enabled]",
>> +};
>> +
>> +int arch_prctl(int option, unsigned long arg2)
>> +{
>> +       return syscall(SYS_arch_prctl, option, arg2);
>> +}
>> +
>> +int cpuid(unsigned int *eax, unsigned int *ebx, unsigned int *ecx,
>> +         unsigned int *edx)
>> +{
>> +       return __get_cpuid(0, eax, ebx, ecx, edx);
>> +}
>> +
>> +int do_child_exec_test(int eax, int ebx, int ecx, int edx)
>> +{
>> +       int cpuid_val = 0, child = 0, status = 0;
>> +
>> +       printf("arch_prctl(ARCH_GET_CPUID); ");
>> +
>> +       cpuid_val = arch_prctl(ARCH_GET_CPUID, 0);
>> +       if (cpuid_val < 0)
>> +               errx(1, "ARCH_GET_CPUID fails now, but not before?");
>> +
>> +       printf("cpuid_val == %s\n", cpuid_names[cpuid_val]);
>> +       if (cpuid_val != 0)
>> +               errx(1, "How did cpuid get re-enabled on fork?");
>> +
>> +       child = fork();
>> +       if (child == 0) {
>> +               cpuid_val = arch_prctl(ARCH_GET_CPUID, 0);
>> +               if (cpuid_val < 0)
>> +                       errx(1, "ARCH_GET_CPUID fails now, but not before?");
>> +
>> +               printf("cpuid_val == %s\n", cpuid_names[cpuid_val]);
>> +               if (cpuid_val != 0)
>> +                       errx(1, "How did cpuid get re-enabled on fork?");
>> +
>> +               printf("exec\n");
>> +               execl("/proc/self/exe", "cpuid-fault", "-early-return", NULL);
>> +       }
>> +
>> +       if (child != waitpid(child, &status, 0))
>> +               errx(1, "waitpid failed!?");
>> +
>> +       if (WEXITSTATUS(status) != 0)
>> +               errx(1, "Execed child exited abnormally");
>> +
>> +       return 0;
>> +}
>> +
>> +int child_received_signal;
>> +
>> +void child_sigsegv_cb(int sig)
>> +{
>> +       int cpuid_val = 0;
>> +
>> +       child_received_signal = 1;
>> +       printf("[ SIG_SEGV ]\n");
>> +       printf("arch_prctl(ARCH_GET_CPUID); ");
>> +
>> +       cpuid_val = arch_prctl(ARCH_GET_CPUID, 0);
>> +       if (cpuid_val < 0)
>> +               errx(1, "ARCH_GET_CPUID fails now, but not before?");
>> +
>> +       printf("cpuid_val == %s\n", cpuid_names[cpuid_val]);
>> +       printf("arch_prctl(ARCH_SET_CPUID, 1)\n");
>> +       if (arch_prctl(ARCH_SET_CPUID, 1) != 0)
>> +               exit(errno);
>> +
>> +       printf("cpuid() == ");
>> +}
>> +
>> +int do_child_test(void)
>> +{
>> +       unsigned int eax = 0, ebx = 0, ecx = 0, edx = 0;
>> +
>> +       signal(SIGSEGV, child_sigsegv_cb);
>> +
>> +       /* the child starts out with cpuid disabled, the signal handler
>> +        * attempts to enable and retry
>> +        */
>> +       printf("cpuid() == ");
>> +       cpuid(&eax, &ebx, &ecx, &edx);
>> +       printf("{%x, %x, %x, %x}\n", eax, ebx, ecx, edx);
>> +       return child_received_signal ? 0 : 42;
>> +}
>> +
>> +int signal_count;
>> +
>> +void sigsegv_cb(int sig)
>> +{
>> +       int cpuid_val = 0;
>> +
>> +       signal_count++;
>> +       printf("[ SIG_SEGV ]\n");
>> +       printf("arch_prctl(ARCH_GET_CPUID); ");
>> +
>> +       cpuid_val = arch_prctl(ARCH_GET_CPUID, 0);
>> +       if (cpuid_val < 0)
>> +               errx(1, "ARCH_GET_CPUID fails now, but not before?");
>> +
>> +       printf("cpuid_val == %s\n", cpuid_names[cpuid_val]);
>> +       printf("arch_prctl(ARC_SET_CPUID, 1)\n");
>> +       if (arch_prctl(ARCH_SET_CPUID, 1) != 0)
>> +               errx(1, "ARCH_SET_CPUID failed!");
>> +
>> +       printf("cpuid() == ");
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +       int cpuid_val = 0, child = 0, status = 0;
>> +       unsigned int eax = 0, ebx = 0, ecx = 0, edx = 0;
>> +
>> +       signal(SIGSEGV, sigsegv_cb);
>> +       setvbuf(stdout, NULL, _IONBF, 0);
>> +
>> +       cpuid(&eax, &ebx, &ecx, &edx);
>> +       printf("cpuid() == {%x, %x, %x, %x}\n", eax, ebx, ecx, edx);
>> +       printf("arch_prctl(ARCH_GET_CPUID); ");
>> +
>> +       cpuid_val = arch_prctl(ARCH_GET_CPUID, 0);
>> +       if (cpuid_val < 0) {
>> +               if (errno == EINVAL) {
>> +                       printf("ARCH_GET_CPUID is unsupported on this kernel.\n");
>> +                       fflush(stdout);
>> +                       exit(0); /* no ARCH_GET_CPUID on this system */
>> +               } else if (errno == ENODEV) {
>> +                       printf("ARCH_GET_CPUID is unsupported on this hardware.\n");
>> +                       fflush(stdout);
>> +                       exit(0); /* no ARCH_GET_CPUID on this system */
>> +               } else {
>> +                       errx(errno, "ARCH_GET_CPUID failed unexpectedly!");
>> +               }
>> +       }
>> +
>> +       printf("cpuid_val == %s\n", cpuid_names[cpuid_val]);
>> +       cpuid(&eax, &ebx, &ecx, &edx);
>> +       printf("cpuid() == {%x, %x, %x, %x}\n", eax, ebx, ecx, edx);
>> +       printf("arch_prctl(ARCH_SET_CPUID, 1)\n");
>> +
>> +       if (arch_prctl(ARCH_SET_CPUID, 1) != 0) {
>> +               if (errno == EINVAL) {
>> +                       printf("ARCH_SET_CPUID is unsupported on this kernel.");
>> +                       exit(0); /* no ARCH_SET_CPUID on this system */
>> +               } else if (errno == ENODEV) {
>> +                       printf("ARCH_SET_CPUID is unsupported on this hardware.");
>> +                       exit(0); /* no ARCH_SET_CPUID on this system */
>> +               } else {
>> +                       errx(errno, "ARCH_SET_CPUID failed unexpectedly!");
>> +               }
>> +       }
>> +
>> +
>> +       cpuid(&eax, &ebx, &ecx, &edx);
>> +       printf("cpuid() == {%x, %x, %x, %x}\n", eax, ebx, ecx, edx);
>> +       printf("arch_prctl(ARCH_SET_CPUID, 0)\n");
>> +       fflush(stdout);
>> +
>> +       if (arch_prctl(ARCH_SET_CPUID, 0) == -1)
>> +               errx(1, "ARCH_SET_CPUID failed!");
>> +
>> +       printf("cpuid() == ");
>> +       eax = ebx = ecx = edx = 0;
>> +       cpuid(&eax, &ebx, &ecx, &edx);
>> +       printf("{%x, %x, %x, %x}\n", eax, ebx, ecx, edx);
>> +       printf("arch_prctl(ARCH_SET_CPUID, 0)\n");
>> +
>> +       if (signal_count != 1)
>> +               errx(1, "cpuid didn't fault!");
>> +
>> +       if (arch_prctl(ARCH_SET_CPUID, 0) == -1)
>> +               errx(1, "ARCH_SET_CPUID failed!");
>> +
>> +       if (argc > 1)
>> +               exit(0); /* Don't run the whole test again if we were execed */
>> +
>> +       printf("do_child_test\n");
>> +       child = fork();
>> +       if (child == 0)
>> +               return do_child_test();
>> +
>> +       if (child != waitpid(child, &status, 0))
>> +               errx(1, "waitpid failed!?");
>> +
>> +       if (WEXITSTATUS(status) != 0)
>> +               errx(1, "Child exited abnormally!");
>> +
>> +       /* The child enabling cpuid should not have affected us */
>> +       printf("cpuid() == ");
>> +       eax = ebx = ecx = edx = 0;
>> +       cpuid(&eax, &ebx, &ecx, &edx);
>> +       printf("{%x, %x, %x, %x}\n", eax, ebx, ecx, edx);
>> +       printf("arch_prctl(ARCH_SET_CPUID, 0)\n");
>> +
>> +       if (signal_count != 2)
>> +               errx(1, "cpuid didn't fault!");
>> +
>> +       if (arch_prctl(ARCH_SET_CPUID, 0) == -1)
>> +               errx(1, "ARCH_SET_CPUID failed!");
>> +
>> +       /* Our ARCH_CPUID_SIGSEGV should not propagate through exec */
>> +       printf("do_child_exec_test\n");
>> +       fflush(stdout);
>> +
>> +       child = fork();
>> +       if (child == 0)
>> +               return do_child_exec_test(eax, ebx, ecx, edx);
>> +
>> +       if (child != waitpid(child, &status, 0))
>> +               errx(1, "waitpid failed!?");
>> +
>> +       if (WEXITSTATUS(status) != 0)
>> +               errx(1, "Child exited abnormally!");
>> +
>> +       printf("All tests passed!\n");
>> +       exit(EXIT_SUCCESS);
>> +}
>> --
>> 2.11.0
>>

