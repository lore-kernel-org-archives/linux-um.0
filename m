Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2Jvh-0001D0-SK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 16:56:37 -0800
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B2JvV-0004Hx-9K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 16:56:25 -0800
Message-ID: <4053AD51.3030704@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] Cryptolook device?
References: <5.2.0.9.0.20040313192828.02fdaea0@crunch>
In-Reply-To: <5.2.0.9.0.20040313192828.02fdaea0@crunch>
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
Date: Sun, 14 Mar 2004 01:54:41 +0100
To: Chris Watt <cnww@hfx.andara.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>> menuconfig doesn't show the crypto loopback device. i'm just curious, 
>> but why is it disabled? or has it just been forgotten?
> 
> I patched it into 2.4.24 a while back, but I've misplaced my patch. You 
> may be able to find it in the uml-devel archives. Basically I just did 
> the following:

I'm talking about 2.6.4-um1 which doesn't include the CryptoLoop device 
although it is available in 2.6.4 without any additional patch.
It seems to me, as if Jeff just forgot to put it into some file (i'm 
don't know much about how menuconfig works, and where the config for 
that is).


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
