Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMkhy-0001Hm-1j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 03:43:58 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMkhx-0005nk-Lx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 03:43:58 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
References: <200603230317.48384.blaisorblade@yahoo.it>
	<200603240044.06196.blaisorblade@yahoo.it>
	<20060324015120.GA8104@ccure.user-mode-linux.org>
In-Reply-To: <20060324015120.GA8104@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241243.51087.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 12:43:50 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Friday 24 March 2006 02:51, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 12:44:05AM +0100, Blaisorblade wrote:
> > Yes, that is true, but meanwhile give a testing to them, especially
> > regressio test the new patches. I can't merge new patches in until I'm
> > sure they don't cause regressions.

> OK, I give it a thumbs-up on a first boot - it's running my FC5
> filesystem without any trouble.  I'll keep playing with it and let you
> know of any trouble.

With the x86-64 host hack, it works here too.

To do good stress-testing, I've actually noticed the existing problems when I 
started running apache benchmark (with apache using multithreading, i.e. 
mpm_worker_thread).

I run it like:

ab2 -n 100 -c 10 -t 30 -v 1 Sarge/

where -n, -c and -t are simple parameters which can be tuned at will. (It 
could be simply ab on your distro).

> Attached is a tarball of the patches merged after the patches I have
> planned for 2.6.17.  Nothing major, just some fuzz, some Makefile
> rejections, and rejections from some whitespace cleanup in
> kernel/skas/process_kern.c.

Will look at.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
