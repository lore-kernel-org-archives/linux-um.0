Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNE7-00011p-Cd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 16:00:31 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzNE5-0003Ew-SP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 16:00:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Needed arch_copy_tls? Not done by dup_task_struct?
References: <200601182053.31322.blaisorblade@yahoo.it>
	<20060118233846.GA5534@ccure.user-mode-linux.org>
In-Reply-To: <20060118233846.GA5534@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190100.26560.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 01:00:26 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 19 January 2006 00:38, Jeff Dike wrote:
> On Wed, Jan 18, 2006 at 08:53:29PM +0100, Blaisorblade wrote:
> > I looked at my patch's comment and noticed that arch_copy_tls, your
> > introduction, shouldn't indeed be needed, because dup_task_struct should
> > do that (it copies the whole task_struct, and it seems that arch_thread
> > is included in that blob rather than pointed too).
> >
> > I'm fairly puzzled at that. Have you any idea on this?
>
> I wondered about that, too, but hadn't bothered looking into it yet.  I'm
> suspicious that we initialize p.thread with INIT_THREAD, which would
> obviously wipe it out.

> > Also, since you have a good test FS (Fedora), can I send you the updated
> > versions I put out / can you test them? My Sarge isn't good any more,
> > likely because glibc was updated by apt-get, and it works well with the
> > LDT fallback.

> I have - they are on my patches page.  I added back the
> user_desc -> modify_ldt_t thing because I don't have a user_desc here.

I'm fixing this by copying the structure definition into sysdep/tls.h header 
files with a different name and using that one in os-Linux/tls.c.

> Other than that (and the O_FORCE succeeded message), it seems to be working
> fine.

> > I've just uploaded 2.6.15-bs1-tls for people to test.

> What I grabbed is what was there this morning.  If you changed anything
> significant, let me know, and I'll pull again.
I'll notify you when needed.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
