Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JMyaj-0001hT-48 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 20:42:31 -0800
Received: from verein.lst.de ([213.95.11.210])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1JMyah-0005Oe-Jw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2008 20:42:29 -0800
Date: Thu, 7 Feb 2008 05:42:20 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20080207044220.GA3970@lst.de>
References: <20080207035309.GA1345@lst.de>
	<20080207044059.GA13768@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080207044059.GA13768@c2.user-mode-linux.org>
Subject: Re: [uml-devel] uml defconfig needs an update
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
Cc: Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Feb 06, 2008 at 11:40:59PM -0500, Jeff Dike wrote:
> On Thu, Feb 07, 2008 at 04:53:09AM +0100, Christoph Hellwig wrote:
> > arch/um/defconfig in current mainline is totally out of date, any chance
> > someone could send an update to Linus?
> 
> Be more specific?
> 
> I just sent some defconfig changes in, but they're nothing that would
> fix any outdatedness.

Well, an defconfig should give you a config that covers all symbols,
but when I ran it this morning it was asking a few dozend questions.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
