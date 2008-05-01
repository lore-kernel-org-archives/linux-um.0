Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JraVw-0001Cz-PZ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 08:16:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JraVu-0001q4-Rf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 08:16:04 -0700
Date: Thu, 1 May 2008 11:15:51 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080501151551.GB6303@c2.user-mode-linux.org>
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
	<804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
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

On Thu, May 01, 2008 at 07:35:32AM +0800, Peter Teoh wrote:
> /mnt/hd0/download/linux-2.6-latest>make -v
> GNU Make 3.81
> Copyright (C) 2006  Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.
> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> PARTICULAR PURPOSE.
> 
> This program built for i686-redhat-linux-gnu
> /mnt/hd0/download/linux-2.6-latest>which make
> /usr/bin/make
> 
> Any ideas?   

No.  Something must be odd on your end.  Can you script a session
where you download the source and make this happen, then post it?  I'd
like to see a completely from-scratch session.

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
