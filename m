Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FWI0I-0006ZI-U6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 12:06:18 -0700
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]
	helo=aa005msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FWI0G-0002lq-Af
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 12:06:18 -0700
From: Mattia Dongili <malattia@linux.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
Message-ID: <20060419190708.GB21337@inferi.kami.home>
References: <20060402173445.GB5108@inferi.kami.home>
	<20060407165205.GE23715@inferi.kami.home>
	<20060409125221.GB7503@SteX>
	<200604191152.10992.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604191152.10992.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 21:07:08 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>

On Wed, Apr 19, 2006 at 11:52:10AM +0200, Blaisorblade wrote:
[...]
> Debian did it the hard way IIRC (don't remember if only for the default 
> location of uml_switch socket or also for this), and problems resulted for 

currently we ship unmodified uml_socket and modified uml_net paths :)
oh, and modified tunctl path too (installs in /usr/sbin/).
Anyway I'm preparing an email summarizing Debian's current
modifications, I've seen your call for help on the website and I hope I
can help someway.

> people with self-compiled kernels.

exactely, and this is the main reason why it would really be great to
see the add-/usr/lib/uml-to-path in mainline kernels.

Thanks
-- 
mattia
:wq!


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
