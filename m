Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar7Rj-0006Nt-82
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 19:23:23 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ar7Qp-0003VK-C0
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 19:22:27 -0800
Message-Id: <200402120349.i1C3nFip009121@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards? 
In-Reply-To: Your message of "Thu, 12 Feb 2004 12:17:25 +1030."
             <20040212014725.GV4203@erizo.shearer.org> 
References: <20040206003759.GY4203@erizo.shearer.org> <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org>  <20040212014725.GV4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 11 Feb 2004 22:49:15 -0500
To: Dan Shearer <dan@shearer.org>
Cc: Cameron Patrick <cameron@patrick.wattle.id.au>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, miquels@cistron.nl

dan@shearer.org said:
> Could you tell us what the rules are?

The rule is - if it can be done in userspace, it is.  And if it can't be done
in userspace, you implement as little as possible in the kernel, and export
an interface that lets the rest be done in userspace.  C-A-D is a good example -
you need to have the basic handler in the kernel, but the actual reaction to
it is in init, and specified by inittab.

So, the stuff that I'm willing to stick in the mconsole driver are things like
diagnosing a sick UML (where you may not be able to start processes - mconsole
proc, which barely passed muster with Al Viro) and pulling hardware in and
out.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
