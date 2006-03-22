Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FM5IX-0003KT-MD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 07:30:57 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FM5IT-0006MW-SP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 07:30:57 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] memory option crashes the uml bootstrap phase
References: <20060321142624.GA18505@SteX>
	<200603211954.08891.blaisorblade@yahoo.it>
	<20060321205127.GA22808@ccure.user-mode-linux.org>
In-Reply-To: <20060321205127.GA22808@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221630.40576.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 22 Mar 2006 16:30:39 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net

On Tuesday 21 March 2006 21:51, Jeff Dike wrote:
> On Tue, Mar 21, 2006 at 07:54:08PM +0100, Blaisorblade wrote:
> > However, test increasing /proc/sys/vm/max_map_count
>
> This only bites you when you have large UML processes - I don't think it
> can cause a crash on boot.

I remember this, I didn't have many other things to suggest (apart TT mode) 
and that setting is needed anyway (actually it's needed when you go _over_ 
256M per guest).

Fantasy is exhausting :-)
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
