Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6UJd-0003tB-PQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 05:55:05 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D6UJY-0005Tz-I0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 05:55:05 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [dan@spaz.org: Bug#220680: user-mode-linux: Carrier
	not detected on serial port]
References: <20031114162017.GH9377@dijkstra.csh.rit.edu>
In-Reply-To: <20031114162017.GH9377@dijkstra.csh.rit.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503012001.57588.blaisorblade@yahoo.it>
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
Date: Tue, 1 Mar 2005 20:01:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Zimmerman <mdz@debian.org>, 220680-forwarded@bugs.debian.org

On Friday 14 November 2003 17:20, Matt Zimmerman wrote:
> ----- Forwarded message from Daniel Burton <dan@spaz.org> -----
>
> Date: Thu, 13 Nov 2003 19:34:59 -0800
> From: Daniel Burton <dan@spaz.org>
> Resent-From: Daniel Burton <dan@spaz.org>
> To: Debian Bug Tracking System <submit@bugs.debian.org>
> Subject: Bug#220680: user-mode-linux: Carrier not detected on serial port
>
> Package: user-mode-linux
> Version: 2.4.22-5um-1
> Severity: normal
>
>
> I am trying to run wvdial inside a User-Mode Linux with a serial port
> from the real computer mapped to one on the virtual machine.  The
> problem is that the carrier detect is not functioning properly.

Just as an archival note: from what I see, there is a lot of ioctl that are 
not implemented by the UML serial line driver... it is a very simple 
emulation. I don't know if what is failing in this case is some ioctl wvdial 
issues, but I think it is very likely.

However, sadly, given the current needs, this bug is not likely to be fixed, 
at least for the foreseeable future.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
