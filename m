Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENtpT-0004KC-8Q	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 08:08:11 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ENtpJ-0006ug-GA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 08:08:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Respawning too fast - 2.6.13-bs2
References: <229e70f20510070643h79c3a661q116d6093d0a63bdf@mail.gmail.com>
In-Reply-To: <229e70f20510070643h79c3a661q116d6093d0a63bdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510071707.41531.blaisorblade@yahoo.it>
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
Date: Fri, 7 Oct 2005 17:07:38 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Etay Meiri <etay.meiri@gmail.com>

On Friday 07 October 2005 15:43, Etay Meiri wrote:
> Hi,
>
> I'm suddenly unable to boot my 2.6.13-bs2 based uml system.
> Getting the following errors at the end:
>
> Starting anacron: [ OK ]
> Starting atd: [ OK ]
> Starting system message bus: [ OK ]
> Starting HAL daemon: [ OK ]
> INIT: Id "0" respawning too fast: disabled for 5 minutes
> INIT: no more processes left in this runlevel
>
> I did play with it earlier (updated a few rpms and configured nfs) but
> I'm not sure which of my steps caused this.
> Any idea how to debug it?
Problems like this come usually from:
a) disabling the console channels you're using in the kernel configuration
b) messing up /etc/inittab (possibly from RPM?) - it must use non-DevFS names 
(though I don't think this happened to you)

c) if TLS had been disabled, upgrading glibc would restore it, and this could 
cause problems like that (not sure, really).

d) trying to boot with init=/bin/sh and looking around could help you in 
debugging this. Plus you can anyway watch the logs, if you can ssh in.
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
