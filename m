Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjjGZ-0000fZ-1Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 13:22:56 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GjjGW-0004Au-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 13:22:55 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GjjG7-0004wz-Sg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 22:22:28 +0100
Received: from desk.marajade.sandelman.ca ([205.150.200.247])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 13 Nov 2006 22:22:27 +0100
Received: from mcr by desk.marajade.sandelman.ca with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 13 Nov 2006 22:22:27 +0100
From: Michael Richardson <mcr@sandelman.ca>
Date: Mon, 13 Nov 2006 16:21:48 -0500
Message-ID: <ejanll$fal$1@sea.gmane.org>
References: <eilvlj$b5r$1@sea.gmane.org> <eioacp$m4r$1@sea.gmane.org>
	<20061108181025.GC5698@ccure.user-mode-linux.org>
Mime-Version: 1.0
In-Reply-To: <20061108181025.GC5698@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] problems with ifup-a on etch compiled kernels
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

Jeff Dike wrote:
> On Mon, Nov 06, 2006 at 01:44:56PM -0800, Michael Richardson wrote:
> 
>>I've tracked this down to a number of places. It looks like the ifa->ifa_dev is not
>>valid when the notification chain is called:
> 
> 
> Can you tell me how to reproduce this, or send me a filesystem on which this
> happens?

I think that I finally can.
I have replaced my file system on laptop with a fresh one, and my problem has gone away.
It was the last thing to try. Clearly, if a userland change can cause a kernel
oops, there is a problem.

I will try my broken file system on a working host, and if it reproduces the problem,
I will tell you were to get the file system, and/or I can give you a login.




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
