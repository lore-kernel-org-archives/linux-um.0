Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bql6T-0000MK-9V for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 21:04:13 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Incremental patches available
Message-ID: <20040731050251.GA4909@ccure.user-mode-linux.org>
References: <200407301924.04914.alydar@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301924.04914.alydar@users.sourceforge.net>
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
Date: Sat, 31 Jul 2004 01:02:51 -0400
To: Allen Chan <alydar@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 30, 2004 at 07:24:02PM -0400, Allen Chan wrote:
> While attempting to build and test a 2.6.7 kernel including the 
> patches found on the new incremental patches page, I've bumped into 
> into problems with a couple of the patches:
> 
> (1)  remap - apparently, this patch has already been applied as part 
> of  uml-patch-2.6.7-1.bz2.

Yeah, I released 2.6.7 from after the remap patch.

> (2)  time - one of the patches included here attempts to modify 
> um/arch/um/os/Makefile.  However, that file does not exist.  It looks 
> like that file should be um/arch/um/os-Linux/Makefile.

Oops, /me will fix.  I didn't notice that because I'm playing with a built
pool which has the symlinks there.  I was trying to make sure I got these
right, but I missed that.

> Now to compile and beat up on the new test kernel...

Excellent, that's a big reason I did this.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
