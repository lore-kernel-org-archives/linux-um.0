Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrxXS-0000tk-Kj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 08:51:10 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JrxXR-0008I7-5d
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 08:51:10 -0700
Date: Fri, 2 May 2008 11:50:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080502155058.GA7843@c2.user-mode-linux.org>
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
	<804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
	<20080501151551.GB6303@c2.user-mode-linux.org>
	<804dabb00805010913q547d115fpfd51f47c1c92f5e4@mail.gmail.com>
	<804dabb00805010918q68741b64s5c7fd7b6bc006d17@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00805010918q68741b64s5c7fd7b6bc006d17@mail.gmail.com>
Subject: Re: [uml-devel] arch/um/Makefile:100: *** missing separator. Stop.
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
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, May 02, 2008 at 12:18:34AM +0800, Peter Teoh wrote:
> In case if anyone is wondering what this line 107 means in the arch/um/Makefile:
> 
>     104 ifneq ($(KBUILD_SRC),)
>     105 $(shell mkdir -p $(ARCH_DIR) && ln -fsn
> $(srctree)/$(ARCH_DIR)/Kconfig.$(SUBARCH) $(ARCH_DIR)/Kconfig.arch)
>     106 else
>     107 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
>     108 endif
> 
> Different version of Linux kernel tried, will always end up at the
> same line above, btw, although the line number can be different.

Color me clueless as to what's going on.  However, since the offending
line is conditional on !KBUILD_SRC, you can try
     mkdir obj ; make ARCH=um O=obj
and see if the behavior changes.  Maybe it'll produce a different and
more informative error.

I suspect you'll get exactly the same error because make is failing to
parse the Makefile and hasn't got around to actually interpretting
it.  If so, then just delete that line and see what happens.

     	    	 Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
