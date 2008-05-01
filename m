Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrbZX-0003Es-5U for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 09:23:52 -0700
Received: from an-out-0708.google.com ([209.85.132.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrbUR-0003rz-NV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 09:18:36 -0700
Received: by an-out-0708.google.com with SMTP id b21so215608ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 01 May 2008 09:18:35 -0700 (PDT)
Message-ID: <804dabb00805010918q68741b64s5c7fd7b6bc006d17@mail.gmail.com>
Date: Fri, 2 May 2008 00:18:34 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <804dabb00805010913q547d115fpfd51f47c1c92f5e4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
	<804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
	<20080501151551.GB6303@c2.user-mode-linux.org>
	<804dabb00805010913q547d115fpfd51f47c1c92f5e4@mail.gmail.com>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

In case if anyone is wondering what this line 107 means in the arch/um/Makefile:

    104 ifneq ($(KBUILD_SRC),)
    105 $(shell mkdir -p $(ARCH_DIR) && ln -fsn
$(srctree)/$(ARCH_DIR)/Kconfig.$(SUBARCH) $(ARCH_DIR)/Kconfig.arch)
    106 else
    107 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
    108 endif

Different version of Linux kernel tried, will always end up at the
same line above, btw, although the line number can be different.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
