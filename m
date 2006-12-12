Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gu53E-0003E7-K3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 02:39:56 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gu53C-0003Dz-W3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 02:39:56 -0800
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id BE49658ABD
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Dec 2006 11:39:51 +0100 (MET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 12 Dec 2006 18:12:24 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201324F53@ZMY16EXM67.ds.mot.com>
In-Reply-To: <Pine.LNX.4.62.0612121048340.20902@pademelon.sonytel.be>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Resent-To: User-mode Linux Kernel Development
	<user-mode-linux-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.LNX.4.62.0612121139500.20902@pademelon.sonytel.be>
Subject: Re: [uml-devel] Regarding getpid
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
To: Geert Uytterhoeven <geert@linux-m68k.org>

Ok Thanks. So actually getpid() doesn't cause mode switch.
But is it mandatory to execute  getpid()? If yes why

Regards,
Abhi

-----Original Message-----
From: geert@sonytel.be [mailto:geert@sonytel.be] On Behalf Of Geert
Uytterhoeven
Sent: Tuesday, December 12, 2006 3:19 PM
To: Krishnappa Abhijith-A21204
Cc: User-mode Linux Kernel Development
Subject: Re: [uml-devel] Regarding getpid

On Tue, 12 Dec 2006, Krishnappa Abhijith-A21204 wrote:
>             "Process system calls must be nullified in the host, and 
> this is done by converting them into getpid. "
> How is system calls  are nullified by converting them to getpid() ?

Instead of calling the actual system call, it just calls getpid(). I.e.
the actual system call is not executed, and getpid() is more or less a
NOP.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker.
But when I'm talking to journalists I just say "programmer" or something
like that.
							    -- Linus
Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
