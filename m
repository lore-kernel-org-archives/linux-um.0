Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJabu-00061x-SI	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 10:48:22 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJabq-0002QK-7Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 10:48:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] x86_64 kernel panic in skas mode
References: <200509241242.22417.blaisorblade@yahoo.it>
	<1127575895.8538.24.camel@hygyhome>
In-Reply-To: <1127575895.8538.24.camel@hygyhome>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509251633.15261.blaisorblade@yahoo.it>
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
Date: Sun, 25 Sep 2005 16:33:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Hegedus Gabor <hygylista@jpm.hu>

On Saturday 24 September 2005 17:31, Hegedus Gabor wrote:
> Hi!
>
> I have an x86_64 kernel (2.6.13-2) (on a celeron 64bit processor, debian
> sarge). I patched it with -v9-pre7.
The SKAS patch doesn't work on x86_64 hosts. Stop. There some code which makes 
it "almost" work, but you can't run UML on it.
> When I start the uml It found the 
> skas patch, then:
Try adding a "skas0" switch - SKAS0 mode should start successfully, and if not 
that's another story.
> Unable to load iterpreter
> Kernel panic: kernel BUG at memory.c:337!

> When I start it with mode=tt, then it starts tt mode successfully.

> This guest binary compilled on a 32 bit system, with a 2.4.25 kernel.

> I try to compille a 2.6.13-2 guest system, but this is failed too.
On this I cannot answer, since you don't give info.
> bye
>   HyGy
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
