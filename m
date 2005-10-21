Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET1pH-0005tp-BB	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 11:41:11 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ET1pE-0001lf-So
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 11:41:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Strange behaviour of hwrng
References: <1129919051.27787.42.camel@localhost.localdomain>
In-Reply-To: <1129919051.27787.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510212042.29634.blaisorblade@yahoo.it>
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
Date: Fri, 21 Oct 2005 20:42:29 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Stolpmann <info@gerd-stolpmann.de>

On Friday 21 October 2005 20:24, Gerd Stolpmann wrote:
> Hi list,
>
> I recently tested the hwrng driver. In principal, it works, but it
> sometimes eats up all host CPU time. In particular, I can see that the
> UML system does a (blocking) read on /dev/hwrng,

Could you please elaborate on that? Who is doing the read, the rng tools? 
Also, are they doing only a single read (in which case, it's we the ones who 
are looping and we're broken) or they are astonished by our -EAGAIN and keep 
trying (in which case, they are broken)?

Actually, from looking at the code (arch/um/drivers/random.c:rng_dev_read()) 
it appears that we _do_ loop ourselves, if the read is blocking. Not sure how 
to handle that.

We could return maybe -EIO, possibly when a rate limit is exceeded (not 
trivial to do, though - I must learn using timers first).
> and that the host 
> system loops while reading from /dev/random which almost always returns
> -EAGAIN. (Found that out with strace, in the hope the output is
> correct.)

Well, if the host hasn't enough entropy, it's reasonable for it to return 
-EAGAIN.

And we should do the same (the loop is actually executed by the UML code, 
right?).

However, probably the tools inside UML don't expect a lot to get -EAGAIN from 
an hardware generator. So possibly they are not ready to handle that well.

> Nevertheless rngd seems to work, because when killing with SIGUSR1 it
> shows some reasonable statistics.

> My test setup is as follows:

> - Host system: 2.6.12.6 with SKAS3 v8.2 patch
> - UML system: 2.6.14-rc5, in SKAS3 mode.
>   Using rngd from Debian Sarge.
>   TLS is disabled.

> Let me know if you need more information.

> Gerd

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
