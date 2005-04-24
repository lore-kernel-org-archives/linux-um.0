Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPhqN-0002uR-4g for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 07:12:19 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DPhqM-0003wZ-Fp for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 07:12:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: uml 2.4 (32 bit) on skas 2.6 (64 bit) - add on
References: <20050423180314.GA17743@copyleft.de>
	<20050423184032.GA17889@copyleft.de>
In-Reply-To: <20050423184032.GA17889@copyleft.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504241609.02850.blaisorblade@yahoo.it>
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
Date: Sun, 24 Apr 2005 16:09:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: kraehe <kraehe@copyleft.de>

On Saturday 23 April 2005 20:40, kraehe wrote:
> Moin Guru's,
>
>   I've just tried that, 2.4.30 with uml-2.4.28-bs2-pre11.patch works
>   on a 2.6.11.7-amd64 host without any SKAS patches. So TT mode is
>   fine.
Well, fine. SKAS64 still does not work yet, with any guest. I don't know yet 
what the hell happens, but I hope I can do some *real* debugging soon. And 
not even -v9-pre2 solves this problem.

Interesting enough, the problem I get with 2.6 guests is almost the same. 
Which makes sense.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
