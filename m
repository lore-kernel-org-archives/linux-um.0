Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnNY6-0005aR-D6
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 11:46:30 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AnNXm-00073Q-Fb
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 01 Feb 2004 11:46:30 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id i11KANnO020425
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 1 Feb 2004 15:10:23 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Patch for UML running on exec-shield hosts
Message-ID: <20040201200912.GA20413@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0402011247190.14738@vega.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402011247190.14738@vega.dur.ac.uk>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 1 Feb 2004 15:09:12 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 01, 2004 at 12:54:41PM +0000, M A Young wrote:
> Here is a revised version of my patch to address the UML crash when you
> try to run it on a host kernel with exec-shield enabled, such as on fedora
> core 1. 

Applied, thanks.

> The change is that it increases the value of the physmem_size for
> exec-shield users, so they actually get the memory they asked for (and
> adds zero in the non-exec shield case).

I'm not so sure about this part.  I need to think about it.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
