Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTM0e-00074y-FL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:51:07 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTM0c-0004Mo-VL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:51:04 -0700
Date: Mon, 19 Mar 2007 13:48:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070319174857.GE11790@c2.user-mode-linux.org>
References: <45FE5141.3030007@cea.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <45FE5141.3030007@cea.fr>
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host
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
To: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 19, 2007 at 10:00:49AM +0100, Jacques-Charles Lafoucriere wrote:
> I am trying to build and run a UML 2.6.18 machine on a FC6 host. 
> (2.6.18-1.2798)

Why are you insisting on a 2.6.18 UML?

> I have tried many patches from the list and was not able to be successful
> (hang after VFS: Mounted root (ext3 filesystem) readonly.)

Try 2.6.21-rc4 or this patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=14251809b1921b1216568700f1be2f91a1cbb5c7

> Does the host need a special patch to run recent UML kernel or is it 
> only an issue in the UML machine ?

It was a bug in UML's handing of newer host VDSOs.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
