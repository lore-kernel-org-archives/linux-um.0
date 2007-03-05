Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOHun-0008Rk-Rt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 10:28:05 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOHum-0005Ip-Vx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 10:28:05 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 5 Mar 2007 19:27:44 +0100
References: <200702220054.04938.blaisorblade@yahoo.it>
	<200703042013.39584.blaisorblade@yahoo.it>
	<20070305155126.GA4717@ccure.user-mode-linux.org>
In-Reply-To: <20070305155126.GA4717@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703051927.44601.blaisorblade@yahoo.it>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 05 March 2007 16:51, Jeff Dike wrote:
> On Sun, Mar 04, 2007 at 08:13:39PM +0100, Blaisorblade wrote:
> > Have you checked if other calls require that register_netdev was already
> > called?
>
> Just did, nothing else depends on it.
Fine.
> > Hmm, I'm really not sure about what to do about this. However I'd leave
> > that for a future cleanup and just add a comment about this.
> > And the reason for which init now returns a value is that pcap_init _can_
> > fail, so the switch transport is not the only odd one.
>
> Yeah, that slipped my mind.
>
> > struct uml_net_private {
> > -        int user[1];
> > +        char user[0];
> > };
>
> Neat, that used to be illegal.

If you use -pedantic (-ansi -std=c89 doesn't suffice) you'll learn that ISO C 
prohibits that; however, ethtool.h is quite a good example I guess, so GCC 
3.2 supports that; and the code is anyway simpler that way.

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
