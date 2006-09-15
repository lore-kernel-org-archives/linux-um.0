Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GOH5X-0001Q2-PQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Sep 2006 10:02:51 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GOH5W-0007YO-7Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Sep 2006 10:02:51 -0700
Date: Fri, 15 Sep 2006 13:01:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060915170149.GG4581@ccure.user-mode-linux.org>
References: <mailman.1307.1157397566.8760.user-mode-linux-user@lists.sourceforge.net>
	<44FF2B54.5020201@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44FF2B54.5020201@nagafix.co.uk>
Subject: Re: [uml-devel] virtual framebuffer device visible on host
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 06, 2006 at 09:11:00PM +0100, Antoine Martin wrote:
> Just a thought, but how hard would it be to have a virtual device in the 
> guests that mimics a framebuffer device and is in fact an X window on 
> the host? I think this could almost be a killer-app.

There is such a patch in my development tree.  The problem is that it
totally doesn't work for me, even though it's fine for the guy who wrote
it.

It needs to be run on a local X server since it uses the shared memory
extension, but even when I do that, I get a black window with nothing
in it.

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
