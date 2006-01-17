Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eyrag-0000RM-5w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 06:13:42 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eyraf-0003b8-Ib
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 06:13:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
References: <20060116171447.GA15932@suse.de>
	<200601170222.59415.blaisorblade@yahoo.it>
	<20060117034504.GG17171@ccure.user-mode-linux.org>
In-Reply-To: <20060117034504.GG17171@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171513.39404.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 15:13:38 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Olaf Hering <olh@suse.de>

On Tuesday 17 January 2006 04:45, Jeff Dike wrote:
> On Tue, Jan 17, 2006 at 02:22:59AM +0100, Blaisorblade wrote:
> > On Monday 16 January 2006 18:14, Olaf Hering wrote:
> > > It picks up the libc headers instead of the 2.6.15 ones.
> >
> > Yep, that's correct, the bug is that shouldn't be using CONFIG_NR_CPUS.

> No, I just fixed this.  The bug is that chan_user.c includes kern_util.h,
> which is a kernel-only header.
Good thing.
> I made a bunch of similar changes today 
> (os.h also included kern_util.h!).

In that case, if it's kern-only, it should go into asm-um. Not in the current 
form, hopefully (you agree it's a mess, right? We just don't have time and 
patience to clean it right now).

> Maybe we don't need idle_threads there anyway, but that's a separate issue.

Yep, I fixed it this way. idle_threads was moved to asm/smp.h and it was 
included in files needing it.

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
