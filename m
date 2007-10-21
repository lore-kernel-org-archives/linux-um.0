Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijah9-0003AE-W5 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 06:18:20 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ijah8-0004lM-BA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 06:18:19 -0700
Date: Sun, 21 Oct 2007 09:08:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071021130848.GA4621@c2.user-mode-linux.org>
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071021114854.GF2455@hacking>
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
Cc: Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 21, 2007 at 07:48:54PM +0800, WANG Cong wrote:
> UML still doesn't build on 2.6.23-git16.
> 
> Gcc threw out many errors, I put them in the web:
> 	http://wangcong.org/down/errors.txt

Looks like either you need to run mrproper and try again, or maybe
fallout from the x86 merge, with include/asm-um/arch pointing to
include/asm-i386 instead of include/asm-x86.  Although I though Al had
UML building in the presence of the x86 merge.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
