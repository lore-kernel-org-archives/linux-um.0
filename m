Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BF9qd-00048g-6u for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 03:48:27 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BF9qc-0004Bp-JO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 03:48:26 -0700
Message-ID: <004801c42533$94d567b0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<4077FDF9.7070707@upb.de>
	<20040410170707.GA6492@ccure.user-mode-linux.org>
	<224701c42280$f110e0f0$2000000a@schlepptopp>
	<000801c422e1$783f8030$1400a8c0@DAVIDVAIO>
	<c5ot4u$hj5$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Network lags
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
Date: Sun, 18 Apr 2004 12:54:53 +0200
To: user-mode-linux-user@lists.sourceforge.net, Matthew Bloch <matthew@bytemark.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

hey,
when the mlock patch doesn`t go into uml officially - why not updating it to the 
latest 2.4.x and 2.6.x uml and uploading it to the sourceforge patch section at
http://sourceforge.net/tracker/?group_id=429&atid=300429 and "maintaining" it
there?
so others could find it, download it, use it, give comments......

regards
roland




----- Original Message ----- 
From: "Matthew Bloch" <matthew@bytemark.co.uk>
To: <user-mode-linux-user@lists.sourceforge.net>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, April 16, 2004 5:12 PM
Subject: Re: [uml-user] Network lags


> David Cannings wrote:
> >>>Anyone else who's running lots of UMLs with interactive sessions may have
> >>>noticed the following symptoms which this patch cures:
> >>>
> >>>  * irregular ping times to UMLs-- huge delay for the first ping, a few
> >>>      normal, a couple of long delays etc.;
> > 
> > The huge delay is often related to ARP, a fundamental part of 802.3/true
> > ethernet.
> 
> Indeed, but when logging back on to an ssh session etc. it's very 
> irritating for customers to find their machine takes seconds to "wake 
> up" while the 2.4 kernel swaps stuff back in.
> 
> [snip]
> > The problem with "just activating that option" is that many people will do
> > it blindly, unaware of the serious implications it could have to their host.
> > Whilst mlocking an area of memory may not affect you now, or in the next ten
> > minutes, it could cause trouble in three weeks when you start doing
> > something on the host that is memory intensive.  In the last three years of
> > running a remote server I have only had to turn up on site to fix it twice.
> > Both were very silly things, one that I'd "just activated" to see what it
> > would do.  It cost me a rather expensive journey half way across the country
> > to fix.
> 
> Since writing that post back in October, we've deployed the mlock patch 
> across two rackfuls of hosts, and we've never had a host kernel "just 
> crash" (well we have, but that was down to something else <g>): longest 
> uptime on one group of our hosts is 100 days.  Yes it was experimental 
> but we did a bit of testing first.
> 
>  From this experience; I would disagree that using lots of mlocked 
> memory inherently destabilises the machine.  I'm sure it *can* but this 
> goes for a lot of things.
> 
> [snip]
> > The idea behind UML is to create a separate environment from the host,
> > constructing a UML kernel that can interfere so badly with the host is the
> > total opposite.
> 
> It's very easy for a UML kernel to trash the host, and I'm not sure 
> anyone knows what "the idea behind UML" is :-)
> 
> I can see Jeff's point about the mlock patch despite the fact that it 
> solved a major problem for us with deploying UML in a hosting 
> environment.  Jeff's proposed new memory management features will give 
> us more flexibility than my simple on/off mlock patch, and allows him to 
> wash his hands of these grubby management decisions.
> 
> cheerio,
> 
> -- 
> Matthew Bloch                             Bytemark Hosting
>                          http://www.bytemark-hosting.co.uk/
>                  phone UK: 0845 004 3 004 US: 1-877 BYTEMAR
>            Dedicated Linux hosts from 15ukp ($26) per month
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
