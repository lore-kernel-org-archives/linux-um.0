Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZCAd-0008MJ-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 09:52:11 -0800
Received: from bay24-f24.bay24.hotmail.com ([64.4.18.74] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZCAd-0005Eb-BG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 09:52:11 -0800
Message-ID: <BAY24-F24DE77DFAFC0AE79A2272E83BE0@phx.gbl>
In-Reply-To: <200411301427.04377.blaisorblade_spam@yahoo.it>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] Re: [PATCH] uml_router: cleanup #2
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Tue, 30 Nov 2004 17:51:08 +0000
To: blaisorblade_spam@yahoo.it
Cc: kraxel@bytesex.org, user-mode-linux-devel@lists.sourceforge.net, uml@uxu.ch


Blaisorblade wrote:
>On Tuesday 30 November 2004 11:32, Gerd Knorr wrote:
> > > Patch 14 is a fun little UDP packet driver inspired by Felix M?ri for
> > > connecting multiple UMLs together.  It's inherently unsecure so you 
>must
> > > uncomment the driver in the makefile if you want to play with it.
>
> > Why this?  Compile time options are evil.  Runtime option which is off
> > by default is perfectly fine IMHO.
>I guess Steve tries to be user-proof, since users in his opinion mustn't 
>use
>it. Guessed right?

Yup.  I'm not convinced a guest uml with host networking couldn't inject 
arbitrary packets to a switch.  I'm also not convinced that I write perfect 
code that *is off* by default.  I cringe thinking my first draft would go 
into someone's production with just 5 minutes of me playing with it.

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
