Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJtNd-0002Xt-9B for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Mar 2006 06:23:09 -0800
Received: from host.almesberger.net ([204.10.140.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FJtNb-0001K3-Eb
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Mar 2006 06:23:09 -0800
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060316112251.A17140@almesberger.net>
References: <200603111301.42195.rob@landley.net>
	<20060314202249.GB22286@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314202249.GB22286@ccure.user-mode-linux.org>;
	from jdike@addtoit.com on Tue, Mar 14, 2006 at 03:22:49PM -0500
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
Date: Thu, 16 Mar 2006 11:22:51 -0300
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> Having said that,
> if you can get a stack from the hang, it might turn out to be an easily
> diagnosed and fixed bug.

Seems that arch/um/kernel/sigio_user.c:write_sigio_thread begins
its poll before there are any fds in current_poll, so update_thread
caused by a add_sigio_fd shortly thereafter hangs while waiting for
a response.

A sleep(1) at the beginning of write_sigio_thread "fixes" this :-)

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
