Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlidN-0003bt-AT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 21:53:05 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AlidM-0003Gn-0O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 21:53:04 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Re: more on COW (long)
Message-ID: <20040128055515.GU4203@erizo.shearer.org>
References: <20040119.155346.-522689.0.mcmechanjw@juno.com>
	<200401280518.i0S5IOZw005580@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200401280518.i0S5IOZw005580@ccure.user-mode-linux.org>
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
Date: Wed, 28 Jan 2004 16:25:15 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: James W McMechan <mcmechanjw@juno.com>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 28, 2004 at 12:18:24AM -0500, Jeff Dike wrote:
> mcmechanjw@juno.com said:

> > Well yes, I want to be able to read real disk images either from a raw
> > device, yes we could stick in a special case ioctl to check for a real
> > device and read its geometry but ick it is easier to specify it, or
> > from a dd'ed image file of a hard disk which would not work even with
> > the ioctl, so ubd1C102H15S16 is better from my view :)
> 
> OK, build it and maybe people will come :-)

Yep. I work with many different simulation environments and this is a
*really* useful option. Apart from anything else real sectors are a kind
of semi-universal file format between simulation environments. But there
is also the case where you dd from a running system for purposes such as
planning preventative maintenance, disaster recovery, forensics,
security testing to mention a few. Not too many of the open source
simulators do this but many of the closed source ones do.

--
Dan Shearer
dan@shearer.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
