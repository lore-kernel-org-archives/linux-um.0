Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Js1JB-0003Eh-AK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 12:52:41 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Js1J9-0006L3-R5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 12:52:41 -0700
Date: Fri, 2 May 2008 15:52:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080502195230.GA10369@c2.user-mode-linux.org>
References: <804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
	<804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
	<20080501151551.GB6303@c2.user-mode-linux.org>
	<804dabb00805010913q547d115fpfd51f47c1c92f5e4@mail.gmail.com>
	<804dabb00805010918q68741b64s5c7fd7b6bc006d17@mail.gmail.com>
	<20080502155058.GA7843@c2.user-mode-linux.org>
	<804dabb00805021049q773ddee8i1f2a21a05368b74e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00805021049q773ddee8i1f2a21a05368b74e@mail.gmail.com>
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

On Sat, May 03, 2008 at 01:49:40AM +0800, Peter Teoh wrote:
> This is what I have done, not sure if anything wrong:
> 
> a.   mkdir obj;make oldconfig ARCH=um O=obj
> 
> This created one file in obj, but after that created infinite number
> of make -C processes running in the background.....I stopped that.
> 
> ps -ef and the following repeated MANY MANY TIMES:
> 
> root     32742 32658  0 01:13 pts/2    00:00:00 make -C
> /mnt/hd0/download/linux-2.6-latest KBUILD_SRC= oldconfig
> root     32745 32742  0 01:13 pts/2    00:00:00 make -C
> /mnt/hd0/download/linux-2.6-latest/obj
> /mnt/hd0/download/linux-2.6-latest/obj KBUILD_SRC=/mnt/hd0/dow

The only thing that makes any sense to me is that you have a severely
broken make.

> So, not okay.
> 
> b.   mkdir obj; make ARCH=um O=obj
> 
> As per instructed.....it works except it complained no config file (in
> obj directory), and suggested to do a mrproper for the current parent
> directory.   So I copied the .config to obj directory, make mrproper
> in parent directory, and then cd to obj and make oldconfig there, and
> then "make":
> 
> cp .config obj
> make mrproper
> cd obj

Why did you do this?  You're never supposed to cd to the object
directory and run make in it.

Also, you should have ARCH=um on all make commands, including
mrproper.

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
