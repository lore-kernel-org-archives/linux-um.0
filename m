Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CX3oF-0006iq-9O for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 12:32:15 -0800
Received: from dns2.uxu.ch ([195.216.70.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CX3oE-0004LH-6c for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 12:32:15 -0800
Message-ID: <41A4EE93.9090800@uxu.ch>
From: =?ISO-8859-1?Q?Felix_M=FCri?= <uml@uxu.ch>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] uml_router: cleanup
References: <BAY24-F27D8548BC9B2976EFF8B3883B80@phx.gbl>
	<874qjfftsz.fsf@bytesex.org>
In-Reply-To: <874qjfftsz.fsf@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 24 Nov 2004 21:26:59 +0100
To: User-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Steve Schmidtke <steve_schmidtke@hotmail.com>

Gerd Knorr schrieb:

> "Steve Schmidtke" <steve_schmidtke@hotmail.com> writes:
> 
> 
>>Hi,
>>
>>While I was playing around with uml_switch, I started thinking that
>>the code is a bit messy and really could use a facelift.
> 
> While browsing the code I figured that it likely is easier to largely
> rewrite the stuff rather than trying to fix the existing stuff.
> Especially the mac handling is broken by design.
> 
Hello,

long ago I found similar issues with the uml_switch codebase. My 
problem was not the mac handling, but an missing feature to 
connect two switches together via an udp-tunnel. I have rewritten 
(but not redesigned) most of the code. The latest published 
codebase can be found here:

http://www.uxu.ch/uxu/software/uml_switch2


regards

Felix


P.S.: My code is (since about a year) in the state of further 
improvement (I want an uml-switch, which can start and stop 
uml-guests and be controlled via a control socket), but this 
codebase is actually not in an releasable state (although I use 
it on my production machine :-)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
