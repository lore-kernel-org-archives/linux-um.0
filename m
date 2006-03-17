Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKOmI-0006P4-HB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 15:54:42 -0800
Received: from host.almesberger.net ([204.10.140.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FKOmH-00051F-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 15:54:42 -0800
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060317205430.C8529@almesberger.net>
References: <200603111301.42195.rob@landley.net>
	<200603172036.59218.blaisorblade@yahoo.it>
	<20060317182722.B8529@almesberger.net>
	<200603172314.47124.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603172314.47124.blaisorblade@yahoo.it>;
	from blaisorblade@yahoo.it on Fri, Mar 17, 2006 at 11:14:46PM
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
Date: Fri, 17 Mar 2006 20:54:30 -0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>

Blaisorblade wrote:
> however usleep(3) exists since 4.3 BSD so this is a 
> bit unlikely;

Oh, there must be a million of passably valid reasons why someone
may still do it this way, e.g.,

- because they don't know of the more suitable function

- because they don't trust the more suitable function for some
  reason

- because they're using some restricted set of functions,
  e.g., from a portable library

- because the other function isn't available on all platforms
  they care about, while the "poll" functionality (perhaps
  through some abstraction that may also use "select") is

- because they use a signal to get out of the initial "hang"

- because the semantics of their code actually say "I/O or
  timeout"

- because that's what the code that has passed all those
  reviews and certifications does, and nobody is allowed to
  touch it. Ever.

etc.

Just because this valid if unexpected behaviour was a little
inconvenient for us isn't a good reason for breaking it. If
a safe, easy, and incredibly boring life was the top item on
our agenda, we should start with getting rid of concurrency ;-)

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
