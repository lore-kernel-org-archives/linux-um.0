Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1XtW-0004t2-EM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 13:39:10 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B1XBp-0008Bh-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 12:54:01 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] missed_ticks (2.6)
Message-ID: <20040311215312.GA3873@ccure.user-mode-linux.org>
References: <20040229191932.10b3592e.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229191932.10b3592e.zaitcev@redhat.com>
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
Date: Thu, 11 Mar 2004 16:53:12 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 29, 2004 at 07:19:32PM -0800, Pete Zaitcev wrote:
> I was looking at the way timer works on UML and noticed that missed_ticks
> is not actually used for anything. Is there a plan for it? If not, maybe
> we should drop it.

Applied, thanks.

		Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
