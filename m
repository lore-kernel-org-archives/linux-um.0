Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2TLI-0002Vk-Gh for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 02:59:40 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B2TLG-0006qp-Fe for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 02:59:38 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML crashing-the known scheduler bug
References: <20040311185105.GA22820@speedy.schwinge.homeip.net>
	<200403112056.08200.blaisorblade_spam@yahoo.it>
	<20040313010000.GA13419@speedy.schwinge.homeip.net>
In-Reply-To: <20040313010000.GA13419@speedy.schwinge.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403141200.55711.blaisorblade_spam@yahoo.it>
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
Date: Sun, 14 Mar 2004 12:00:55 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 02:00, sabato 13 marzo 2004, Thomas Schwinge ha scritto:
> On Thu, Mar 11, 2004 at 08:55:46PM +0100, BlaisorBlade wrote:

> > If you have a SMP host, use for the host the SKAS patch found at:
> >
> > http://www.user-mode-linux.org/~blaisorblade
> >
> > since it has a critical fix for SMP mode.
>
> Are there any other differences between your SKAS mode patch and
> <URL:http://www.metaparadigm.com/~mclark/uml/uml-2.6.3-skas-1.patch>?

My code has only that change (that one is just a port of older version of the 
patch I provide); for that patch, however, you need to have already applied 
the UML patch, while I've built a clean patch for a vanilla *and*, in 
alternative, one that applies onto the Uml patch.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
