Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh7p-0007fe-0g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:21 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh7o-0000yB-CH
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:20 -0800
Message-Id: <200401060258.i062wsFI023112@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] can't set console on 2.6.0 
In-Reply-To: Your message of "Tue, 30 Dec 2003 00:41:16 +0800."
	<Pine.LNX.4.58.0312300035190.24938@silk.corp.fedex.com> 
References: <Pine.LNX.4.58.0312300035190.24938@silk.corp.fedex.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 05 Jan 2004 21:58:54 -0500
To: Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

jeff98@silk.corp.fedex.com said:
> On 2.6.0 uml, is there's a way to use the same screen to boot up uml
> without opening new xterm windows?  On 2.4.x, I can make it work with
> the following line ...
>
> 	linux ro con0=null,fd:2 con1=fd:0,fd:1 ubda=/tmp/disk1

I'm in the middle of updating 2.6 so it catches up with 2.4, so I suppose
you could try that when it's ready.  However, I don't think there have been
any changes in this area.  This should behave the same with 2.4 and 2.6.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
