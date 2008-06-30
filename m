Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDMNj-0002b5-QO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 09:37:35 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDMNh-0008TJ-G5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 09:37:34 -0700
Received: by wx-out-0506.google.com with SMTP id h29so579260wxd.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 30 Jun 2008 09:37:32 -0700 (PDT)
Message-ID: <48690BC7.5060809@panasas.com>
Date: Mon, 30 Jun 2008 19:37:27 +0300
From: Benny Halevy <bhalevy@panasas.com>
MIME-Version: 1.0
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<20080627162645.GC8381@c2.user-mode-linux.org>
	<7225594ED4A1304C9E43D030A886D221050BE1@daytona.int.panasas.com>
	<48673A9B.8050907@panasas.com>
	<20080630162201.GC6643@c2.user-mode-linux.org>
In-Reply-To: <20080630162201.GC6643@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Jun. 30, 2008, 19:22 +0300, Jeff Dike <jdike@addtoit.com> wrote:
> On Sun, Jun 29, 2008 at 10:32:43AM +0300, Benny Halevy wrote:
>> Note that the crash happened with gcc 4.1.2 and it will get the
>> -fno-unit-at-a-time flag with the proposed patch.
>>
>> That said, this option or the lack of it ought not to cause any
>> runtime crashes.  If it does, I'd feel much more comfortable to know
>> exactly what the root cause is before deciding to use the flag to
>> workaround^hide it.
> 
> I agree.
> 
> The constraints on [no-]unit-at-a-time that I see are:
> 	i386 uses no-unit-at-a-time for pre-4.0 (not 4.3)
> 	x86_64 uses unit-at-a-time always
> 
> 	Uli reported a crash on x86_64 with gcc 4.1.2 with unit-at-a-time
> 	Ingo reported a gcc internal error with gcc 4.3 with
> no-unit-at-a-time 
> 	You are seeing extern inlines not resolved with gcc 4.3 with
> no-unit-at-a-time 
> 
> I'm tempted to follow x86 on this, with the results that
> 	extern inlines should be fine
> 	Ingo's gcc crash should not reappear
> 	Uli's crash may reappear
> 
> If that crash does come back, I'd say we should just debug it.  It's
> likely UML implicitly relying on some gcc behavior anyway.

Agreed.

> 
> This is the patch that I'm dropping into my tree:
> 
> Index: linux-2.6.22/arch/um/Makefile-i386
> ===================================================================
> --- linux-2.6.22.orig/arch/um/Makefile-i386	2008-05-29 11:21:25.000000000 -0400
> +++ linux-2.6.22/arch/um/Makefile-i386	2008-06-30 12:20:01.000000000 -0400
> @@ -32,4 +32,10 @@ cflags-y += $(call cc-option,-mpreferred
>  # an unresolved reference.
>  cflags-y += -ffreestanding
>  
> +# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> +# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> +# 4.3.0 needs -funit-at-a-time for extern inline functions.
> +KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0403 ] ; then \

This isn't exactly aligned with the comment above.
Should be -lt 0400, as in 22eecde2f9034764a3fd095eecfa3adfb8ec9a98?

> +			echo $(call cc-option,-fno-unit-at-a-time); fi ;)
> +
>  KBUILD_CFLAGS += $(cflags-y)
> Index: linux-2.6.22/arch/um/Makefile-x86_64
> ===================================================================
> --- linux-2.6.22.orig/arch/um/Makefile-x86_64	2008-05-29 11:21:25.000000000 -0400
> +++ linux-2.6.22/arch/um/Makefile-x86_64	2008-06-30 12:21:01.000000000 -0400
> @@ -21,3 +21,6 @@ HEADER_ARCH := x86
>  
>  LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
>  LINK-y += -m64
> +
> +# Do unit-at-a-time unconditionally on x86_64, following the host
> +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)

Hmm, arch/um/Makefile includes $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
before add -fno-unit-at-a-time to KBUILD_CFLAGS.
Will this override the flag set first here?

Benny

> 
> 				Jeff
> 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
