Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uZqu-0003of-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 08:47:24 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uZqu-0000wt-GO
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 08:47:24 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19uZqt-00032R-00
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 11:47:23 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19uZqt-0002co-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 11:47:23 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030903154723.GM7304@alcor.net>
References: <30858.1062520135@marajade.sandelman.ottawa.on.ca> <1062581538.15476.4.camel@henrik.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062581538.15476.4.camel@henrik.marasystems.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 3 Sep 2003 11:47:23 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 03, 2003 at 11:32:18AM +0200, Henrik Nordstrom wrote:

> Right.. hostfs will almost certainly not work well with file mode 0
> until the virtual permissions layer is implemented.
> 
> Today hostfs directly maps permissions to the host files, which breaks
> root semantics for UML. Normally root expects that mode does not matter
> when reading/writing files, but when using hostfs it does matter when
> UML accesses the host.

If your UML is dynamically linked, you can run it inside fakeroot to get
these semantics.

It would be very handy to have this implemented in UML itself, though.  I
work around it in various annoying ways at the moment.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
