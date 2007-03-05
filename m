Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOFbi-0004q8-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 08:00:15 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOFbg-00022v-Fo
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 08:00:14 -0800
Date: Mon, 5 Mar 2007 10:51:26 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070305155126.GA4717@ccure.user-mode-linux.org>
References: <200702220054.04938.blaisorblade@yahoo.it>
	<20070222195956.GA6414@ccure.user-mode-linux.org>
	<200703042013.39584.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200703042013.39584.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When opening /tmp/uml.ctl fails, what do we get?
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Mar 04, 2007 at 08:13:39PM +0100, Blaisorblade wrote:
> Have you checked if other calls require that register_netdev was already 
> called?

Just did, nothing else depends on it.

> Hmm, I'm really not sure about what to do about this. However I'd leave that 
> for a future cleanup and just add a comment about this.
> And the reason for which init now returns a value is that pcap_init _can_ 
> fail, so the switch transport is not the only odd one.

Yeah, that slipped my mind.

> struct uml_net_private {
> -        int user[1];
> +        char user[0];
> };

Neat, that used to be illegal.

> Another note: before of this patch, you should please apply the attached two 
> ones.
> 
> *) The first (net-mac-check-cleanup.diff) checks the validity of assigned MAC 
> address, but to print a meaningful error message requires adding a local 
> buffer.
> *) The second (net_kern-eth_configure...) allows avoiding this local buffer by 
> moving code around.
> 
> I think I'm excessively paranoid about these two patches and about not yet 
> merging them, so please give a look and merge them.

I just dropped them in - they look OK at a first glance.

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
