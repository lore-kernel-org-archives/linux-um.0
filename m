Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX0TN-0008Oc-0g for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:35:17 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FX0TN-0001ah-1x for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:35:17 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FX0TL-0004W1-Eg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:35:17 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
References: <20060402173445.GB5108@inferi.kami.home>
	<200604191152.10992.blaisorblade@yahoo.it>
	<20060419190708.GB21337@inferi.kami.home>
In-Reply-To: <20060419190708.GB21337@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212034.13240.blaisorblade@yahoo.it>
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
Date: Fri, 21 Apr 2006 20:34:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia Dongili <malattia@linux.it>, stefano.melchior@openlabs.it, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>

On Wednesday 19 April 2006 21:07, Mattia Dongili wrote:
> On Wed, Apr 19, 2006 at 11:52:10AM +0200, Blaisorblade wrote:
> [...]
>
> > Debian did it the hard way IIRC (don't remember if only for the default
> > location of uml_switch socket or also for this), and problems resulted
> > for
>
> currently we ship unmodified uml_socket and modified uml_net paths :)
> oh, and modified tunctl path too (installs in /usr/sbin/).
> Anyway I'm preparing an email summarizing Debian's current
> modifications, I've seen your call for help on the website and I hope I
> can help someway.
>
> > people with self-compiled kernels.
>
> exactely, and this is the main reason why it would really be great to
> see the add-/usr/lib/uml-to-path in mainline kernels.

Yep, that's now merged in my personal tree and will go upstream on my next 
merge.

For uml_utilities, I'll maybe add the patch (but leaving a compat symlink) for 
next release (which includes Mattia's fixlet).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
