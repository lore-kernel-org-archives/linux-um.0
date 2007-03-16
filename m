Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HSLRF-0008IM-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Mar 2007 16:02:22 -0700
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HSLRE-00087j-9s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Mar 2007 16:02:21 -0700
Date: Fri, 16 Mar 2007 16:00:31 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20070316230031.GA13798@kroah.com>
References: <20070316161015.GA7948@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070316161015.GA7948@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [stable] [PATCH] UML - arch_prctl should set thread fs
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
To: Jeff Dike <jdike@addtoit.com>
Cc: stable@kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

On Fri, Mar 16, 2007 at 12:10:15PM -0400, Jeff Dike wrote:
> [ This missed getting into -stable the first time I sent it ]

That's because it doesn't apply at all to the current 2.6.20.3 kernel
tree.  Can you rediff it for that one so that we can apply it properly?

thanks,

greg k-h

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
