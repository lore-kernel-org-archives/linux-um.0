Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrLpm-0000Ki-EE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Apr 2008 16:35:34 -0700
Received: from an-out-0708.google.com ([209.85.132.242])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrLpl-0006ds-09
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Apr 2008 16:35:34 -0700
Received: by an-out-0708.google.com with SMTP id b21so149694ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 30 Apr 2008 16:35:32 -0700 (PDT)
Message-ID: <804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
Date: Thu, 1 May 2008 07:35:32 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080430184746.GA12021@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
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

On Thu, May 1, 2008 at 2:47 AM, Jeff Dike <jdike@addtoit.com> wrote:
> On Thu, May 01, 2008 at 12:24:21AM +0800, Peter Teoh wrote:
>  > Mine is same:
>  >
>  > md5sum arch/um/Makefile
>  > 9088cdab1c0b725568e8f269636dc6df  arch/um/Makefile
>
>  What make are you using?
>

Thank you Jeff,

/mnt/hd0/download/linux-2.6-latest>make -v
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for i686-redhat-linux-gnu
/mnt/hd0/download/linux-2.6-latest>which make
/usr/bin/make

Any ideas?   As far as i can remember I don't think I have install any
"make".   And btw, I have three machine - FC5, FC6, FC7 and all have
the same symptom.   Steps taken are make mrproper, then make oldconfig
ARCH=um (or defconfig tried).   All three machines are running 2.6.25
(different rc version).

Please help ????

Thanks.


-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
