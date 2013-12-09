Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <luis.henriques@canonical.com>) id 1Vq2ed-0000kV-P3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 15:21:51 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vq2ec-0001TV-8Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 15:21:51 +0000
Date: Mon, 9 Dec 2013 15:21:39 +0000
From: Luis Henriques <luis.henriques@canonical.com>
Message-ID: <20131209152138.GH4278@hercules>
References: <2103356.guehJfKbl6@sandpuppy>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2103356.guehJfKbl6@sandpuppy>
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

On Mon, Dec 09, 2013 at 08:33:59AM +0100, Richard Weinberger wrote:
> Hi Greg,
> 
> please add commit fdfa4c952844fce881df8c76de9c7180cbe913ab (um: add missing 
> declaration of 'getrlimit()' and friends) to -stable.
> The change was introduced in 3.9 and needs backporting to all stable trees.
> 
> Thanks,
> //richard
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks, I'm queuing it for the 3.5 kernel.

Cheers,
--
Luis

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

