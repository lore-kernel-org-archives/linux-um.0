Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8MAu-0004Ua-5l for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 08:33:16 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B8MAt-0000lr-Hj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 08:33:15 -0800
Message-Id: <200403301709.i2UH91Ll003143@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] skas understanding 
In-Reply-To: Your message of "Tue, 30 Mar 2004 13:23:38 +0200."
	<406958BA.7080109@epfl.ch> 
References: <406958BA.7080109@epfl.ch> 
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
Date: Tue, 30 Mar 2004 12:09:01 -0500
To: Nicolas Blanc <nicolas.blanc@epfl.ch>
Cc: user-mode-linux-devel@lists.sourceforge.net

nicolas.blanc@epfl.ch said:
> I don't understand the purpose of using anonymous mmap.

If you want a random piece of memory, it needs to be anonymous.

> 2) capture_signal_stack() : what is it for ?

It's broken and is going to change, but it grabs a host signal frame so it
can later copy it, with modifications, to its own processes stacks when they
receive signals.

> 3) Where is the kernel thread? 

start_uml_skas, it spends most of its time in the various invocations of
userspace().

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
