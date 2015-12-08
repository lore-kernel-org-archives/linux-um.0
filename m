Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1a6Psy-0002JK-US
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:33:24 +0000
Received: from mail-oi0-f41.google.com ([209.85.218.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a6Psy-0006th-4e
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:33:24 +0000
Received: by oige206 with SMTP id e206so16600218oig.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Dec 2015 13:33:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447855929-92862-1-git-send-email-lorenzo@google.com>
References: <1447855929-92862-1-git-send-email-lorenzo@google.com>
Date: Tue, 8 Dec 2015 22:33:18 +0100
Message-ID: <CAFLxGvzONuGBZYd=BiEwvU5J_Z9UGCURvXB=8kND3aVOHh9rYA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] arch: um: fix error when linking vmlinux.
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Nov 18, 2015 at 3:12 PM, Lorenzo Colitti <lorenzo@google.com> wrote:
> On gcc Ubuntu 4.8.4-2ubuntu1~14.04, linking vmlinux fails with:
>
> arch/um/os-Linux/built-in.o: In function `os_timer_create':
> /android/kernel/android/arch/um/os-Linux/time.c:51: undefined reference to `timer_create'
> arch/um/os-Linux/built-in.o: In function `os_timer_set_interval':
> /android/kernel/android/arch/um/os-Linux/time.c:84: undefined reference to `timer_settime'
> arch/um/os-Linux/built-in.o: In function `os_timer_remain':
> /android/kernel/android/arch/um/os-Linux/time.c:109: undefined reference to `timer_gettime'
> arch/um/os-Linux/built-in.o: In function `os_timer_one_shot':
> /android/kernel/android/arch/um/os-Linux/time.c:132: undefined reference to `timer_settime'
> arch/um/os-Linux/built-in.o: In function `os_timer_disable':
> /android/kernel/android/arch/um/os-Linux/time.c:145: undefined reference to `timer_settime'
>
> This is because -lrt appears in the generated link commandline
> after arch/um/os-Linux/built-in.o. Fix this by removing -lrt from
> arch/um/Makefile and adding it to the UM-specific section of
> scripts/link-vmlinux.sh.
>
> Signed-off-by: Lorenzo Colitti <lorenzo@google.com>
> ---
>  arch/um/Makefile        | 2 +-
>  scripts/link-vmlinux.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 25ed409..e3abe6f 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -131,7 +131,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
>  # The wrappers will select whether using "malloc" or the kernel allocator.
>  LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
>
> -LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt)) -lrt
> +LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
>
>  # Used by link-vmlinux.sh which has special support for um link
>  export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 1a10d8a..dacf71a 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -62,7 +62,7 @@ vmlinux_link()
>                         -Wl,--start-group                                    \
>                                  ${KBUILD_VMLINUX_MAIN}                      \
>                         -Wl,--end-group                                      \
> -                       -lutil ${1}
> +                       -lutil -lrt ${1}
>                 rm -f linux
>         fi
>  }
> --

Applied! :)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

