Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNHy-00017R-Jq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 16:04:30 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzNHx-00055q-3K
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 16:04:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
References: <20060116171447.GA15932@suse.de>
	<200601181743.04311.blaisorblade@yahoo.it>
	<20060119000851.GB5534@ccure.user-mode-linux.org>
In-Reply-To: <20060119000851.GB5534@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190104.27255.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 01:04:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Olaf Hering <olh@suse.de>

On Thursday 19 January 2006 01:08, Jeff Dike wrote:
> On Wed, Jan 18, 2006 at 05:42:56PM +0100, Blaisorblade wrote:
> > What about this? Inserting an asm volatile clobbering all unsaved
> > registers (what I thought for long time)?

> The gcc doc is somewhat confusing.  I read your description as saying
> that locals may be totally smashed to random numbers (and the first
> sentence in the gcc description implies that as well).

I agree with that.

> However, the 
> example they give is a pathological case where a local may have one of
> two (well-defined) values, and it's not defined which of those two
> well-defined values it will end up with.

It's confusing. Standard conformance page says that:

       * On some rare x86 targets, `setjmp' doesn't save the registers
          in all circumstances.  In those cases, GCC doesn't allocate
          any variables in registers unless they are marked `register'.
But we know it's totally wrong.

The example under "Incompatibilities of GCC" is what you say. However, it's 
just because it's a little example. If the var is placed in a register, and 
after a lot you longjmp there, that register is totally smashed.

> > Or taking the libc implementation and suiting
> > it for our use, solving the above problem?

> Yuck.  But how big is it?

Don't know... I suggested this mainly for the volatile vars problem, more than 
for the "access stack" problem.

> Another possibility is to do the magic wakeup thing we do with
> mconsole stack, and have it tell us what it registers are.  Not sure
> if that's any better.

You mean mconsole_kern.c:do_stack()? Hmm, ugly too, but more reliable, and not 
relying on glibc at least.
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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
