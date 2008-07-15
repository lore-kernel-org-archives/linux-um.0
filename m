Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KIpTm-0006gh-Oo for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 11:42:26 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KIpTl-0008VK-9X
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 11:42:26 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KIpTd-0006JH-Ps for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 18:42:17 +0000
Received: from c-67-160-201-246.hsd1.ca.comcast.net ([67.160.201.246])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Jul 2008 18:42:17 +0000
Received: from dpejesh by c-67-160-201-246.hsd1.ca.comcast.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Jul 2008 18:42:17 +0000
From: David Shane Holden <dpejesh@yahoo.com>
Date: Tue, 15 Jul 2008 11:42:05 -0700
Message-ID: <g5ir1u$14n$1@ger.gmane.org>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>	<g5g5vo$hok$1@ger.gmane.org>
	<20080715162400.GC12154@c2.user-mode-linux.org>
Mime-Version: 1.0
In-Reply-To: <20080715162400.GC12154@c2.user-mode-linux.org>
Subject: [SPAM] Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
To: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Mon, Jul 14, 2008 at 11:30:15AM -0700, David Shane Holden wrote:
>> I tried to build a UML 2.6.26 kernel on Debian (32-bit) and ran into the 
>> same problem reported here http://marc.info/?t=121011533500002&r=1&w=2. 
> 
> It's really 2.6.26, and not something from a day or two earlier?  I
> fixed the compilation bugs, supposedly, just before 2.6.26.

Yeah, it's a vanilla 2.6.26, and when comparing it to 2.6.26-rc9 the 
only difference in arch/um was the change for no-unit-at-a-time.

> 
>>   If I use gcc 4.3 everything works fine, but if I use gcc 4.1 or 4.2, 
>> UML crashes on startup.
> 
> If the crash says ptrace in it, then I'm currently trying to figure
> out what's happening with that.

It's crashing in wait_stub_done just like the poster of the message was 
having, it appears gcc 4.1 and 4.2 need -fno-unit-at-a-time.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
