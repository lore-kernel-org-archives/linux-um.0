Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0Yga-0005lO-Ah for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 21:22:16 -0800
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D0YgX-0000WX-UR for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 21:22:16 -0800
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
	<20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
	<opsl5gb1holfdzum@localhost.localdomain>
	<200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
	<20050214011317.GG8859@parcelfarce.linux.theplanet.co.uk>
Message-ID: <opsl59iieelfdzum@localhost.localdomain>
From: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050214011317.GG8859@parcelfarce.linux.theplanet.co.uk>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 14 Feb 2005 06:28:56 +0100
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net


>
> ACK.  AFAICS, other parts of patch are already covered, except for adding
> arch/um/include/sysdep to search path.  Why do we need that?  Files in
> there get included as <sysdep/blah.h>, not <blah.h>, so...
>
>

I didn't add arch/um/include/sysdep to search path. I agree that it  
useless.
The only difference in include pass betwenn Al's patch and the mine (Dima)  
is the fpllowing:

Al>  ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
Al> +ifneq ($(KBUILD_SRC),)
Al> +ARCH_INCLUDE	+= -I$(ARCH_DIR)/include2
Al> +ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include
Al> +MRPROPER_DIRS	+= $(ARCH_DIR)/include2
Al> +endif

Dima>    include $(MAKEFILES-INCL)
Dima>  endif

Dima> -ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
Dima> +ARCH_INCLUDE	:= -I$(ARCH_DIR)/include \
Dima> +                   $(if $(KBUILD_SRC),  
-I$(objtree)/$(ARCH_DIR)/include2)
Dima> +
Dima>  SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)

Actually:
- It's preferable to give an absolute path to include2: it exist only in  
the build tree.
Adding it as a relative path you ask Kbuild to add an absolute path to  
srctree as well.
- we don't need an explicit path to -I$(srctree)/$(ARCH_DIR)/include:  
Kbuild will
do it for us from '-I$(ARCH_DIR)/include'.
You certainly added it because of USER_OBJS. To deal with this issue I  
added
-I$(srctree)/$(ARCH_DIR)/include specifically to USER_CFLAGS:

Dima>  USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
Dima> -USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS))  
$(ARCH_INCLUDE) \
Dima> -	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
Dima> +USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS))
Dima> +# If building the kernel in a separate tree we need to add this  
path manually.
Dima> +# Note, that for CFLAGS it's done in the generic  
'scripts/Makefile.lib'
Dima> +USER_CFLAGS += $(if $(KBUILD_SRC), -I$(srctree)/$(ARCH_DIR)/include)
Dima> +USER_CFLAGS += $(ARCH_INCLUDE) $(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
Dima> +

Dima


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
