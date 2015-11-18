Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zywj6-0003PP-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 07:00:20 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zywj4-0000Sn-P7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 07:00:20 +0000
Message-ID: <564C21FA.1010808@kot-begemot.co.uk>
Date: Wed, 18 Nov 2015 07:00:10 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
	<563D2217.1070002@nod.at>
	<CAKD1Yr29+9ZiG+ovhmpQE_Rm7Cp7u0sDDsN7fF6Co+y40cF3Gw@mail.gmail.com>
In-Reply-To: <CAKD1Yr29+9ZiG+ovhmpQE_Rm7Cp7u0sDDsN7fF6Co+y40cF3Gw@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v4] um: Switch clocksource to hrtimers
To: Lorenzo Colitti <lorenzo@google.com>, Richard Weinberger <richard@nod.at>
Cc: Thomas Meyer <thomas@m3y3r.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>



On 18/11/15 01:20, Lorenzo Colitti wrote:
> On Sat, Nov 7, 2015 at 6:56 AM, Richard Weinberger <richard@nod.at> wrote:
>> Am 02.11.2015 um 17:16 schrieb Anton Ivanov:
>>> Background: UML is using an obsolete itimer call for
>>> all timers and "polls" for kernel space timer firing
>>> in its userspace portion resulting in a long list
>>> of bugs and incorrect behaviour(s). It also uses
>>> ITIMER_VIRTUAL for its timer which results in the
>>> timer being dependent on it running and the cpu
>>> load.
>>>
>>> This patch fixes this by moving to posix high resolution
>>> timers firing off CLOCK_MONOTONIC and relaying the timer
>>> correctly to the UML userspace.
>>>
>>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
>>> Signed-off-by: Anton Ivanov <aivanov@brocade.com>
>> Applied!
> Looks like this broke ARCH=um SUBARCH=x86-64 builds on (at least)
> David Miller's net-next tree. On ubuntu 14.04, gcc (Ubuntu
> 4.8.4-2ubuntu1~14.04) 4.8.4, I get:
>
> arch/um/os-Linux/built-in.o: In function `os_timer_create':
> /android/kernel/android/arch/um/os-Linux/time.c:51: undefined
> reference to `timer_create'
> arch/um/os-Linux/built-in.o: In function `os_timer_set_interval':
> /android/kernel/android/arch/um/os-Linux/time.c:84: undefined
> reference to `timer_settime'
> arch/um/os-Linux/built-in.o: In function `os_timer_remain':
> /android/kernel/android/arch/um/os-Linux/time.c:109: undefined
> reference to `timer_gettime'
> arch/um/os-Linux/built-in.o: In function `os_timer_one_shot':
> /android/kernel/android/arch/um/os-Linux/time.c:132: undefined
> reference to `timer_settime'
> arch/um/os-Linux/built-in.o: In function `os_timer_disable':
> /android/kernel/android/arch/um/os-Linux/time.c:145: undefined
> reference to `timer_settime'
> collect2: error: ld returned 1 exit status
>
> The command being run is this:
>
> + gcc -Wl,-rpath,/lib64 -m64 -Wl,-rpath,/lib -Wl,--wrap,malloc
> -Wl,--wrap,free -Wl,--wrap,calloc -Wl,-m -Wl,elf_x86_64 -lrt -o
> .tmp_vmlinux1 -Wl,-T,./arch/um/kernel/vmlinux.lds init/built-in.o
> -Wl,--start-group usr/built-in.o arch/um/kernel/built-in.o
> arch/um/drivers/built-in.o arch/um/os-Linux/built-in.o
> arch/x86/crypto/built-in.o arch/x86/um/built-in.o kernel/built-in.o
> certs/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o
> security/built-in.o crypto/built-in.o block/built-in.o lib/lib.a
> lib/built-in.o drivers/built-in.o sound/built-in.o firmware/built-in.o
> net/built-in.o virt/built-in.o -Wl,--end-group -lutil
>
> The following patch results in a working kernel, but I have no idea if
> it's correct. Thoughts?

It is.

You need -lrt to link in HR timers. However, the original patch should 
add that to the library list. I need to understand why it does not in 
the dm tree.

A.

>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 25ed409..e3abe6f 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -131,7 +131,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
>   # The wrappers will select whether using "malloc" or the kernel allocator.
>   LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
>
> -LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt)) -lrt
> +LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
>
>   # Used by link-vmlinux.sh which has special support for um link
>   export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 1a10d8a..dacf71a 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -62,7 +62,7 @@ vmlinux_link()
>                          -Wl,--start-group                                    \
>                                   ${KBUILD_VMLINUX_MAIN}                      \
>                          -Wl,--end-group                                      \
> -                       -lutil ${1}
> +                       -lutil -lrt ${1}
>                  rm -f linux
>          fi
>   }


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

