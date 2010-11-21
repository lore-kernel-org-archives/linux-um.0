Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <stano@meduna.org>) id 1PK8j4-000338-D0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 12:08:58 +0000
Received: from www.meduna.org ([92.240.244.38] helo=meduna.org)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PK8j1-0002oH-Oh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 12:08:58 +0000
Received: from dial-78-141-95-31-orange.orange.sk ([78.141.95.31]
	helo=[192.168.130.27])
	by meduna.org with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <stano@meduna.org>) id 1PK75K-0006VD-PB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 11:23:55 +0100
Message-ID: <4CE8F332.3050205@meduna.org>
Date: Sun, 21 Nov 2010 11:23:46 +0100
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <20101118114143.GB23698@cs.unibo.it>
	<AANLkTimYG1jLwJ2tWLonFcoMWaQtaR9RG7HWJDbdE4cS@mail.gmail.com>
In-Reply-To: <AANLkTimYG1jLwJ2tWLonFcoMWaQtaR9RG7HWJDbdE4cS@mail.gmail.com>
Subject: Re: [uml-devel] user-mode-linux-devel@lists.sourceforge.net,
 Jeff Dike <jdike@addtoit.com>
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
To: user-mode-linux-devel@lists.sourceforge.net

On 21.11.2010 10:35, Geert Uytterhoeven wrote:

>> * user-mode-linux: dead or alive?

>>From a plain user's view: basically dead

Why? See e.g. http://user-mode-linux.sourceforge.net/downloads.html
SKAS3 is against 2.6.23 and unmaintained (my problem with
skas3 corrupting floating point registers did not get fixed
two years ago, although I tracked it to the skas3 and
provided a complete example to reproduce it).

SKAS4 is against 2.6.24 and marked as experimental.

So what should a new user searching for a virtualization
soultion take from it? Maybe there is an active development
running, but I don't see it, alhough I am following the
uml-devel.

Having an unmaintained old and experimental new version
is a sure way to hell for any software product, free
or non-free...

> Personally, I like UML because
>   - It's easy to get it running,
>   - I can run it without needing root access, so I can run it on any
> Linux machine I have an account on[*],
>   - I can use it to do things that are limited to root-only, e.g.
>       * create device nodes on file system images,
>       * run wireshark to analyze network communication.
>   - I even use it to debug/develop code for the Amiga Zorro bus, by
> adding a fake bus with fake devices ;-)

As a help tool to run at the workstation, yes, by any means
As a serious tool to virtualize services: no

Regards
-- 
                                  Stano

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

