Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVG0B-00086i-OI
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 12:04:35 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AVG09-0000HQ-TK
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 12:04:34 -0800
Message-Id: <200312132019.hBDKJ8rL002905@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sat, 13 Dec 2003 18:28:03 +0100."
             <200312131828.03645.blaisorblade_spam@yahoo.it> 
References: <200312131828.03645.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
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
Date: Sat, 13 Dec 2003 15:19:07 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> 1) user_ksyms.c bundles a copy of the EXPORT_SYMBOL definition, but
> it's  outdated; I've inserted the new one(with appropriate changes,
> i.e.  s/CONFIG_/UML_CONFIG/) and it works. This is attached. 

Yeah, this is nasty, but I couldn't think of any way of handling this without
just copying stuff.

> 2) then, the UML build system is broken for USER_OBJS.

This is separate from the module problem.  It still needs fixing though.

> Instead of specifying the rule each time, wouldn't it be good
> something  such(in pseudo-code, I know there is only foreach in
> make-language)?
>
> for i in USER_OBJS; do
>   CFLAGS_$i+=USER_CFLAGS done 

It would be nice just to have something in one Makefile, like arch/um/Makefile,
which makes this work.  I haven't looked at whether this is possible.

> And for this, I cannot help because I've not enough  experience with
> link scripts(I've been able to learn the syntax, but I don't  know the
> reason why some section missing in the i386 appear in the UML  script;
> some are from libc, but I don't know which ones).

The ones you deleted are all kernel sections.

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
