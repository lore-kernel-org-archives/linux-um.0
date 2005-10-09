Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOgNO-0001UW-DU	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 11:58:26 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EOgNQ-0003uZ-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 11:58:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Respawning too fast - 2.6.13-bs2
References: <229e70f20510070643h79c3a661q116d6093d0a63bdf@mail.gmail.com>
	<200510071707.41531.blaisorblade@yahoo.it>
	<229e70f20510072323u725b2406l84b19c66942254ac@mail.gmail.com>
In-Reply-To: <229e70f20510072323u725b2406l84b19c66942254ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510092058.52891.blaisorblade@yahoo.it>
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
Date: Sun, 9 Oct 2005 20:58:52 +0200
To: Etay Meiri <etay.meiri@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 08 October 2005 08:23, Etay Meiri wrote:
> > > INIT: Id "0" respawning too fast: disabled for 5 minutes
> > > INIT: no more processes left in this runlevel
> > >
> > > I did play with it earlier (updated a few rpms and configured nfs) but
> > > I'm not sure which of my steps caused this.
> > > Any idea how to debug it?
> >
> > Problems like this come usually from:
> > b) messing up /etc/inittab (possibly from RPM?) - it must use non-DevFS
> > names
>
> /etc/inittab contained 'tty0' as the device. It doesn't exist in /dev. I
> changed
> it to 'console' and now it is working correctly.
Does Ctrl-C/Ctrl-Z work? I know it doesn't on /dev/console.

Go back and create /dev/tty0 (major 4, minor 0, character device).
> Thanks a lot,

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
