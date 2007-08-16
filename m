Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILida-0007xV-NR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:55:58 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILidZ-00032b-Aj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:55:58 -0700
Date: Thu, 16 Aug 2007 09:54:55 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20070816165455.GA17875@kroah.com>
References: <20070816162428.GA8128@c2.user-mode-linux.org>
	<1187281856.2663.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1187281856.2663.0.camel@laptopd505.fenrus.org>
Subject: Re: [uml-devel] [stable] [PATCH] UML - Add a .note.SuSE section
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, giedrius@su.lt, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, Alberto Pires de Oliveira Neto <apon1@terra.com.br>

On Thu, Aug 16, 2007 at 09:30:56AM -0700, Arjan van de Ven wrote:
> 
> On Thu, 2007-08-16 at 12:24 -0400, Jeff Dike wrote:
> > [ This is both 2.6.24 and -stable material ]
> > 
> > SuSE seems to require that binaries have a .note.SuSE section.
> > Without it, UML segfaults if any parameters are passed on the command
> > line.
> 
> 
> this sounds like something really stupid and bad... why would the kernel
> need to have a per-distro note section???

I agree, what did we mess up in the SuSE kernel to require such a hack?
:)

thanks,

greg k-h

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
