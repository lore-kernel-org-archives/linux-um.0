Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6gaL-000184-0b for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 19:28:53 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C6gaH-0000Mg-Lh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 19:28:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040913033239.GA13207@ccure.user-mode-linux.org>
References: <20040912182629.3FEC49F37@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912182629.3FEC49F37@zion.localdomain>
Subject: [uml-devel] Re: [patch 2/2] add-SIGPROF-get-set_signals
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
Date: Sun, 12 Sep 2004 23:32:39 -0400
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Sep 12, 2004 at 08:26:29PM +0200, blaisorblade_spam@yahoo.it wrote:
>  {
>  	sigset_t mask;
> +	sigset_t old_mask;
>  	int ret;

Weren't you just complaining about stack consumption?  Do you know how
big a sigset_t is?

	(gdb) p sizeof(sigset_t)
	$1 = 128

I went to a reasonable amount of trouble to get that function to only
use one sigset_t and now you are proposing to add the old one back.  

Fix the patch and I'll put it in.

Also, if you're going to fix something, send a patch which does
nothing but make the fix, and save whatever cleanups you want to make
for a differet patch.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
