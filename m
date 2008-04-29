Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqruD-0001OB-IC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 08:38:09 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jqru6-0005AJ-Ex
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 08:38:08 -0700
Date: Tue, 29 Apr 2008 11:37:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080429153746.GB9143@c2.user-mode-linux.org>
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
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

On Tue, Apr 29, 2008 at 08:02:06PM +0800, Peter Teoh wrote:
> Erh....I don't understand, is there something specifically called
> "UML" with a version to it?

What I meant was the kernel version.

> /mnt/hd0/download/linux-2.6-latest>cat include/config/kernel.release
> 2.6.25
> 
> Is this the correct procedure?   I suspect something is wrong, as i
> did a few times in all other different git tree all similar results.

Looks right to me.

I'm suspecting that Makefile is mangled somehow.  Does git-diff show
it as being changed?  The md5sum I have here is

   md5sum arch/um/Makefile
   9088cdab1c0b725568e8f269636dc6df  arch/um/Makefile

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
