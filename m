Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijp6o-0007Kf-SI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 21:41:46 -0700
Received: from qb-out-0506.google.com ([72.14.204.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ijp6i-0000Yp-Km
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 21:41:43 -0700
Received: by qb-out-0506.google.com with SMTP id c8so964728qbc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Oct 2007 21:41:39 -0700 (PDT)
Date: Mon, 22 Oct 2007 12:37:46 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071022043746.GF2998@hacking>
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071021154346.GW8181@ftp.linux.org.uk>
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

On Sun, Oct 21, 2007 at 04:43:46PM +0100, Al Viro wrote:
>On Sun, Oct 21, 2007 at 09:20:32PM +0800, WANG Cong wrote:
>> On Sun, Oct 21, 2007 at 09:08:48AM -0400, Jeff Dike wrote:
>> >On Sun, Oct 21, 2007 at 07:48:54PM +0800, WANG Cong wrote:
>> >> UML still doesn't build on 2.6.23-git16.
>> >> 
>> >> Gcc threw out many errors, I put them in the web:
>> >> 	http://wangcong.org/down/errors.txt
>> >
>> >Looks like either you need to run mrproper and try again, or maybe
>> >fallout from the x86 merge, with include/asm-um/arch pointing to
>> >include/asm-i386 instead of include/asm-x86.  Although I though Al had
>> >UML building in the presence of the x86 merge.
>> >
>> 
>> Hi, Jeff!
>> 
>> I have tried `make mrproper' before `make ARCH=um', but it still
>> failed. ;(
>
>Fallout continues; I've got a preliminary patch for it.  Basically, we
>need to stop doing -U__i386__ et.al.
>

Hi, Al.

I applied your patch and recompiled the kernel. But it failed again.
;(

Regards.

WANG Cong


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
