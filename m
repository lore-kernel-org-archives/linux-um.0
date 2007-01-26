Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HASs5-0001IQ-T4 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 07:20:10 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HASs4-0007jO-BH
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 07:20:09 -0800
Date: Fri, 26 Jan 2007 10:13:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070126151328.GA4436@ccure.user-mode-linux.org>
References: <Pine.LNX.4.64.0701260101250.5924@sparrow>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701260101250.5924@sparrow>
Subject: Re: [uml-devel] Possible hostfs uml kernel data corruption with
	missing host directory (fc6, 2.6.20-rc5-git3 on opteron)
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
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Jan 26, 2007 at 04:07:05AM -0500, William Stearns wrote:
> 	After bisecting the difference between the two root filesystems, 
> the critical change was a line in /etc/fstab:
> 
> none            /mirrors        hostfs  defaults,/home/mirrors  0 0
> 
> 	Woah.  


Hmmm.

Can you enable all of the memory debugging options under Kernel
Hacking and try this again?  The slab debugging may trap it closer to
the actual bug.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
