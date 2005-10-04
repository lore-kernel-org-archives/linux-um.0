Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENb5R-0005IP-Sb	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Oct 2005 12:07:25 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ENb5P-0005Jh-6F
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Oct 2005 12:07:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] sysctl -w va.legacy_va_layout=1
References: <003e01c59644$3893a5b0$3c01010a@webwombat.com.au>
In-Reply-To: <003e01c59644$3893a5b0$3c01010a@webwombat.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041901.42002.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 19:01:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Phill Wombat <uml@webwombat.com>

On Monday 01 August 2005 04:53, Phill Wombat wrote:
> With 2.6.12+bs9 on x86_64 the error now changes

> On the host set:
> sysctl -w va.legacy_va_layout=1
> sysctl -w kernel.randomize_va_space=0

> Starting the uml with init=/bin/sh starts up as usual. Performing the ls
> command now result in a different thing happening: Bad op in do_proc_op

> Where as before it produced:
> Child 22915 exited with signal 11

Hi Phil, I was looking to old bugs and I came through your mail.
Has your bug been fixed in later releases?

Also, I see it's mostly related to x86_64 hosts - which are working a lot 
better now (especially thanks to SKAS0 mode).

IOW: is this still an issue, or can I consider this bug "closed"?
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
