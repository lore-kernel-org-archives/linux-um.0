Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6Zc4-0003ju-Mo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jul 2006 14:11:16 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1G67os-0007Ct-H7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 08:30:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G67oo-00030Y-Lq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 08:30:36 -0700
Date: Thu, 27 Jul 2006 11:29:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060727152956.GB4744@ccure.user-mode-linux.org>
References: <Pine.LNX.4.64.0607251401110.3223@sparrow>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607251401110.3223@sparrow>
Subject: Re: [uml-devel] building 2.6.18-rc2 with Jeff's 2.6.17 patchset,
	add-stub-vmas patch issue
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
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Jul 25, 2006 at 02:35:26PM -0400, William Stearns wrote:
> 	A few of the patches don't apply - I skipped those.
> 	Of those that do, it _looks_ like Bodo's add-stub-vmas.patch has 
> an issue:

I just pushed out the latest stuff.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
