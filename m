Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H74j9-0002wn-1y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jan 2007 22:56:55 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H74j7-0000mu-EH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jan 2007 22:56:55 -0800
Date: Wed, 17 Jan 2007 01:50:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070117065043.GB11894@ccure.user-mode-linux.org>
References: <20070112203431.GA10573@swingline.cs.wisc.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070112203431.GA10573@swingline.cs.wisc.edu>
Subject: Re: [uml-devel] UML and KVM
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Erik Paulson <epaulson@cs.wisc.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 12, 2007 at 02:34:31PM -0600, Erik Paulson wrote:
> I see that you're going to be giving a talk at linux.conf.au in a
> few days on integrating UML and KVM:
> 
> http://virtminiconf.linux.hp.com/program/uml-kvm-and-hardware-virtualization
> 
> This sounds pretty cool - is there a paper to go along with it, or 
> will the slides (or, even better, a video of the talk) be available for 
> those of us who can't make it to Oz?

I'll make the slides, with notes available - that will approximate the
talk if you stand in the front of a room and read them out loud with
the slides on a screen behind you.

> Your abstract mentions KVM needs to support paravirtualzation first - do
> Ingo's patches provide what you need:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=31355873&forum_id=50582

No, that seems to be just memory management stuff.  What I need is
much simpler - VMCALL needs to be acceptable as a VMEXIT reason and
returned from the KVM_RUN ioctl.  That's not present in the version of
KVM that I have here (which I pulled a couple of weeks ago).

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
