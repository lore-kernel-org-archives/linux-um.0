Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILiJb-0005P1-VV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:35:21 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILiJY-0002Ys-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:35:19 -0700
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20070816162428.GA8128@c2.user-mode-linux.org>
References: <20070816162428.GA8128@c2.user-mode-linux.org>
Date: Thu, 16 Aug 2007 09:30:56 -0700
Message-Id: <1187281856.2663.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - Add a .note.SuSE section
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
Cc: Andrew Morton <akpm@osdl.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Alberto Pires de Oliveira Neto <apon1@terra.com.br>, giedrius@su.lt, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org


On Thu, 2007-08-16 at 12:24 -0400, Jeff Dike wrote:
> [ This is both 2.6.24 and -stable material ]
> 
> SuSE seems to require that binaries have a .note.SuSE section.
> Without it, UML segfaults if any parameters are passed on the command
> line.


this sounds like something really stupid and bad... why would the kernel
need to have a per-distro note section???



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
