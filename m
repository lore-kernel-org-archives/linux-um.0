Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Egmuv-0004KP-N2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 09:35:53 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Egmus-0005nt-8g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Nov 2005 09:35:53 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] NPTL support
Message-ID: <20051128182747.GA14934@ccure.user-mode-linux.org>
References: <29D15BBCA340DA4D8146D38B4924FC7A03378F16@zcarhxm0.corp.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A03378F16@zcarhxm0.corp.nortel.com>
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
Date: Mon, 28 Nov 2005 13:27:47 -0500
To: Majid Salame <msalame@nortel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 28, 2005 at 10:01:25AM -0500, Majid Salame wrote:
>  Is NPTL supported and working? Are there separate patches to be applied
> against 2.6.10 kernel?

My current patchset, against 2.5.15-rc1, is running current Debian and FC4
filesystems without any apparent problems.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
