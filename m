Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh7b-0007fJ-CR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:07 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh7a-0000sa-JY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:06 -0800
Message-Id: <200401060258.i062wWFI023087@ccure.user-mode-linux.org>
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems) 
In-Reply-To: Your message of "Tue, 30 Dec 2003 10:43:30 PST."
	<20031230184330.GD1365@alcor.net> 
References: <20031220011323.GW18100@alcor.net>
	<20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net> 
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
Date: Mon, 05 Jan 2004 21:58:32 -0500
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

mdz@debian.org said:
> It turns out that this problem seems to be due to compiler
> incompatibility. UML had been built with gcc 2.95 due to old breakage,
> and when built with gcc 3.3 (as glibc is), everything starts working
> again.  My suspicion is that this is due to certain recent changes in
> pthreads.

Is it your opinion that there's no problem in UML itself?  Having a field
in the sigcontext getting magically munged is somewhat worrying.  I'd be 
happier knowing what exactly was happening so I can be sure this wasn't
exposing some subtle UML bug.

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
