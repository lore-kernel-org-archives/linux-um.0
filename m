Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoQ4u-00007K-Hl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:49:44 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EoQ4r-0001sY-5W
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:49:44 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 (almost) works on amd64?
References: <200504181134.53390.markc@renta.net>
	<200512191723.19829.blaisorblade@yahoo.it>
	<1135017662.15991.136.camel@ant.internal>
In-Reply-To: <1135017662.15991.136.camel@ant.internal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191949.26913.blaisorblade@yahoo.it>
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
Date: Mon, 19 Dec 2005 19:49:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Monday 19 December 2005 19:41, Antoine Martin wrote:
> > And you saying "yes it works, I know this".
>
> I can't remember! And I thought only my short term memory was bad... ;)
>
> > SKAS64 support is implemented in the SKAS patch, but IIRC not in the
> > guest kernel - there are just a few things to fix up (for instance
> > using /proc/mm64), but I gave up as I hadn't found a solution to
> > SKAS32-on-64 problems, and the changes were boring to do, and impossible
> > to get right without a testing possibility.
>
> I suppose this isn't something I can help with?

I have the hardware, but I should go back coding on this.

Given that we have _always_ some urgent bug to diagnose, and that I already 
have my toy project (finishing and getting merged Ye Olde VMe Patche from 
Ingo Molnar)... it takes time.

Especially, I spend lots of time with emails - more than coding. So I'll go 
back there.

> That's a shame because I get the impression that skas3 is still much
> faster than skas0... no hard figures though.

> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
