Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjZMP-00086D-NX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 04:52:53 -0700
Received: from ag-out-0708.google.com ([72.14.246.244])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IjZMM-0005xs-1Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 04:52:49 -0700
Received: by ag-out-0708.google.com with SMTP id 23so1819842agd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Oct 2007 04:52:43 -0700 (PDT)
Date: Sun, 21 Oct 2007 19:48:54 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071021114854.GF2455@hacking>
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y7dyhv2u.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in	2.6.23-final.
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Nix <nix@esperi.org.uk>
Cc: Rob Landley <rob@landley.net>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 20, 2007 at 12:41:29PM +0100, Nix wrote:
>On 20 Oct 2007, Paolo Giarrusso told this:
>> Guess most people are not using SMP right now, and that the error disappears 
>> without that setting
>
>It doesn't. It fails with non-SMP as well.
>

UML still doesn't build on 2.6.23-git16.

Gcc threw out many errors, I put them in the web:
	http://wangcong.org/down/errors.txt

My .config is located at:
	http://wangcong.org/down/uml_config.bak

Or I missed something?

Regards.

-- 
May the Source Be With You.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
