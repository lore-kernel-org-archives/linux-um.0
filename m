Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKNDq-0003rk-MB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 14:15:02 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FKNDn-0006PL-Lx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 14:15:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Occasional hang starting up.
References: <200603111301.42195.rob@landley.net>
	<200603172036.59218.blaisorblade@yahoo.it>
	<20060317182722.B8529@almesberger.net>
In-Reply-To: <20060317182722.B8529@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603172314.47124.blaisorblade@yahoo.it>
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
Date: Fri, 17 Mar 2006 23:14:46 +0100
To: Werner Almesberger <wa@almesberger.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>

On Friday 17 March 2006 22:27, Werner Almesberger wrote:
> Blaisorblade wrote:
> > 1) I'll try to fix poll(2) to return -EINVAL. Dunno whether anyone will
> > say "no, the app is stupid, it deserves no error", but hope not (with
> > "try" I refer to this). Attached patch should do this.
>
> I think the behaviour of "poll" with nfds = 0 is correct as it is.
> At least POSIX doesn't say anything to the extent that "nfds"
> couldn't be zero:

> http://www.opengroup.org/onlinepubs/009695399/functions/poll.html

I don't think that "hanging" is a correct behaviour anyway... unless the 
application *wanted* to wait for a signal, but this is a clumsy way to do 
this (I don't think there's any difference from pause()).

> Furthermore, this is one of several ways to implement a "sleep"
> function with sub-second granularity

> , so existing applications 
> may already depend on "poll" accepting nfds = 0. (Of course,
> they would probably be better off using "nanosleep".)

This is a very smart note, however usleep(3) exists since 4.3 BSD so this is a 
bit unlikely; however you're surely right on this.

> > 2) write_sigio_thread should do a "down" on a semaphore/mutex and the
> > first update_thread should "up" it.
>
> Yup :-)
>
> Thanks,
> - Werner

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
