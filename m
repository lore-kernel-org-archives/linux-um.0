Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Axv2K-0004bW-4q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 13:33:16 -0800
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AxuqN-0003i2-Iv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 13:20:55 -0800
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] Re: [uml-user] UNIX socket networking
References: <200402290158.54770.jdizzl@xs4all.nl>
	<20040229120513.934193BCB7@home.petschge.de>
	<200402291720.12216.blaisorblade_spam@yahoo.it>
	<200402291813.09174.petschge@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20040301201438.DE4903BCB7@home.petschge.de>
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
Date: Mon, 01 Mar 2004 21:14:38 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Hi all,

>> Problem 1.) How do I shutdown a kernel thread when the uml goes
>> down? At the moment my patched kernle gets stuck with 100% CPU
>> usage when I trie to shut down the uml kernel.
Ok uml_exitcall fixed this problem.

>> Problem 2.) How can I make sure that my kernel thread I startet
>> after the networking stuff is inited? At the moment I start the
>> kernel thread with a __initcall and just do a sleep(30) in the
>> thread.
> I didn't know about late_initcall, but it sounds promising.
And it works too.


>> Problem 3.) I can only create sockets in the "anonymous" namespace.
>> The normal namespace gives me some error which I don't rememeber
>> right now but I could find out what th errorcode was.
Well bind is returning -2 which seams to be -ENOENT. Does somebody know why 
this happens?

>> I guess the "normal" namespace is PF_LOCAL.
>IIRC yes.
I use PF_UNIX in the code. But that should be the same as PF_LOCAL.

> There has been a lot of request for a such feature, so I would like
> if you can post it here or rather on uml-devel (especially to avoid
> anyone trying it without specific knowledge), even if it is not
> complete. So we could better help you. Also, state whether it is onto
> 2.4 or 2.6.
At the moment I am working on 2.6.0-test11


Thanks for your help,
Patrick "Petschge" Kilian



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
