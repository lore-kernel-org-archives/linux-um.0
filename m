Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzmWf-0002lw-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 19:01:21 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzmWb-0000EL-Af
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 19:01:21 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] 2.6.16-rc1-um20060118 tls compile problem
In-Reply-To: <20060119041342.GA8265@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0601192143270.3892@sparrow>
References: <Pine.LNX.4.64.0601182042120.4057@sparrow>
	<20060119041342.GA8265@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Thu, 19 Jan 2006 22:00:13 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Good evening, Jeff,

On Wed, 18 Jan 2006, Jeff Dike wrote:

> On Wed, Jan 18, 2006 at 08:46:07PM -0500, William Stearns wrote:
>> arch/um/os-Linux/tls.c:48: error: syntax error before 'get_thread_area'
>> arch/um/os-Linux/tls.c:48: warning: type defaults to 'int' in declaration
>> of '_syscall1'
>
> Can you try this patch for this one?
>
> Index: linux-2.6.15/arch/um/os-Linux/tls.c
> ===================================================================
> --- linux-2.6.15.orig/arch/um/os-Linux/tls.c    2006-01-18 13:40:01.000000000 -0500
> +++ linux-2.6.15/arch/um/os-Linux/tls.c 2006-01-18 22:18:57.000000000 -0500
> @@ -1,5 +1,6 @@
> #include <errno.h>
> #include <sys/ptrace.h>
> +#include <linux/unistd.h>
> #include <asm/ldt.h>
> #include "uml-config.h"

 	That patch helped.

>> arch/um/os-Linux/tls.c:51: warning: 'struct modify_ldt_t' declared inside
>> parameter list
>> arch/um/os-Linux/tls.c:51: warning: its scope is only this definition or
>> declaration, which is probably not what you want
>
> For these, try backing out the user-desc patch.  You may one of those
> primitive beings who lacks a modify_ldt_t in your asm/ldt.h.

 	Actually I don't need to revert this one; after reverting the 
compile fails.  Leaving it in works.  The compile finishes.
 	Thanks again for your help, Jeff and Blaisor.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"Microsoft's biggest and most dangerous contribution to the
software industry may be the degree to which it has lowered user
expectations."
 	-- Esther Schindler, OS/2 Magazine
(Courtesy of Bob Tracy - TDS <rct@merkin.csap.af.mil>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
