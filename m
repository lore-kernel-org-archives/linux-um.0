Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDhfF-0000nX-1W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 03:30:41 -0700
Received: from ns.lbox.cz ([62.129.50.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDhfE-0005CF-AH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 03:30:40 -0700
Received: from mail.cubenet.cz (mail.cubenet.cz [62.129.60.162])
	by ns.lbox.cz (8.11.6/8.11.6) with ESMTP id i3EAUZP07068
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Apr 2004 12:30:35 +0200
Received: from linuxbox.linuxbox.cz ([10.76.66.10])
	by mail.cubenet.cz (8.11.6/8.11.6) with ESMTP id i3EAUWP29585
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Apr 2004 12:30:32 +0200
Received: from linuxbox.linuxbox.cz (localhost.localdomain [127.0.0.1])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i3EASC42002582
	for <user-mode-linux-devel@lists.sourceforge.net.OUTNOCOPY>;
	Wed, 14 Apr 2004 12:28:12 +0200
Received: (from mail@localhost)
	by linuxbox.linuxbox.cz (8.12.8/8.12.8/Submit) id i3EASCBe002578
	for user-mode-linux-devel@lists.sourceforge.net.OUTNOCOPY;
	Wed, 14 Apr 2004 12:28:12 +0200
Received: from [10.76.66.13] (develbox.linuxbox.cz [10.76.66.13])
	by linuxbox.linuxbox.cz (8.12.8/8.12.8) with ESMTP id i3EAS642002546
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Apr 2004 12:28:06 +0200
Subject: Re: [uml-devel] openswan @ missing symbols strstr & memset
From: Nikola Ciprich <extmaillist@linuxbox.cz>
In-Reply-To: <200404131947.02463.blaisorblade_spam@yahoo.it>
References: <1081875793.19343.90.camel@develbox>
	<200404131947.02463.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="utf-8"
Message-Id: <1081938622.19343.99.camel@develbox>
Mime-Version: 1.0
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
Date: Wed, 14 Apr 2004 12:30:22 +0200
Content-Transfer-Encoding: 8bit
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>

thanks for reply, I took a look to user_syms.c of version I'm using, and
really both memset and strstr are exported, but with
EXPORT_SYMBOL_PROTO. whats the difference between EXPORT_SYMBOL and
EXPORT_SYMBOL_PROTO? and it did not work, so should I just remove
_PROTO?
thanks in advance
V Út, 13. 04. 2004 v 19:47, BlaisorBlade píše:
> Alle 19:03, martedì 13 aprile 2004, Nikola Ciprich ha scritto:
> > Hello, I was trying to get openswan working under UML, module compiles
> > fine, but trying to load it fails with complaint about unresolved symbol
> > memset and strstr
> > I've found that those symbols are exported in i386 ksyms, but not in uml
> > ksyms, so I've created little patch (enclosed), and everythink seems to
> > work well.
> 
> > I'd like to ask, if my solution is 'clean' and if yes,
> Yes, it is clean (just it should go inside user_syms.c), but IIRC it has been 
> applied to late 2.4 & 2.6 UML kernels (I could be wrong). Check against 
> latest version and if it is not there (look inside user_syms.c) send the 
> patch, after making the change in user_syms.c, to Jeff Dike.
> 
> Bye



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id70&alloc_id638&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
