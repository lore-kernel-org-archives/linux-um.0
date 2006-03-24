Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMadr-0004ue-52 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 16:59:03 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMadp-0006vQ-FD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 16:59:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<20060323235044.GA7273@ccure.user-mode-linux.org>
	<20060324004052.GA1897@knob.reflex>
In-Reply-To: <20060324004052.GA1897@knob.reflex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240156.36646.blaisorblade@yahoo.it>
Subject: [uml-devel] (implementation idea) Re: uml and nonstandard memory
	splits?
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
Date: Fri, 24 Mar 2006 01:56:32 +0100
To: user-mode-linux-user@lists.sourceforge.net
Cc: Jason Lunz <lunz@falooley.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Friday 24 March 2006 01:40, Jason Lunz wrote:
> On Thu, Mar 23, 2006 at 06:50:44PM -0500, Jeff Dike wrote:
> > You can make some progress by disabling CONFIG_MODE_TT - that will
> > cause UML to load at a normal address rather than the 0xa0000000 that
> > CONFIG_MODE_TT will force.
> >
> > That should get you to the point of trying to run init.
> >
> > Since you have skas3, my guess is that UML will be fine at that point.
> >
> > On a non-skas3 host, it will run in skas0 mode, and will expect to be
> > able to map a couple of pages at the top of the process address space
> > (hardcoded to 0xbfffe000 and 0xbffff000).  These offsets would need to
> > be calculated based on the host's split in order for skas0 to work.
>
> So I guess getting a 2.4 uml to work on any split other than 1G/3G is
> pretty unlikely. Oh well, I already knew 2.4 was on its way out. So this
> might be the thing that really forces me to use 2.6.

No, that's wrong - what David Lang described:
> I don't know about other non-standard memory configs, but there is an 
> explicit config option when compiling a uml kernel to support the 2G/2G 
> memory split.
was also supported by UML 2.4. I think unusual split and the UML trivial 
support for that were born and used when 4G/4G didn't exist yet (or maybe not 
even highmem?).

> 2.4 support aside, my aim is to have a single uml binary that will work
> on arbitrary host kernels. How difficult will it be to implement support
> for dynamic offsets for these pages in skas0?

I don't think it's easy - however, it can be done. Below my idea - Jeff, 
please comment on this

In assembly.
It goes like this:

call label /*this is coded like a relative jump, i.e. call +1*/
label: pop $eax /*we got the saved EIP*/

/* Now we can round EIP and subtract an offset to calculate the data page 
location.
*/

The only problem is that it must be done in assembly and at times this must be 
redone (we don't have enough registers to save the value across a 6-param 
syscall), and touching this code is a bit dangerous.

> Jason

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
