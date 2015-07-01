Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <559424CE.9070500@infradead.org>
Date: Wed, 01 Jul 2015 10:35:10 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
References: <1435525233-14656-1-git-send-email-richard@nod.at>
In-Reply-To: <1435525233-14656-1-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Fix out-of-tree build
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/28/15 14:00, Richard Weinberger wrote:
> Commit 30b11ee9a (um: Remove copy&paste code from init.h)
> uncovered an issue wrt. out-of-tree builds.
> For out-of-tree builds, we must not rely on relative paths.
> Before 30b11ee9a it worked by chance as no host code included
> generated header files.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Works for me.  Please merge so that linux-next builds stop failing.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/um/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 098ab33..e3abe6f 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -70,8 +70,8 @@ KBUILD_AFLAGS += $(ARCH_INCLUDE)
>  
>  USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>  		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
> -		-D_FILE_OFFSET_BITS=64 -idirafter include \
> -		-D__KERNEL__ -D__UM_HOST__
> +		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
> +		-idirafter $(obj)/include -D__KERNEL__ -D__UM_HOST__
>  
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(ARCH_DIR)/Makefile-os-$(OS)
> 


-- 
~Randy
