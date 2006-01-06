Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuuId-0007yM-A8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 08:18:43 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EuuIb-0006aE-NB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 08:18:43 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20060106161831.GH12131@stusta.de>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<20060104152433.7304ec75.akpm@osdl.org>
	<20060105022129.GA13183@ccure.user-mode-linux.org>
	<20060106124438.GB12131@stusta.de>
	<20060106163948.GA4340@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106163948.GA4340@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [2.6 patch] UML - Prevent MODE_SKAS=n and MODE_TT=n
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
Date: Fri, 6 Jan 2006 17:18:31 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 06, 2006 at 11:39:48AM -0500, Jeff Dike wrote:
> On Fri, Jan 06, 2006 at 01:44:38PM +0100, Adrian Bunk wrote:
> > If MODE_TT=n, MODE_SKAS must be y.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Great.  Now, how do you simultaneously implement 
> 	If MODE_SKAS=n, MODE_TT must be y.

That is already implemented in my patch:

MODE_TT=n forces MODE_SKAS=y.
MODE_TT=y allows any setting of MODE_SKAS.

MODE_SKAS=n is therefore impossible if MODE_TT=n.

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
