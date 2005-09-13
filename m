Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFE0W-0000Yv-6B	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 09:51:44 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFE0U-0001Mn-VB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 09:51:44 -0700
Message-ID: <43270396.5050102@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SYSEMU getting merged - but I'm in doubt
References: <200509041702.18506.blaisorblade@yahoo.it>
	<20050906161032.GA6157@ccure.user-mode-linux.org>
In-Reply-To: <20050906161032.GA6157@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 13 Sep 2005 18:51:34 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, "Charles P. Wright" <cwright@cs.sunysb.edu>

Jeff Dike wrote:
> On Sun, Sep 04, 2005 at 05:02:18PM +0200, Blaisorblade wrote:
> 
>>Now, the point is: should I ask Linus to drop it for now, clean the 
>>interface, and resend the cleaned up one, with different ptrace call codes?
> 
> 
> I would be tempted to leave it in and fix it before 2.6.14.  We need different
> ptrace codes so that UML knows how to switch interception types, I take it?
> 
> UML is the only user, so there aren't really any compatibility issues.
> 
> 
>>On the host side, instead, supporting both the broken API and the new one is 
>>more difficult.
> 
> 
> Yeah, and it shouldn't be done.  This is one reason I'd like to use the same
> ptrace codes - it doesn't leave a hole in the codes that says there was a 
> broken ABI there once.
> 
> 
>>What's your opinion on this? The options are:
>>1) merge it as-is
>>2) take it back for now, fix it and merge it for 2.6.15.
> 
> 
> Merge as-is, fix it before 2.6.13, and you get the same thing, except
> a release earlier.  I think this shouldn't be a problem, as after the
> floodgates close, you still get to fix things you merged early.  This
> came about as a result of feedback received because after it went into
> -mm, and it seems to me that this is a legitimate change for 2.6.14.
> 
> 
>>And then
>>
>>2a) drop the trick, and avoid changing ptrace call numbers. Old UMLs
>>will run fast, but crash with /proc/sysemu (only root-accessible).
> 
> 
> We should drop /proc/sysemu, if it's there at all, since it's only for
> debugging sysemu, and maintain it as a private patch.  So this doesn't
> seem like much of an issue.
> 
> 				Jeff
It would be enough to make /proc/sysemu readonly.
But we need to change check_sysemu(). The current implementation will work
with the old API only.

	Bodo


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
