Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh7w-0007g3-7E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:28 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh7u-0002Nn-Id
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:26 -0800
Message-Id: <200401060259.i062x3FI023132@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems 
In-Reply-To: Your message of "Sun, 28 Dec 2003 01:52:24 PST."
	<20031228095224.GM17472@alcor.net> 
References: <20031220011323.GW18100@alcor.net>
	<20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228095224.GM17472@alcor.net> 
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
Date: Mon, 05 Jan 2004 21:59:03 -0500
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

mdz@debian.org said:
> By the way, why is the test < 1 here, and < 0 in execute_syscall_skas?

No idea :-)

> Shouldn't they match? 

Yup.

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
