Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IEoWk-0004al-Kj for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jul 2007 08:48:22 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5] helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IEoWk-0003bX-2u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Jul 2007 08:48:22 -0700
Date: Sat, 28 Jul 2007 17:47:05 +0200
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20070728154705.GB30976@stusta.de>
References: <20061212233533.GB28443@stusta.de>
	<20061213041837.GA8825@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061213041837.GA8825@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] RFC: UML: remove MODE_TT?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 12, 2006 at 11:18:37PM -0500, Jeff Dike wrote:
> On Wed, Dec 13, 2006 at 12:35:33AM +0100, Adrian Bunk wrote:
> > MODE_TT is both marked as deprecated and marked as BROKEN.
> > 
> > Would a patch to remove MODE_TT, always enable MODE_SKAS, and doing all 
> > possible cleanups after this be accepted?
> 
> Thanks, but not yet.
> 
> I've got that queued up in my tree now, waiting for SMP to work.  SMP is 
> the one remaining justification for TT mode, so I'll get that in, then remove
> MODE_TT and do the associated cleanups.

MODE_TT is still marked as broken and still not compiling...

Will anyone fix it or can it finally be removed?

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
