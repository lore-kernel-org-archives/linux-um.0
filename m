Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZwemK-0002vJ-71
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 23:26:12 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZwemH-0007Cp-G8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 23:26:12 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZwemA-0007RI-Lx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 23:26:02 +0000
Received: from [144.49.71.22] (helo=[10.252.48.4])
	by smaug.kot-begemot.co.uk with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZwemA-0003qa-44
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 23:26:02 +0000
Message-ID: <5643CE82.6030302@kot-begemot.co.uk>
Date: Wed, 11 Nov 2015 23:25:54 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: "\"<1447079597-17816-1-git-send-email-aivanov@brocade.com>"	<5640B5B5.7050907@kot-begemot.co.uk>"	<1447274788.48401.3.camel@m3y3r.de>	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>	<5643B5A0.9080507@kot-begemot.co.uk>
	<f92188ee79c1a708a84a9bc64f8a5f02@nixia.no>
In-Reply-To: <f92188ee79c1a708a84a9bc64f8a5f02@nixia.no>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v2] EPOLL Interrupt Controller V2.0
To: user-mode-linux-devel@lists.sourceforge.net

There is for some reason IRQ/sigio handler reentrancy.

Both the debug "by hand" I stuck into irq.c and Thomas traces confirm it.

I have no clue how this is possible as the code in signal.c should guard 
against that.

I will sleep on it and try to tackle this tomorrow - no idea what is 
going on, but this is what is happening here.

A.

On 11/11/15 21:49, stian@nixia.no wrote:
>> I will probably add some "manual" debug code to check if the nested
>> invocation happens with the debug options off.
> Might be timing dependent and/or issue with nested blocking/unblocking
> of signals.
> Or debug printing when it should not.
>
> Just my two cents
>
> Stian Skjelstad
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

