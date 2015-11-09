Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zvnz8-0001jG-2Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Nov 2015 15:03:54 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zvnz6-0007ki-8j
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Nov 2015 15:03:54 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zvnyz-0005mK-Ug
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Nov 2015 15:03:45 +0000
Received: from [209.37.255.2] (helo=[172.20.2.213])
	by smaug.kot-begemot.co.uk with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zvnyz-0003RI-76
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Nov 2015 15:03:45 +0000
Message-ID: <5640B5B5.7050907@kot-begemot.co.uk>
Date: Mon, 09 Nov 2015 15:03:17 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>
In-Reply-To: <1447079597-17816-1-git-send-email-aivanov@brocade.com>
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

It throws a couple of harmless "epoll del fd" warnings on reboot which 
result the fact that disable_fd/enable_fd are not removed in the 
terminal/line code.

These are harmless and will go away once the term/line code gets support 
for real write IRQs in addition to read at some point in the future.

I have fixed the file descriptor leak in the reboot case.

A.

On 09/11/15 14:33, Anton Ivanov wrote:
> Epoll based interrupt controller.
>
> IMPROVES: IO loop performance - no per fd lookups, allowing for
> 15% IO speedup in minimal config going to 100s of % with many
> devices - a N^N lookup is now replaced by a log(N)
>
> ADDS: True Write IRQ functionality
>
> OBSOLETES: The need to call reactivate_fd() in any driver which
> has only read IRQ semantics. Write IRQs work, but will need to
> be updated to use this fully.
>
> Potentially (with a change in API) will allow both edge and level
> IRQ semantics.
>
> Pre-requisite for using packet mmap and multipacket read/write
> which do not get along with poll() very well.
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>


------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

