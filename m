Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1UaI-0000pE-1T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Feb 2005 11:11:38 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D1UaD-00076p-By for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Feb 2005 11:11:37 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS-v8: RC2 released against 2.6.7 - 2.6.11-rc3-bk6
	kernels
References: <200502110411.35438.blaisorblade@yahoo.it>
	<170001c512f4$2c279940$0201a8c0@hawk>
	<42121406.40901@fujitsu-siemens.com>
In-Reply-To: <42121406.40901@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502162010.15921.blaisorblade@yahoo.it>
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
Date: Wed, 16 Feb 2005 20:10:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, "Christopher S. Aker" <caker@theshore.net>

On Tuesday 15 February 2005 16:23, Bodo Stroesser wrote:
> Christopher S. Aker wrote:
> >>I just rolled a 2.6.11-rc4+cfq-ts-21 host kernel and I'll be testing this
> >> today.
> >
> > 2.6.11 doesn't seem to be ready for host duty yet:
>
> Yes. There is a bug in the v8-rc2 patch for 2.6.11
Agreed, sorry for forgetting it.
> Try the attached fix, please.

>        Bodo
>
>
> To BlaisorBlade: I tested the v8-rc2 for 2.6.9, too. It works fine for me.
Nice... have you any remarks about fix-dumpable-handling.patch? That's the 
more important doubt for me.
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
