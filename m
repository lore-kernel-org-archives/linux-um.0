Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXsPU-0005xv-18
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 17:29:32 -0800
Received: from mta13.mail.adelphia.net ([68.168.78.44] helo=mta13.adelphia.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXsPT-0008RH-In
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 17:29:31 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031221012924.GI9354@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220171450.GB10692@ccure.user-mode-linux.org>
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
Date: Sat, 20 Dec 2003 17:29:24 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org

On Sat, Dec 20, 2003 at 12:14:50PM -0500, Jeff Dike wrote:

> The only thing that seemed remotely relevant is the unistd.h change, which
> fixes a bug in the case of an error in an internally called system call.
> You can try reverting that and see what happens.

FWIW, I tried reverting this and it made no difference.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
