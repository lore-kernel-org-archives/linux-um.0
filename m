Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZy0Y-0001ZK-22
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 11:52:26 -0800
Received: from smtp1.clear.net.nz ([203.97.33.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZy0X-0008G2-LZ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 11:52:25 -0800
Received: from 218-101-109-169.dialup.clear.net.nz
 (218-101-109-169.dialup.clear.net.nz [218.101.109.169])
 by smtp1.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0HQI006F8PVA3L@smtp1.clear.net.nz> for
 user-mode-linux-devel@lists.sourceforge.net; Sat,
 27 Dec 2003 08:52:24 +1300 (NZDT)
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [uml-devel] UML build system: patch ready
In-reply-to: <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
Message-id: <1072468270.6872.13.camel@laptop-linux>
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200312241943.37474.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 27 Dec 2003 08:51:10 +1300
To: Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

Hi.

On Fri, 2003-12-26 at 21:12, Jeff Chua wrote:

[...]


> arch/um/sys-i386/bugs.c ...
> 	//line 110
> 	struct modify_ldt_ldt_s ldt;
> 
> 	//line 117
> 	err = modify_ldt(1, &ldt, sizeof(ldt));
> 
> 
> It looks that modify_ldt_ldt_s is not defined anywhere and modify_ldt()
> cannot be found.

If you can get this sorted out (and tell me how), I may be able to get
software suspend [a bit closer to] working under UML. The lack of
support for modifying ldts was where I blocked when I briefly looked at
it a while ago.

Regards,

Nigel

-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
