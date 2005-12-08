Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkBSp-0000ON-9v for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 18:24:55 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EkBSp-0002DR-1X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 18:24:55 -0800
Subject: Re: [uml-devel] testing of 2.6.15-rc1+patches and 2.6.15-rc3 x86
	guests on amd64 host
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20051130040114.GB21268@ccure.user-mode-linux.org>
References: <1133307314.13162.50.camel@localhost.localdomain>
	<20051130040114.GB21268@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1134008686.32598.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 08 Dec 2005 02:24:45 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 2005-11-29 at 23:01 -0500, Jeff Dike wrote:
> On Tue, Nov 29, 2005 at 11:35:14PM +0000, Antoine Martin wrote:
> > [42951313.910000] Kernel panic - not syncing: Kernel mode signal 7
> 
> Did your /tmp fill up?
> 
> > * Now, with 2.6.15-rc3 it does not boot:
> > * or in skas0 mode:
> > Checking PROT_EXEC mmap in /tmp...OK
> > Checking for the skas3 patch in the host:
> >   - /proc/mm...not found
> >   - PTRACE_FAULTINFO...not found
> >   - PTRACE_LDT...not found
> > UML running in SKAS0 mode
> > (then it exits)
> 
> With SIGBUS happening, I'd check that you've got some space in /tmp.
DOH. There were a few temp files in there, and the guest ran out of
space. I didn't consider this because the guest also had a swap disk
file and seemed to crash when only consuming a small amount of swap...
wrong track.
I now mount /tmp in the chroot as tmpfs with a 20MB extra to spare for
tmp files...

Thanks
Antoine
> 
> FWIW, I have rc3 running happily here on x86_64.
> 
> 				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
