Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW9JB-000194-Sm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:13 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FW9J9-0007OM-UT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] uml: problem with 2G/2G host address space
References: <20060409105755.GA24319@xs4all.nl>
	<20060409170111.GC2944@ccure.user-mode-linux.org>
In-Reply-To: <20060409170111.GC2944@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604191152.00990.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 11:52:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Joris van Rantwijk <jvrantwijk@xs4all.nl>

On Sunday 09 April 2006 19:01, Jeff Dike wrote:
> On Sun, Apr 09, 2006 at 12:57:55PM +0200, Joris van Rantwijk wrote:
> > It soon made sense to me that a 3G/1G configured UML would crash like
> > this, but I then found that UML 2.6.16.2 configured for 2G/2G crashed
> > in exactly the same way. I think this is due to the fact that STUB_CODE
> > and STUB_DATA are fixed at the 3G/1G settings. After changing these
> > settings, everything seems to work properly in 2G/2G mode.

> Your analysis is correct, and the patch is fine as far as it goes, but
> we were talking about this a week or so ago about detecting the host
> address space split at runtime.  There's a lot more potential
> flexibility there than just 3/1 and 2/2.

Jeff, for now please merge a band-aid patch (and also add an option to support 
1G/3G, while at it).

Delaying the band-aid only makes sense when you've got the proper fix reaching 
completion or when the band-aid is clearly an hack and hinders maintenability 
in a relevant way - we don't want to keep these configurations "unsupported".

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
