Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW9JH-00019s-Lx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:19 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FW9JH-0007eo-4i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:49:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml_utilities-20060323 fails to build on alpha
References: <20060409180709.GA20099@inferi.kami.home>
In-Reply-To: <20060409180709.GA20099@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604191152.06268.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 11:52:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia Dongili <malattia@linux.it>

On Sunday 09 April 2006 20:07, Mattia Dongili wrote:
> Hello,
>
> I hear you say "who cares?" :)
> Well, such failure uncovers a small bug on 64bit arches with __u64 not
> defined as unsigned long long (oh, that "who cares" again :)).

No, you're right, good catch.

Systems using linux-libc-headers (i.e. RedHat and Fedora to my knowledge) 
exhibit this, and I've applied a similar patch to Uml itself for a Fedora 
user, but forgot it for uml_utilities. (I had "fixed" both instances of the 
COW code together).

Will apply the patch ASAP (at least next week) and release the resulting 
thing.

> cow.c: At top level:
> cow.c:271: error: conflicting types for 'read_cow_header'
> cow.h:25: error: previous declaration of 'read_cow_header' was here
>
> the attached patch fixes it.
>
> Thanks

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
