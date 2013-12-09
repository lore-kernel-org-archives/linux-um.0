Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gregkh@linuxfoundation.org>) id 1Vq5oE-0006no-S3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 18:43:58 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vq5oD-0005d7-RS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 18:43:58 +0000
Date: Mon, 9 Dec 2013 10:45:26 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20131209184526.GB29335@kroah.com>
References: <2103356.guehJfKbl6@sandpuppy> <20131209082014.GA26598@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131209082014.GA26598@kroah.com>
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
Subject: Re: [uml-devel] Please add: um: add missing declaration of
 'getrlimit()' and friends
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, stable@vger.kernel.org

On Mon, Dec 09, 2013 at 12:20:14AM -0800, Greg KH wrote:
> On Mon, Dec 09, 2013 at 08:33:59AM +0100, Richard Weinberger wrote:
> > Hi Greg,
> > 
> > please add commit fdfa4c952844fce881df8c76de9c7180cbe913ab (um: add missing 
> > declaration of 'getrlimit()' and friends) to -stable.
> > The change was introduced in 3.9 and needs backporting to all stable trees.
> 
> Which "all"?  Newer than 3.9 you mean?

Sorry, that should be "older".  I've queued it up for 3.4-stable now,
thanks.

greg k-h

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

