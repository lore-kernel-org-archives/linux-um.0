Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2Ih6-0001oR-C7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 15:37:28 -0800
Received: from smtpin.eastlink.ca ([24.222.0.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2Ih5-0004ds-32 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 15:37:27 -0800
Received: from murphy.hfx.andara.com ([24.222.9.181])
	by mx3.eastlink.ca (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb
	13 2003)) with ESMTP id <0HUJ00M72GA7A4@mx3.eastlink.ca> for
	user-mode-linux-devel@lists.sourceforge.net; Sat,
	13 Mar 2004 19:37:20 -0400 (AST)
From: Chris Watt <cnww@hfx.andara.com>
Subject: Re: [uml-devel] Cryptolook device?
In-reply-to: <c2v5sr$k1b$1@sea.gmane.org>
Message-id: <5.2.0.9.0.20040313192828.02fdaea0@crunch>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
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
Date: Sat, 13 Mar 2004 19:37:20 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>

At 03:28 PM 13/03/2004 +0100, you wrote:
>hi,
>
>menuconfig doesn't show the crypto loopback device. i'm just curious, but 
>why is it disabled? or has it just been forgotten?

I've been told that it was mostly excluded because the pristine source 
doesn't include cryptoloop and nobody had expressed much interest in the 
CryptoAPI.

I patched it into 2.4.24 a while back, but I've misplaced my patch. You may 
be able to find it in the uml-devel archives. Basically I just did the 
following:

- Apply a cryptoloop patch (I forget if I was using cryptoloop-jari or 
cryptoloop-hvr, it was whichever was larger at the time because the smaller 
one didn't behave well with encrypted swap).

- Apply a UML patch.

- Alter the arch/um config files to include the CryptoAPI and cryptoloop 
config options.

It seemed to work quite well at the time.

If you're not in any rush and don't want to do it yourself, e-mail me back. 
I'll probably be getting back to UML in a more serious way in a couple of 
weeks, at which point I'll do something similar for 2.4.25 (or whatever the 
latest 2.4 kernel with a stable UML patch is at the time).




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
