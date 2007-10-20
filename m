Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjCiH-000173-BE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2007 04:41:53 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user29622)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IjCiE-0004qh-Nh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2007 04:41:53 -0700
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
From: Nix <nix@esperi.org.uk>
Date: Sat, 20 Oct 2007 12:41:29 +0100
In-Reply-To: <200710200252.37919.p.giarrusso@gmail.com> (Paolo Giarrusso's
	message of "Sat, 20 Oct 2007 02:52:30 +0200")
Message-ID: <87y7dyhv2u.fsf@hades.wkstn.nix>
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
To: Paolo Giarrusso <p.giarrusso@gmail.com>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On 20 Oct 2007, Paolo Giarrusso told this:
> Guess most people are not using SMP right now, and that the error disappears 
> without that setting

It doesn't. It fails with non-SMP as well.

Rob, your patch works for me. (Not that the reboot into 2.6.23.1 was
problem-free: iproute2-071016 fails to understand the `police' action
and also somehow fails to bring up networking well enough for me to
locally NFS-mount my home directories, where 070710 had no trouble.
More on that soon to the appropriate people as soon as I've diagnosed
it...)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
