Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dlkwz-0001jR-EG	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 02:58:17 -0700
Received: from fra-del-03.spheriq.net ([195.46.51.99])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1Dlkwv-0000gC-E2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 02:58:17 -0700
Received: from fra-out-01.spheriq.net (fra-out-01.spheriq.net [195.46.51.129])
	by fra-del-03.spheriq.net with ESMTP id j5O9w3me031032
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Jun 2005 09:58:03 GMT
Received: from fra-cus-01.spheriq.net (fra-cus-01.spheriq.net [195.46.51.37])
	by fra-out-01.spheriq.net with ESMTP id j5O9v4us021805
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Jun 2005 09:57:04 GMT
From: Alex LIU <alex.liu@st.com>
Subject: RE: [uml-devel] Question about the unexpected signal 11 when fork in
	UML-2.6.7 TT mode
Message-ID: <000301c578a3$2cc33480$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <200506211741.34136.blaisorblade@yahoo.it>
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
Date: Fri, 24 Jun 2005 17:57:45 +0800
Content-Transfer-Encoding: 8bit
To: 'Blaisorblade' <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

I just let the SIGSEVG go and return from the sleeping_process_signal function instead of tracer_panic and hanging the UML.
It seems ok. Is it dangerous? Thanks a lot!

Alex

-----Original Message-----
From: Blaisorblade [mailto:blaisorblade@yahoo.it] 
Sent: Tuesday, June 21, 2005 11:42 PM
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU
Subject: Re: [uml-devel] Question about the unexpected signal 11 when fork in UML-2.6.7 TT mode


On Tuesday 21 June 2005 12:05, Alex LIU wrote:
> Hi,all:
>
> When I fork() in UML TT mode,it always said "the sleeping process xxx 
> received unexpedted signal 11" and the UML hang...before fork I also 
> set the signal handler... My UML is 2.6.7 and I used TT mode.Thanks a 
> lot!

> Alex
Have you a good reason to use UML 2.6.7? We can't know by heart the list of 
all fixed bugs in previous UML releases, really, and you'll be doing yourself 
a favor by upgrading to 2.6.11-bs5 or 2.6.12 (which contains almost 
everything from -bs).

That said, you are talking about userspace code, right? It's anyway strange 
that your system boots but you can't write a simple code that fork()'s.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!". Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894) http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
