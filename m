Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FP4ia-0000dk-NH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Mar 2006 13:30:12 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FP4iX-0002tF-5Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Mar 2006 13:30:12 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: SMP skas requirements
References: <20060329043656.GA25520@ccure.user-mode-linux.org>
	<20060329123808.nlnz9h68pwg0s44s@www.scgiservices.com>
	<200603302304.00293.blaisorblade@yahoo.it>
In-Reply-To: <200603302304.00293.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603302330.00256.blaisorblade@yahoo.it>
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
Date: Thu, 30 Mar 2006 23:29:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <brocka@sterlingcgi.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 30 March 2006 23:03, Blaisorblade wrote:
> On Wednesday 29 March 2006 22:38, Anthony Brock wrote:
> > Quoting Jeff Dike <jdike@addtoit.com>:
> > > On Wed, Mar 29, 2006 at 12:40:00AM +0200, Blaisorblade wrote:
> > >> Finally, I'd like to get devshm merged if there aren't problems with
> > >> the code.

(Jeff wrote):
> > That one needs to check if /dev/shm is present, and fall back to /tmp
> > if not.

I'd add that it needs to retry even if the PROT_EXEC test fails:

*) if TMP, TEMP or TMPDIR are set, use that and fail if the check fails, 
abort, because the user wanted to use that but forgot to change permissions.

*) if instead we pick /dev/shm but it has not PROT_EXEC, we should switch 
to /tmp and fail only then.

> > Are you proposing that virtual servers automatically using /dev/shm if
> > available and only falling back to the $TMP variable and /tmp directory
> > if not? Or would this keep the use of $TMP if present and fall back to
> > /dev/shm followed by /tmp?

> By looking at:
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16/patches/devs
>hm

Sorry, forgot to finish. That patch keeps checking TMP,TMPDIR and TEMP (don't 
remember the order), but if none is set, it switches the default from /tmp 
to /dev/shm.
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
