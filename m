Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VIHRI-0003vg-Ff
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Sep 2013 12:16:32 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VIHRF-0000o5-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Sep 2013 12:16:32 +0000
Message-ID: <522B1915.7060400@nod.at>
Date: Sat, 07 Sep 2013 14:16:21 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1376825409-18570-1-git-send-email-richard@nod.at>
	<1376825409-18570-4-git-send-email-richard@nod.at>
	<20130819093049.GA5918@redhat.com>
	<20130907121450.GA30644@redhat.com>
In-Reply-To: <20130907121450.GA30644@redhat.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 4/4] um: Run UML in it's own session.
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am 07.09.2013 14:14, schrieb Richard W.M. Jones:
> On Mon, Aug 19, 2013 at 10:30:49AM +0100, Richard W.M. Jones wrote:
>> On Sun, Aug 18, 2013 at 01:30:09PM +0200, Richard Weinberger wrote:
>>> If UML is not run by a shell it can happen that UML
>>> will kill unrelated proceses upon a fatal exit because
>>> it issues a kill(0, ...).
>>> To prevent such oddities we create a new session in main().
>>>
>>> Cc: rjones@redhat.com
>>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>
>> I tested this using the "debug segv" test script that I previously
>> posted on the user-mode-linux mailing list, and this problem is now
>> fixed.  Therefore:
>>
>> Tested-by: Richard W.M. Jones <rjones@redhat.com>
>>
>> Thanks for these great fixes!
> 
> I've been using these 4 patches rebased on top of successive Linux
> HEAD's for nearly a month, and they work great.
> 
> But they don't seem to be going upstream, and they are necessary for
> people who want to use the UML backend with libguestfs (which has
> garnered some interest).  Anything I can do to help this happen?

Sure they are.
https://lkml.org/lkml/2013/9/7/52

Thanks,
//richard


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

