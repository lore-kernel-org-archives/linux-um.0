Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FcE0d-0004AA-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 21:03:11 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FcE0d-0003jb-R3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 21:03:11 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FcE0Y-000611-Ty
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 May 2006 21:03:09 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Problem on generation a locales on uml image
Message-ID: <20060506030333.GA6830@ccure.user-mode-linux.org>
References: <20060505124937.GA4327@SteX> <20060505141208.GA4940@SteX>
	<20060505145248.GE23227@inferi.kami.home>
	<200605052247.29478.blaisorblade@yahoo.it>
	<20060505223816.GB6864@SteX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505223816.GB6864@SteX>
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
Date: Fri, 5 May 2006 23:03:33 -0400
To: Stefano Melchior <stefano.melchior@openlabs.it>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Mattia Dongili <malattia@linux.it>

On Sat, May 06, 2006 at 12:38:16AM +0200, Stefano Melchior wrote:
> I may understand that my public server (where I also use to play with uml
> too, from remote, i.e. free time at the office) is a PIII500 with only
> 128MB of RAM and an old 12GB hdd: this lack of performances and the
> temporary high cpu load (postfix+spamassassin+apache2+mysql) can be the 
> reason of this problems.

It doesn't seem to have much to do with the capabilities of the host.  I 
can make it happen on an unloaded, fairly capable host.

> May it be reasonable to increase this schedule timeout? I mean moving the
> limit to 15-20sec?

Or you can just disable it.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
