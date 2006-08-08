Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAWKw-0005xr-QA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 11:29:54 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GAWKs-00032l-Qf
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 11:29:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 8 Aug 2006 20:29:53 +0200
References: <BAY7-F8B837FF733995C731DEAA94540@phx.gbl>
In-Reply-To: <BAY7-F8B837FF733995C731DEAA94540@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608082029.53613.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Which version to use
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 August 2006 06:52, Alejandro Liu wrote:
> Hi,
>
> What is a "current" version of UML to use as a guest?  I am currently using
> the one that comes with the vanilla 2.6.17.6 kernel and trying to use
> hostfs as root and found a number of bugs.

> Of course I went ahead and fixed those bugs but I don't know if I should
> send the patches somewhere 

Yes, thanks. To this list, Jeff Dike and me (and if you want LKML, but don't 
do that if you're shy or not entirely sure).

> or if these bugs were fixed in some "secret" 
> development version of UML.

No. hostfs is _at the moment_ unmaintained. There is a rewrite of hostfs 
(based on the new externfs), but it is nowhere near merging (it's under slow 
development since at least an year).

You can find the development tree here:
http://user-mode-linux.sourceforge.net/patches.html

> PS: Actually I did not set out to do bug hunting, I was just adding some
> features to hostfs that I wanted to use.
You could maybe post them too.
> The bug fixing was just a side 
> effect.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
