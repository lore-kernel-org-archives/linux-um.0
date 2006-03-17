Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKMTv-0007Bn-99 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 13:27:35 -0800
Received: from host.almesberger.net ([204.10.140.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FKMTu-0003ZI-0h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 13:27:35 -0800
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060317182722.B8529@almesberger.net>
References: <200603111301.42195.rob@landley.net>
	<20060314202249.GB22286@ccure.user-mode-linux.org>
	<20060316112251.A17140@almesberger.net>
	<200603172036.59218.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603172036.59218.blaisorblade@yahoo.it>;
	from blaisorblade@yahoo.it on Fri, Mar 17, 2006 at 08:36:58PM
	+0100
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
Date: Fri, 17 Mar 2006 18:27:23 -0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>

Blaisorblade wrote:
> 1) I'll try to fix poll(2) to return -EINVAL. Dunno whether anyone will say 
> "no, the app is stupid, it deserves no error", but hope not (with "try" I 
> refer to this). Attached patch should do this.

I think the behaviour of "poll" with nfds = 0 is correct as it is.
At least POSIX doesn't say anything to the extent that "nfds"
couldn't be zero:

http://www.opengroup.org/onlinepubs/009695399/functions/poll.html

Furthermore, this is one of several ways to implement a "sleep"
function with sub-second granularity, so existing applications
may already depend on "poll" accepting nfds = 0. (Of course,
they would probably be better off using "nanosleep".)

> 2) write_sigio_thread should do a "down" on a semaphore/mutex and the first 
> update_thread should "up" it.

Yup :-)

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
