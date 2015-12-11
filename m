Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1a7Isj-0007I4-2I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 08:16:49 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1a7Ish-0002i1-QN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 08:16:49 +0000
References: <564F0C6D.8000806@kot-begemot.co.uk>
	<CAFLxGvywFjhSwUAsAGtV3FQLvFCS+UaP4rJCDzbvZ3p+4nvjTQ@mail.gmail.com>
	<566A73FF.6080306@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <566A8667.1040808@nod.at>
Date: Fri, 11 Dec 2015 09:16:39 +0100
MIME-Version: 1.0
In-Reply-To: <566A73FF.6080306@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] IRQ handler reentrancy
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 11.12.2015 um 07:58 schrieb Anton Ivanov:
>>> 2. I cannot catch what is wrong with the current code in signal.c. When
>>> I read it, it should not produce re-entrancy. But it does.
>> Sorry for the delay. Until now I did not find the time to dig into that.
>> Did you find the offending code in signal.c?
> 
> Yes.
> 
> Unblock signals is logically incorrect - it will re-trigger an
> interrupts even if there is an interrupt in flight whose processing has
> not been finished.
> 
> I tried several approaches both with the original poll() controller and
> with my epoll() based version, some show promise.
> 
> I had to put it aside until next Friday as I have some stuff due at work
> so I cannot spare time to work on it until then. Once I get that out of
> the way I should be able to spare it a day or two which should be enough
> to finish it.
> 
> Ditto for the UBD improvements.

One thing we have to consider is that's legit to have SIGIO nested.
I'm currently investigating whether we use do_IRQ() correctly.

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

