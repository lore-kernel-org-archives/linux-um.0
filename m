Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzCyx-0000dx-5h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 05:04:11 -0800
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzCyv-0000ta-SG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 05:04:11 -0800
From: Olaf Hering <olh@suse.de>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
Message-ID: <20060118130403.GA21457@suse.de>
References: <20060116171447.GA15932@suse.de>
	<200601170222.59415.blaisorblade@yahoo.it>
	<20060117202411.GA27124@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060117202411.GA27124@suse.de>
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
Date: Wed, 18 Jan 2006 14:04:04 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

 On Tue, Jan 17, Olaf Hering wrote:

> arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
> arch/um/os-Linux/sys-i386/registers.c:134: error: 'JB_PC' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:134: error: (Each undeclared identifier is reported only once
> arch/um/os-Linux/sys-i386/registers.c:134: error: for each function it appears in.)
> arch/um/os-Linux/sys-i386/registers.c:135: error: 'JB_SP' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:136: error: 'JB_BP' undeclared (first use in this function)

These definitions are gone from glibc 2.4, has to be fixed in uml.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
