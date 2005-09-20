Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHmig-0005en-OF	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 11:19:54 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EHmia-0006Ao-OX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 11:19:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML patch for  linux-2.6.10
References: <29D15BBCA340DA4D8146D38B4924FC7A0235A81B@zcarhxm0.corp.nortel.com>
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A0235A81B@zcarhxm0.corp.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509202018.13741.blaisorblade@yahoo.it>
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
Date: Tue, 20 Sep 2005 20:18:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Majid Salame <msalame@nortel.com>, user-mode-linux-user@lists.sourceforge.net

On Monday 19 September 2005 22:08, Majid Salame wrote:
> Hi all,
>  Could anyone point me to a stable linux-2.6.10 UML patch ?
There's none, but vanilla 2.6.10 has included UML support; I wouldn't call 
that trustworthy (especially from the "security" point of view).

The amount of patches which went in for UML before 2.6.11 was released was so 
big, and they were so heavy, I never got around to releasing a -bs patch for 
that.

That said, why do you need 2.6.10? If that's for external modules, there's 
little chance anyway they work on UML (unless they are well written and 
open-source, in which case they've likely been ported to later releases).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
