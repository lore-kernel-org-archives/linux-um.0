Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2c5S-00041q-Nj for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 12:19:54 -0800
Received: from smtpin.eastlink.ca ([24.222.0.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2c5R-0003LH-UJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 12:19:54 -0800
Received: from murphy.hfx.andara.com ([24.222.9.181])
	by mx4.eastlink.ca (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb
	13 2003)) with ESMTP id <0HUL00HO71SY0T@mx4.eastlink.ca> for
	user-mode-linux-devel@lists.sourceforge.net; Sun,
	14 Mar 2004 16:19:48 -0400 (AST)
From: Chris Watt <cnww@hfx.andara.com>
Subject: Re: [uml-devel] Cryptolook device?
In-reply-to: <4053B523.10203@darkman.de>
Message-id: <5.2.0.9.0.20040314161733.00a7b3c8@crunch>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
References: <4053AD51.3030704@upb.de>
	<5.2.0.9.0.20040313192828.02fdaea0@crunch> <4053AD51.3030704@upb.de>
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
Date: Sun, 14 Mar 2004 16:19:46 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven 'Darkman' Michels <sven@darkman.de>

At 02:28 AM 14/03/2004 +0100, you wrote:
>add:
>
>source crypto/Config.in
>
>at the end of arch/um/config.in

This adds CryptoAPI, which required for cryptoloop, but not all that's 
required. In 2.4 you also need to apply one of the cryptoloop patches that 
are drifting around, otherwise your loopback device won't actually use the 
CryptoAPI.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
