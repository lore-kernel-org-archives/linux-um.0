Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfePW-0001B2-Ep for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 04:09:42 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AfePW-0006HT-3C for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 04:09:42 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] 2.6-specific UML patches (modules, modversions,
	various other stuff)
Message-ID: <20040111121017.GA17405@elte.hu>
References: <200401061921.00054.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401061921.00054.blaisorblade_spam@yahoo.it>
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
Date: Sun, 11 Jan 2004 13:10:17 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> There you will find a number of patches for UML 2.6. Some are mine and
> some come from Ingo and M A Young; I've included everything Ingo
> posted minus the speedup - breakage for 2.4 host. That is,
> MM_COPY_SEGMENTS is still called by UML but if the host is a 2.6 that
> is a no-op.

i'd suggest to skip my speedup altogether, skas4 ought to make it
obsolete.

i think it still makes sense to keep host-skas3 working in the 2.6 combo
patch until Jeff releases skas4 - the positive performance impact from
the host-skas concept is significant and the difference between skas3
and skas4 should not affect performance much, it's 'just' a (much)
cleaner interface.

	Ingo


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
