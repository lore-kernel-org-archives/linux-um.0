Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZ7z5-0002dw-3C for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 05:23:59 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CZ7z4-00046U-AG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 05:23:59 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] uml_router: cleanup #2
References: <BAY24-F18CD7435AB94FE5A10013283BE0@phx.gbl>
	<20041130103255.GB5593@bytesex>
In-Reply-To: <20041130103255.GB5593@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411301427.04377.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Nov 2004 14:27:03 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Steve Schmidtke <steve_schmidtke@hotmail.com>, uml@uxu.ch

On Tuesday 30 November 2004 11:32, Gerd Knorr wrote:
> > Patch 14 is a fun little UDP packet driver inspired by Felix M?ri for
> > connecting multiple UMLs together.  It's inherently unsecure so you must
> > uncomment the driver in the makefile if you want to play with it.

> Why this?  Compile time options are evil.  Runtime option which is off
> by default is perfectly fine IMHO.
I guess Steve tries to be user-proof, since users in his opinion mustn't use 
it. Guessed right?

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
