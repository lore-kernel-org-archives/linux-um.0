Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTzTE-00043n-CG for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 01:45:36 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BTzTB-0006vD-Ie for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 01:45:33 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] RE: NX inside UML - WAS: Re: Intelpitchespocket-size
	'personal server'
In-Reply-To: <1085784625.18033.67.camel@kira.himalaya.homeip.net>
Message-ID: <Pine.LNX.4.44.0405291044100.9729-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 29 May 2004 10:45:31 +0200 (CEST)
To: Ulf Bartelt <ulf.bartelt@web.de>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 29 May 2004, Ulf Bartelt wrote:

> the last crash i had was a suddnely terminating uml process ( just
> falling down to the host prompt without any error message and i am not
> good runtime-debugger :-( ) when i tried to compress multiple copies of
> linux-2.4.24 sources with all compression metods e2compr (see
> e2compr.sourceforge.net) offers in parallel...
> 
> there i really dont know who is to blame.... uml or e2compr?

uml, unless you pushed the uml guest too far in memory usage..

no applications should be able to terminate the uml, but if you push a 
Linux system too far in memory usage bad things will often happen..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
