Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cjiaa-0002jj-1D for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 10:30:28 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CjiaV-0002HX-6E for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 10:30:27 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] synchronous hostfs
References: <27776.1104084973@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <27776.1104084973@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412291906.08122.blaisorblade@yahoo.it>
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
Date: Wed, 29 Dec 2004 19:06:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Sunday 26 December 2004 19:16, Michael Richardson wrote:
> I'm running 2.4.26-um3.
> I happen to be running hostfs with NFS underneath.
> I get core dumps from my application, and I want to gdb them outside
> of the UML.

> I had to switch from core dump to NFS (which seems to fail 
> now) to putting them in /tmp (which is ramdisk), and then move them to
> /var/tmp, which is hostfs.
Hmm - were you putting the core dumps inside a hostfs mount, right? This has 
been reported to fail badly with 2.4.26-3um... the hostfs contained in 
2.4.24-1um and 2.4.27-1bs (this tree is from me, on my homepage) is stable, 
while the one in 2.4.24-2um and subsequent releases isn't.

> Still, I now have to use unique file names, or things get confused
> between host and guest.
>
> I also like to do:
>   "make DESTDIR=/uml/root/file install"

> from outside. This now only has effect if I umount/mount the file
> system. (I know have a /usr/local mount just for this, even though
> /usr/local is inside of /)
> It used to be that this was a problem only if the program was running.

> Is there some way to defeat the caching that is occuring?
> or even to just flush it? (other than umount)
Hmmm, I don't know this... probably giving "sync" inside UML should work.
I remember that Jeff said that he made hostfs asynchronous in those releases 
on purpose (for performance, IIRC), and this is not bad.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
