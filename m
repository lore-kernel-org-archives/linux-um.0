Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2t62-0003Av-TX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 10:47:49 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J2t5q-0007Q3-7u
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 10:47:36 -0800
Message-ID: <47617E3A.2000409@nagafix.co.uk>
Date: Thu, 13 Dec 2007 18:47:22 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <20071207182146.2b6f5176@mistral.stie>	<20071208040335.GA21495@c2.user-mode-linux.org>	<20071209212731.24bd6f01@mistral.stie>	<475DB98D.10001@nagafix.co.uk>	<20071210193441.1161c8ce@mistral.stie>	<475EDFA7.8020204@nagafix.co.uk>
	<20071211195413.53b122d6@mistral.stie>
In-Reply-To: <20071211195413.53b122d6@mistral.stie>
Subject: Re: [uml-devel] [uml-user] 64 bit host ?
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: lanas <lanas@securenet.net>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

lanas wrote:
>>> Even then, I'm surely missing something.  The Fedora Core x86_64
>>> binary is a mere 2 MB.  Shouldn't be a UML-patched kernel about the
>>> same size ?
> 
>> Hmmm, not sure.
>> Looks like the debug info is big indeed.
>> The config files are available, so you should be able to figure out
>> what makes it so fat. (frame-pointers?)
> 
[snip]
> 
> On the other hand, I downloaded today the source code of kernel
> 2.6.23-something and it was about 45 MB all in all.  Hard to imagine
> that a compiled kernel would be of the same size, no ?
Hah, yes. thinking about it, 45MB is a tad excessive!

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHYX45GK2zHPGK1rsRCjM6AJ4glZK9D0X0tbV27AHQuICywbFcMACbBwLD
Gam+fu8qTiKjC9nHnBBKlXo=
=O6ne
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
