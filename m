Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijqaz-0007Na-Q6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 23:17:01 -0700
Received: from ag-out-0708.google.com ([72.14.246.245])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ijqaw-0006B2-Al
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 23:17:01 -0700
Received: by ag-out-0708.google.com with SMTP id 23so2141046agd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Oct 2007 23:16:57 -0700 (PDT)
Date: Mon, 22 Oct 2007 14:12:46 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071022061245.GG2998@hacking>
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022052214.GY8181@ftp.linux.org.uk>
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
To: Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, WANG Cong <xiyou.wangcong@gmail.com>

On Mon, Oct 22, 2007 at 06:22:14AM +0100, Al Viro wrote:
>On Mon, Oct 22, 2007 at 12:37:46PM +0800, WANG Cong wrote:
>> >Fallout continues; I've got a preliminary patch for it.  Basically, we
>> >need to stop doing -U__i386__ et.al.
>> >
>> 
>> Hi, Al.
>> 
>> I applied your patch and recompiled the kernel. But it failed again.
>> ;(
>
>Details would be welcome...  Notes: SMP on UML is no more; UML_NET_VDE
>depends on having some userland library installed.  Aside of those two
>it ought to build.
>
>Build log on failing build would be nice, along with .config.

I build UML for non-SMP x86. But I don't know about UML_NET_VDE. ;(

Errors threw out by gcc (too many) are put here:
	http://wangcong.org/down/errors.txt

And my .config is located here:
	http://wangcong.org/down/dot_config

(Errors look like same as without your patch.)

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
