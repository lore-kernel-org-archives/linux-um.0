Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijr0I-0001O5-0A for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 23:43:11 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user26962)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ijr0G-0001ga-9W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 23:43:09 -0700
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking>
From: Nix <nix@esperi.org.uk>
Date: Mon, 22 Oct 2007 07:42:33 +0100
In-Reply-To: <20071022061245.GG2998@hacking> (WANG Cong's message of "Mon,
	22 Oct 2007 14:12:46 +0800")
Message-ID: <87d4v7fy5i.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>

On 22 Oct 2007, WANG Cong uttered the following:
> I build UML for non-SMP x86. But I don't know about UML_NET_VDE. ;(
>
> Errors threw out by gcc (too many) are put here:
> 	http://wangcong.org/down/errors.txt

It's hard to tell without LOCALE=C, but those are the sorts of results
I'd expect if you had run make {old,menu,x}config without specifying
ARCH=um, so you've configured for one architecture and are now trying
to build another.

Where is the include/asm symlink pointing to in your build tree?

(FWIW I get a coredump if I try to use the skas patch, but with noprocmm
UML in 2.6.23.1 builds and runs perfectly well on x86-32. I haven't
tried 2.6.23, but I see no reason why it should act any differently.)

-- 
`Some people don't think performance issues are "real bugs", and I think 
such people shouldn't be allowed to program.' --- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
