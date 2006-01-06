Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Euqxd-000412-KU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 04:44:49 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Euqxc-0006fW-5g
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 04:44:49 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20060106124438.GB12131@stusta.de>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<20060104152433.7304ec75.akpm@osdl.org>
	<20060105022129.GA13183@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105022129.GA13183@ccure.user-mode-linux.org>
Subject: [uml-devel] [2.6 patch] UML - Prevent MODE_SKAS=n and MODE_TT=n
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
Date: Fri, 6 Jan 2006 13:44:38 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 04, 2006 at 09:21:29PM -0500, Jeff Dike wrote:
> On Wed, Jan 04, 2006 at 03:24:33PM -0800, Andrew Morton wrote:
> > Jeff Dike <jdike@addtoit.com> wrote:
> > >
> > > Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
> > Is there no sane way to prevent this situation within Kconfig?
> 
> I tried.  The best I managed was to get *config to moan about circular
> dependencies.

The patch below implements this in Kconfig.

> 				Jeff

cu
Adrian


<--  snip  -->


If MODE_TT=n, MODE_SKAS must be y.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-git/arch/um/Kconfig.old	2006-01-06 13:41:02.000000000 +0100
+++ linux-git/arch/um/Kconfig	2006-01-06 13:41:14.000000000 +0100
@@ -83,7 +83,7 @@
         of physical memory.
 
 config MODE_SKAS
-	bool "Separate Kernel Address Space support"
+	bool "Separate Kernel Address Space support" if MODE_TT
 	default y
 	help
 	This option controls whether skas (separate kernel address space)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
